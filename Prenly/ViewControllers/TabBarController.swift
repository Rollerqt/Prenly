//
//  TabBarController.swift
//  Prenly
//
//  Created by Luka Ivkovic on 10/09/2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.share(_:)), name: NSNotification.Name(rawValue: "share"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.openPost(_:)), name: NSNotification.Name(rawValue: "openPost"), object: nil)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            guard let barItemView = item.value(forKey: "view") as? UIView else { return }

            let timeInterval: TimeInterval = 0.5
            let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
                barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
            }
            propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
            propertyAnimator.startAnimation()
        }
    
    @objc func share(_ notification: NSNotification) {
        let message = "Take a look at this!"
        //Set the link to share.
        if let link = NSURL(string: notification.userInfo?["url"] as! String)
        {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @objc func openPost(_ notification: NSNotification) {
        let post = notification.userInfo?["post"] as! Post
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "postVC") as! PostViewController
        newViewController.post = post
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }

}
