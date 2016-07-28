//
//  AppDelegate.swift
//  Ant Planner
//
//  Created by Desperado on 7/4/28 H.
//  Copyright © 28 Heisei Ant Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        /* 我把splitview删掉了，相应的code我comment掉了。
         let splitViewController = self.window!.rootViewController as! UISplitViewController
         let leftNavController = splitViewController.viewControllers.first as! UINavigationController
         let masterViewController = leftNavController.topViewController as! MasterViewController
         let rightNavController = splitViewController.viewControllers.last as! UINavigationController
         let rootViewController = rightNavController.topViewController as! DetailViewController
         //
         let firstPlan = masterViewController.plans.first
         rootViewController.plan = firstPlan
         //
         masterViewController.delegate = rootViewController
         rootViewController.navigationItem.leftItemsSupplementBackButton = true
         rootViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        */
        
        /*
        下面这句也需要做相应的修改吧？因为我不太清楚应该怎么改，所以没有动
        let firstPlan = masterViewController.plans.first
        rootViewController.plan = firstPlan
        */
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        return true
    }

    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

