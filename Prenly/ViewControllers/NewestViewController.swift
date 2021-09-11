//
//  NewestViewController.swift
//  Prenly
//
//  Created by Luka Ivkovic on 9/9/21.
//

import UIKit

class NewestViewController: UIViewController {

    @IBOutlet weak var newsCollectionView: NewsCV!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsCollectionView.loadData(urlString: Constants.EVERYTHING_BASE_URL + "qInTitle=a" + "&sortBy=publishedAt" + "&apiKey=" + Constants.API_KEY)
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
    
    

}
