//
//  FavoritesViewController.swift
//  Prenly
//
//  Created by Luka Ivkovic on 9/9/21.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var newsCollectionView: NewsCV!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsCollectionView.loadFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 37/255, green: 73/255, blue: 130/255, alpha: 1)
        let logo = UIImage(named: "prenly.png")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }

}
