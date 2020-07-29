//
//  MainTabBarController.swift
//  MeetUp
//
//  Created by 酒井ゆうき on 2020/07/23.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkUserIsLogin()
        
        
    }
    
   private func configureTabController() {
    
    let cardVC = CardViewController()
    let nav1 = createnavConroller(image: nil, title: "Cards", rootViewController: cardVC)
    
    let notificationVC = NotificationController()
    let nav2 = createnavConroller(image: nil, title: "Likes", rootViewController: notificationVC)
    
    
    
    
    let settingVC = createnavConroller(image: nil, title: "Setting", rootViewController: SettingsViewController(user: User.currentUser()!))
    
    viewControllers = [nav1,nav2, settingVC]
    UITabBar.appearance().tintColor = .black
    tabBar.unselectedItemTintColor = .lightGray
    
    
    }
    
    func checkUserIsLogin() {
        
        
        if Auth.auth().currentUser == nil {
            print("Nil")
            return
        } else {
            
            
            if UserDefaults.standard.object(forKey: kCURRENTUSER) == nil {
                /// set currentUser
          
                fetchCurrentUser(uid: Auth.auth().currentUser!.uid)
                
                return
            }
            
            configureTabController()
            
        }
    }
    
    private func fetchCurrentUser(uid : String) {
        
        FIrebaseListner.saherd.downloadCurrnetuserFromFirestore(uid: uid) { (error) in
            print("current")
            self.configureTabController()
        }
   
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
