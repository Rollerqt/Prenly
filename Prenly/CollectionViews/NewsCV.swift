//
//  NewsCV.swift
//  Prenly
//
//  Created by Luka Ivkovic on 10/09/2021.
//

import UIKit

class NewsCV: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var posts = [Post]()
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            self.dataSource = self
            self.delegate = self
    }
    
    func loadData(urlString: String) {
        //1. Set URL parameters
        if let url = URL(string: urlString) {

                // 2. Create a URLSession
                let session = URLSession(configuration: .default)

                // 3. Give the session a task
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error == nil {
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            do {
                                //print(response)
                                let results = try decoder.decode(Results.self, from: safeData)
                                //print(results)
                                //Update must happen on the main thread, not in the background
                                DispatchQueue.main.async {
                                    self.posts = results.articles
                                    self.reloadData()
                                }
                            } catch {
                                print(error)
                            }
                        }
                    }
                }

                // 4. Start the task
                task.resume()
            }
    }
    func loadFavorites(){
        let userDefaults = UserDefaults.standard
        var counter = 0
        if  userDefaults.object(forKey: "counter") != nil {
            counter = userDefaults.integer(forKey: "counter")
        } else {
            return
        }
        
        var post = Post.init()
        for i in 0 ... counter {
            let p = counter - i - 1
            post.author = userDefaults.string(forKey: "author" + String.init(p))
            post.content = userDefaults.string(forKey: "content" + String.init(p))
            post.description = userDefaults.string(forKey: "description" + String.init(p))
            post.source = Source.init(id: userDefaults.string(forKey: "sourceId" + String.init(p)))
            post.publishedAt = userDefaults.string(forKey: "publishedAt" + String.init(p))!
            post.title = userDefaults.string(forKey: "title" + String.init(p))!
            post.urlToImage = userDefaults.string(forKey: "urlToImage" + String.init(p))
            post.url = userDefaults.string(forKey: "url" + String.init(p))!
            posts.append(post)
        }
        self.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //creating PreviewCell and filling it out with the data
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "previewCell", for: indexPath as IndexPath) as! PreviewCell
        
        let post = posts[indexPath.row]
        cell.post = post
        
        cell.labelTitle.text = post.title
        if !(post.author?.elementsEqual("") ?? true){
            //The author string gives back options of authors, I'm choosing the default one
            cell.labelAuthor.text = String.init(post.author!.split(separator: ",")[0])
        } else {
            cell.labelAuthor.text = "Unknown"
        }
        
        let split = post.publishedAt.split(separator: "T")
        let date = String.init(split[0])
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: now)
        
        let time = String(split[1]).split(separator: ":")
        if date.elementsEqual(currentDate) {
            cell.labelDate.text = String(time[0] + ":" + time[1])
        } else {
            cell.labelDate.text = date
        }
        
        if !(post.urlToImage?.isEmpty ?? true) {
            if post.urlToImage!.contains(".jpg") {
                cell.image.loadFromURL(urlString: post.urlToImage!)
            } else {
                cell.image.loadFromURL(urlString: Constants.NO_IMAGE)
            }
        } else {
            cell.image.loadFromURL(urlString: Constants.NO_IMAGE)
        }
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = CGColor.init(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
   
}

//since there is always a problem with asynchronous loading data with images,
//I am using the extension with cache. It also prevents the app from
//loading the picture from one item multiple times, it loads it just once,
//saving energy and making everything look and work professionally
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadFromURL(urlString: String) {
        let url = URL(string: urlString)
        
        image = nil
        
        //checks if image is already loaded, preventing unnecessary energy consumption
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        if url == nil {
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                
                //doing this to prevent loading image every time cell is visible
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                
                self.image = imageToCache
            }
            
        }.resume()
    }
}
