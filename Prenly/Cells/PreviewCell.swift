//
//  CollectionViewCell.swift
//  Prenly
//
//  Created by Luka Ivkovic on 09/09/2021.
//

import UIKit

protocol ViewTappedDelegate: class {
     func viewTapped(_ photo : String)
   }

class PreviewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var content: UIView!
    
    var post : Post = Post.init()
    
    weak var delegate : ViewTappedDelegate?
    
    override func awakeFromNib() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        tapGesture.delegate = self
        content.isUserInteractionEnabled = true
        content.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(recognizer:UITapGestureRecognizer) {
        let data:[String: Post] = ["post": post]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openPost"), object: nil, userInfo: data)
    }
    
    @IBAction func starClicked(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        let counter = userDefaults.integer(forKey: "counter")
        userDefaults.setValue(post.author, forKey: "author" + String.init(counter))
        userDefaults.setValue(post.description, forKey: "description" + String.init(counter))
        userDefaults.setValue(post.publishedAt, forKey: "publishedAt" + String.init(counter))
        userDefaults.setValue(post.source.id, forKey: "sourceId" + String.init(counter))
        userDefaults.setValue(post.title, forKey: "title" + String.init(counter))
        userDefaults.setValue(post.url, forKey: "url" + String.init(counter))
        userDefaults.setValue(post.urlToImage, forKey: "urlToImage" + String.init(counter))
        userDefaults.setValue(counter + 1, forKey: "counter")
        btnStar.setImage(UIImage(named: "starFill.png"), for: .normal)
        
    }
    
    @IBAction func shareBtnClicked(_ sender: Any) {
        let data:[String: String] = ["url": post.url]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "share"), object: nil, userInfo: data)
    }
    
    
}
