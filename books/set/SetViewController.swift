//
//  ManageViewController.swift
//  books
//
//  Created by lin on 1/30/15.
//  Copyright (c) 2015 lin. All rights reserved.
//

import Foundation
import UIKit

public class SetViewController: UISplitViewController {
    
    public init(){
//        var rootViewController = SetRootViewController();
//        super.init();
//        super.init(rootViewController: rootViewController);
        super.init(nibName: nil, bundle: nil);
        self.tabBarItem = UITabBarItem();
        self.tabBarItem.title = "设置";
    }
    
    private override init(nibName: String?, bundle: NSBundle?){
        super.init(nibName: nibName, bundle: bundle);
        self.tabBarItem = UITabBarItem();
        self.tabBarItem.title = "设置";
        
        
//        self.viewControllers = [SetRootViewController(),SetRootViewController()];
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        self.viewControllers = [SetMasterViewController()];
//        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad){
            self.showViewController(SetDetailViewController(), sender: nil);
        }
//        self.showViewController(ResourceViewController(), sender: nil);
//        self.preferredDisplayMode = UISplitViewControllerDisplayMode.Automatic;
    }
}

public class SetMasterViewController:UINavigationController{
    private init(){
        let rootViewController = SetMasterRootViewController();
        super.init(rootViewController: rootViewController);
    }
    
    private override init(nibName: String?, bundle: NSBundle?){
        super.init(nibName: nibName, bundle: bundle);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override public func viewDidLoad() {
        super.viewDidLoad();
        self.navigationItem.title = "设置";
    }
}

public class SetMasterRootViewController:UIViewController{
    private init(){
        super.init(nibName: nil, bundle: nil);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override public func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.grayColor();
        self.navigationItem.title = "设置";
    }
}


public class SetDetailViewController:UINavigationController{
    private init(){
        let rootViewController = SetDetailRootViewController();
        super.init(rootViewController: rootViewController);
    }
    
    private override init(nibName: String?, bundle: NSBundle?){
        super.init(nibName: nibName, bundle: bundle);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override public func viewDidLoad() {
        super.viewDidLoad();
        self.navigationItem.title = "Detail";
    }
}

public class SetDetailRootViewController:UIViewController{
    private init(){
        super.init(nibName: nil, bundle: nil);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override public func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.grayColor();
        self.navigationItem.title = "Detail";
    }
}
