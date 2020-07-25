//
//  MainTabBarController.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/23.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if User.currentUser() != nil {
            configureTabController()
        }
        
        
    }
    
    private func configureTabController() {
        
        let cardVC = CardViewController()
        let nav1 = createnavConroller(image: nil, title: "Cards", rootViewController: cardVC)
        
        
        let settingVC = createnavConroller(image: nil, title: "Setting", rootViewController: SettingsViewController(user: User.currentUser()!))
        
        viewControllers = [nav1,settingVC]
        UITabBar.appearance().tintColor = .black
        tabBar.unselectedItemTintColor = .lightGray
        
        
    }
    
    private func createnavConroller(image : UIImage?, title : String, rootViewController  : UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        appearence.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
        appearence.backgroundColor = .systemGroupedBackground
        
        appearence.shadowColor = .clear
        
        nav.navigationBar.standardAppearance = appearence
        nav.navigationBar.compactAppearance = appearence
        nav.navigationBar.scrollEdgeAppearance = appearence
        
        nav.navigationBar.tintColor = .black
        nav.navigationBar.layer.borderColor = UIColor.white.cgColor
        
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        
        return nav
    }
}
