//
//  PostViewController.swift
//  Prenly
//
//  Created by Luka Ivkovic on 10/09/2021.
//

import UIKit

class PostViewController: UIViewController {
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var btnShare: UIButton!
    
    @IBOutlet var labelAuthor: UILabel!
    @IBOutlet var labelTime: UILabel!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelText: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet weak var btnLink: UIButton!
    
    var post : Post = Post.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
    }
    
    func loadUI() {
        //Just representing the post data in UI
        
        if !(post.author?.elementsEqual("") ?? true) {
            labelAuthor.text = "Author: " + String.init(post.author!.split(separator: ",")[0])
        } else {
            labelAuthor.text = "Author: Unknown"
        }
        
        labelTime.text = post.publishedAt.replacingOccurrences(of: "T", with: " ").replacingOccurrences(of: "Z", with: "")
        labelTitle.text = post.title
        
        if !(post.urlToImage?.isEmpty ?? true) {
            if post.urlToImage!.contains(".jpg") {
                image.loadFromURL(urlString: post.urlToImage!)
            } else {
                image.loadFromURL(urlString: Constants.NO_IMAGE)
            }
        } else {
            image.loadFromURL(urlString: Constants.NO_IMAGE)
        }
        
        //Content is only 200 characters, paid version of the News API allows to get full content
        if !(post.content?.elementsEqual("") ?? true) {
            labelText.text = post.content
        } else {
            labelText.text = "Content unavailable"
        }
        
        btnLink.setTitle("Source: " + post.url, for: .normal)
    }
    
    @IBAction func linkClicked(_ sender: Any) {
        let url = URL(string: post.url)!
        UIApplication.shared.open(url)
    }
    
    @IBAction func shareClicked(_ sender: Any) {
        let message = "Take a look at this!"
        //Set the link to share.
        if let link = NSURL(string: post.url)
        {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            //Excluding those two, it's a link(string)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
