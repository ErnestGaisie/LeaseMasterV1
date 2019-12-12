//
//  TabBarViewController.swift
//  LeaseMaster
//
//  Created by user on 28/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

class TabBarViewController:  UITabBarController, UITabBarControllerDelegate {
    
    var isUserLoggedIn : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        UITabBar.appearance().tintColor = .orange
//         Do any additional setup after loading the view.
        
        let HomeStoryboard: UIStoryboard = UIStoryboard.init(name: "HomeModuleStoryboard", bundle: nil)
        let homeScreen = (HomeStoryboard.instantiateViewController(withIdentifier: "navi") as? UINavigationController)!
        let SaveStoryboard: UIStoryboard = UIStoryboard.init(name: "SavedProperty", bundle: nil)
        let savedScreen = (SaveStoryboard.instantiateViewController(withIdentifier: "savedNavigation") as? UINavigationController)!

        let MainStoryboard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let loginScreen = (MainStoryboard.instantiateViewController(withIdentifier: "loginNavigationController") as? UINavigationController)!

       
        let AccountStoryboard: UIStoryboard = UIStoryboard.init(name: "Profile", bundle: nil)
                      let accountScreen = (AccountStoryboard.instantiateViewController(withIdentifier: "accountNavigation") as? UINavigationController)!

        homeScreen.tabBarItem.image = UIImage(named: "shape")
        homeScreen.tabBarItem.selectedImage = UIImage(named: "shape")

        savedScreen.tabBarItem.image = UIImage(named: "bookmark-border-24-px")
        savedScreen.tabBarItem.selectedImage = UIImage(named: "bookmark-border-24-px")

        loginScreen.tabBarItem.image = UIImage(named: "user-loggedout-inactive")
        loginScreen.tabBarItem.selectedImage = UIImage(named: "user-loggedout-inactive")

        accountScreen.tabBarItem.image = UIImage(named: "user-loggedin-active")
        accountScreen.tabBarItem.selectedImage = UIImage(named: "user-loggedin-active")


        if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == false{
            viewControllers = [homeScreen, savedScreen, loginScreen]
        tabBar.items![0].title = "Explore"
        tabBar.items![1].title = "Saved"
        tabBar.items![2].title = "Login"
//             self.viewControllers?.remove(at: 2)
        }

        else if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true{
            viewControllers = [homeScreen, savedScreen, accountScreen ]
            tabBar.items![0].title = "Explore"
           
            tabBar.items![1].title = "Saved"
            tabBar.items![2].title = "Account"
        }
        
//        func removeTab(at index: Int) {
//            guard let viewControllers = self.tabBarController?.viewControllers as? NSMutableArray else { return }
//            viewControllers.removeObject(at: index)
//            self.tabBarController?.viewControllers = (viewControllers as! [UIViewController])
//        }

             for tabBarItem in tabBar.items! {
//                tabBar.selectedItem?.badgeColor = .LeaseMasterOrange
                tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -10
                    , right: 0)
    }


}


}
