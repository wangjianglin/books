//
//  AppDelegate.swift
//  reader
//
//  Created by lin on 14-8-26.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import UIKit
import LinCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


//    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool{
        // Override point for customization after application launch.
        
//        var storyboard = UIStoryboard(name:"Lottery.iPad",bundle:nil);
//        
//        //        var storyboard:UIStoryboard = UIStoryboard();
//        var rootViewController = storyboard.instantiateViewControllerWithIdentifier("ViewController") as? UIViewController;
        
        let screenBounds = UIScreen.mainScreen().bounds;//[[UIScreen mainScreen] bounds];
        self.window = UIWindow(frame:screenBounds);//[[UIWindow alloc] initWithFrame:screenBounds];
        self.window!.backgroundColor = UIColor.whiteColor()
        //var rootViewController = (UIViewController)vc;
//        var rootViewController = MainViewontroller();
//        var rootNavigationController = UINavigationController(rootViewController: rootViewController)
        //
//        self.window!.rootViewController = rootNavigationController;
        
        self.window!.rootViewController = MainViewontroller()
        self.window!.makeKeyAndVisible();
        
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

    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        AlertView.show("内存不足！");
    }
}

