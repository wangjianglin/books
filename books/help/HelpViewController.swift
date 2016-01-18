//
//  HelpViewController.swift
//  books
//
//  Created by lin on 1/29/15.
//  Copyright (c) 2015 lin. All rights reserved.
//

import Foundation
import UIKit

public class HelpViewController: UINavigationController {
    
    public init(){
        let rootViewController = HelpRootViewController();
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
        self.tabBarItem.title = "帮助";
    }
}

public class HelpRootViewController:UIViewController{
    private init(){
        super.init(nibName: nil, bundle: nil);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override public func viewDidLoad() {
        super.viewDidLoad();
        self.navigationItem.title = "帮助";
    }
}
