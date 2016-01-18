//
//  MainViewController.swift
//  books
//
//  Created by lin on 1/29/15.
//  Copyright (c) 2015 lin. All rights reserved.
//

import Foundation
import UIKit
import LinServer

public class MainViewontroller:UITabBarController{
    
//     var server:Server!;
    
    public override func viewDidLoad() {
        
//        server = Server();
//        server!.test();
        //消息
        //        var message:UIStoryboard = UIStoryboard(name: "Message", bundle: nil);
        //        var messageController = message.instantiateInitialViewController() as UIViewController;
        //        self.addChildViewController(messageController);
        //
        //        //客户
        //        var customer:UIStoryboard = UIStoryboard(name: "Customer", bundle: nil);
        //        var customerController = customer.instantiateInitialViewController() as UIViewController;
        //        self.addChildViewController(customerController);
        //
        //        //发现
        //        var discover:UIStoryboard = UIStoryboard(name: "Discover", bundle: nil);
        //        var discoverController = discover.instantiateInitialViewController() as UIViewController;
        //        self.addChildViewController(discoverController);
        
        
        let books = BooksViewController();
        self.addChildViewController(books);
        
        
//        var manage = ManageViewController();
//        self.addChildViewController(manage);
//        
//        
//        var sync = SyncViewController();
//        self.addChildViewController(sync);
        
        let resource = ResourceViewController();
        self.addChildViewController(resource);
        
//        var mine = MineViewController();
//        self.addChildViewController(mine);
        
        let set = SetViewController();
        self.addChildViewController(set);
        
        //发布
//        var publish:UIStoryboard = UIStoryboard(name: "Publish", bundle: nil);
//        var publishController = publish.instantiateInitialViewController() as UIViewController;
//        self.addChildViewController(publishController);
//        
//        //我的
//        var mine:UIStoryboard = UIStoryboard(name: "Mine", bundle: nil);
//        var mineController = mine.instantiateInitialViewController() as UIViewController;
//        self.addChildViewController(mineController);
        
        //        self.tabBar.backgroundColor = TABBAR_BACKGROUND_COLOR;
        
        
        //        var frame = CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height);
        //
        //        backView = UIView(frame:frame);
        //        backView?.backgroundColor = TABBAR_BACKGROUND_COLOR;
        //        self.tabBar.insertSubview(backView!,atIndex:0);
        //        self.tabBar.opaque = true;
        //
        //        self.setTabBarItem();
        
        
        //        self.setViewControllers([publishController,mineController],animated:true);
        //        self.tabBar.delegate = self;
    }
    
    private func setTabBarItem(){
        if let items = tabBar.items {
            for _ in items {
                //println("item:\(item)");
            }
        }
    }
    
    private var backView:UIView?;
    
    public override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews();
        let frame = CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height);
        
        backView?.frame = frame;
        
        if let items = tabBar.items {
            for _ in items {
                //println("item:\(item)");
            }
        }
    }
    
    //MARK:UITabBarDelegate
    
    //    public override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) // called when a new view is selected by the user (but not programatically)
    //    {
    //        //println("public override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!)");
    //    }
    //
    //        /* called when user shows or dismisses customize sheet. you can use the 'willEnd' to set up what appears underneath.
    //        changed is YES if there was some change to which items are visible or which order they appear. If selectedItem is no longer visible,
    //        it will be set to nil.
    //        */
    //
    //        public override func tabBar(tabBar: UITabBar, willBeginCustomizingItems items: [AnyObject]) // called before customize sheet is shown. items is current item list
    //        {
    //            //println("public override func tabBar(tabBar: UITabBar, willBeginCustomizingItems items: [AnyObject])");
    //    }
    //        public override func tabBar(tabBar: UITabBar, didBeginCustomizingItems items: [AnyObject]) // called after customize sheet is shown. items is current item list
    //        {
    //            //println("public override func tabBar(tabBar: UITabBar, didBeginCustomizingItems items: [AnyObject])");
    //    }
    //      override   public func tabBar(tabBar: UITabBar, willEndCustomizingItems items: [AnyObject], changed: Bool) // called before customize sheet is hidden. items is new item list
    //        {
    //            //println("override   public func tabBar(tabBar: UITabBar, willEndCustomizingItems items: [AnyObject], changed: Bool)");
    //    }
    //      override   public func tabBar(tabBar: UITabBar, didEndCustomizingItems items: [AnyObject], changed: Bool) // called after customize sheet is hidden. items is new item list
    //        {
    //            //println("override   public func tabBar(tabBar: UITabBar, didEndCustomizingItems items: [AnyObject], changed: Bool)");
    //    }
    
}
