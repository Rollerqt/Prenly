//
//  HeadlinesViewController.swift
//  Prenly
//
//  Created by Luka Ivkovic on 9/9/21.
//

import UIKit

class HeadlinesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var posts = [Post]()
    var categories = ["General", "Business", "Sports", "Science", "Entertainment", "Health", "Technology"]
    
    var selectedCategory = 0
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet var newsCollectionView: NewsCV!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.showsHorizontalScrollIndicator = false
        
        newsCollectionView.loadData(urlString: Constants.HEADLINES_BASE_URL + "country=" + Constants.COUNTRY_CODE + "&category=" + categories[selectedCategory] + "&apiKey=" + Constants.API_KEY)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 37/255, green: 73/255, blue: 130/255, alpha: 1)
        let logo = UIImage(named: "prenly.png")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath as IndexPath) as! CategoryCell
            
            cell.name.text = categories[indexPath.row]
            
            if indexPath.row == selectedCategory {
                cell.name.textColor = UIColor.init(red: 37/255, green: 73/255, blue: 130/255, alpha: 1)
                cell.name.font = UIFont.boldSystemFont(ofSize: 17.0)
                cell.decorLabel.isHidden = false
            } else {
                cell.name.textColor = UIColor.black
                cell.name.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.medium)
                cell.decorLabel.isHidden = true
            }
            
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = indexPath.row
        categoriesCollectionView.reloadData()
        newsCollectionView.loadData(urlString: Constants.HEADLINES_BASE_URL + "country=" + Constants.COUNTRY_CODE + "&category=" + categories[selectedCategory] + "&apiKey=" + Constants.API_KEY)
    }

}

