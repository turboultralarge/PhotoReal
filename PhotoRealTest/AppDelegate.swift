//
//  AppDelegate.swift
//  PhotoRealTest
//
//  Created by Travis Abendshien on 4/3/19.
//  Copyright © 2019 Travis Abendshien. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        // Initialize Parse
        // Set applicationId and server based on the values in the Heroku settings.
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "photorealer"
                configuration.server = "http://photorealer.herokuapp.com/parse"
            })
        )
        
        if PFUser.current() != nil {
            let main = UIStoryboard(name: "Main", bundle: nil)
            let HomeNavigationController = main.instantiateViewController(withIdentifier: "HomeNavigationController")
            
            window?.rootViewController = HomeNavigationController
        }
    
        return true
    
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    //  Code that implements the Parse Server 4/4/19 - AR
    
    class AppDelegate: UIResponder, UIApplicationDelegate {
        
        // ...
    }


        
}
