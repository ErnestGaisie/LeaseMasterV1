//
//  AppDelegate.swift
//  LeaseMaster
//
//  Created by user on 21/10/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit
import CoreData
import GoogleSignIn
 import FBSDKCoreKit
import FBSDKLoginKit
import FacebookLogin
import FacebookCore


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
          GIDSignIn.sharedInstance().clientID = "125579355847-v8qo770ski5v4ddfe8dvetvd6rvlocgf.apps.googleusercontent.com"
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
              // Sets shadow (line below the bar) to a blank image
              UINavigationBar.appearance().shadowImage = UIImage()
              // Sets the translucent background color
              UINavigationBar.appearance().backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
              // Set translucent. (Default value is already true, so this can be removed if desired.)
              UINavigationBar.appearance().isTranslucent = true
              UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
              UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
              UINavigationBar.appearance().tintColor = .black
        
        let attributes = [NSAttributedString.Key.font:  UIFont(name: "Helvetica-Bold", size: 0.1)!, NSAttributedString.Key.foregroundColor: UIColor.clear]

        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for:UIBarMetrics.default)

       
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let appId: String = Settings.appID!
    if url.scheme != nil && url.scheme!.hasPrefix("fb\(appId)") && url.host ==  "authorize" {
    return ApplicationDelegate.shared.application(app, open: url, options: options)
    }
    return false
    }
    
func applicationDidBecomeActive(_ application: UIApplication) {
    AppEvents.activateApp()
}
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "LeaseMaster")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

