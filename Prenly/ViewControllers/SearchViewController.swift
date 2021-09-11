//
//  SearchViewController.swift
//  Prenly
//
//  Created by Luka Ivkovic on 9/9/21.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var viewEmpty: UIView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var newsCollectionView: NewsCV!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.showsScopeBar = true
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 37/255, green: 73/255, blue: 130/255, alpha: 1)
        let logo = UIImage(named: "prenly.png")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar) {
        let keyword = searchBar.text!
        
        newsCollectionView.loadData(urlString: Constants.EVERYTHING_BASE_URL + "qInTitle=" + keyword + "&apiKey=" + Constants.API_KEY)
        viewEmpty.isHidden = true
        newsCollectionView.isHidden = false
    }
}
