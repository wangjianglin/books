//
//  SyncViewController.swift
//  books
//
//  Created by lin on 1/30/15.
//  Copyright (c) 2015 lin. All rights reserved.
//

import Foundation
import UIKit

public class SyncViewController: UINavigationController {
    
    public init(){
        let rootViewController = SyncRootViewController();
        super.init(rootViewController: rootViewController);
    }
    
    private override init(nibName: String?, bundle: NSBundle?){
        super.init(nibName: nibName, bundle: bundle);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        
        self.tabBarItem = UITabBarItem();
        self.tabBarItem.title = "同步";
    }
}

public class SyncRootViewController:UIViewController{
    private init(){
        super.init(nibName: nil, bundle: nil);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override public func viewDidLoad() {
        super.viewDidLoad();
        self.navigationItem.title = "同步";
    }
}
