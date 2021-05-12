//
//  CustomTabBarController.swift
//  FeedApp
//
//  Created by SawSMN's MacBook Pro on 12/5/21.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor = UIColor(red:0.12, green:0.13, blue:0.16, alpha:1)
        self.tabBar.tintColor = UIColor(red:1, green:1, blue:1, alpha:1)
        
        // setup our custom view controllers
        let feedController = UINavigationController(rootViewController:  FeedListCollectionViewController(collectionViewLayout:UICollectionViewFlowLayout()))
        feedController.tabBarItem.title = "New Feed"
        feedController.tabBarItem.image = UIImage(named: "home")
        
        
        viewControllers = [feedController]
    }
}

