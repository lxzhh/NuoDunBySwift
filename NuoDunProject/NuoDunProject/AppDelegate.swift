//
//  AppDelegate.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/6/20.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
[UIColor colorWithRed:1.000 green:0.799 blue:0.000 alpha:1.000]

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let userVC :NODUserViewController = UIStoryboard(name: "NODStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("NODUserViewController") as! NODUserViewController
        
        let mainVC :NODMainController = UIStoryboard(name: "NODStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("NODMainController") as! NODMainController
        let mainNavVC = UINavigationController(rootViewController: mainVC)
        let slideMenuController = SlideMenuController(mainViewController: mainNavVC, leftMenuViewController: userVC)
        self.window?.rootViewController = slideMenuController

        self.window?.makeKeyAndVisible()
        let loginVC :NODLoginViewController = UIStoryboard(name: "NODStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("NODLoginViewController") as! NODLoginViewController
        if((LoginUser.loadSaved()) == nil){
            self.window?.rootViewController?.presentViewController(loginVC, animated: false, completion: nil)
        }
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.157, green: 0.682, blue: 0.992, alpha: 1.000)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont.boldSystemFontOfSize(18)]
        SVProgressHUD.setBackgroundColor(UIColor(white: 0.000, alpha: 0.800))
        SVProgressHUD.setForegroundColor(UIColor.whiteColor())


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

