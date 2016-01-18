//
//  WifiViewController.swift
//  books
//
//  Created by lin on 9/23/15.
//  Copyright © 2015 lin. All rights reserved.
//

import UIKit


public class WifiViewController : UINavigationController{
    public init(){
        super.init(rootViewController: WifiRootViewController());
    }

    private override init(nibName: String?, bundle: NSBundle?){
        super.init(nibName: nibName, bundle: bundle);
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class WifiRootViewController : UIViewController{
    public init(){
        super.init(nibName: nil,bundle:nil);
        
        self.navigationItem.title = "WiFi管理";
        
        let closeButton:UIBarButtonItem = UIBarButtonItem();
        closeButton.title = "关闭";
        closeButton.setDelegateAction { [weak self](send) -> () in
            self?.dismissViewControllerAnimated(true, completion: nil);
        };
        
        
        self.navigationItem.rightBarButtonItem = closeButton;
        
        self.initView();
    }
    
    private func initView(){
//        -(NSString *)getAddress {
//            
//            char iphone_ip[255];
//            
//            strcpy(iphone_ip,"127.0.0.1"); // if everything fails
//            
//            NSHost* myhost =[NSHost currentHost];
//        NSHos
//
//            if (myhost)
//                
//            {
//                
//                NSString *ad = [myhost address];
//                
//                if (ad)
//                
//                strcpy(iphone_ip,[ad cStringUsingEncoding:NSASCIIStringEncoding]);
//                
//            }
//            
//            return [NSString stringWithFormat:@"%s",iphone_ip];
//            
//        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//public class WifiViewController : UIViewController{
//    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        self.initView();
//    }
//    
//    private func initView(){
//        self.view.backgroundColor = UIColor.whiteColor();
//        
//        let sep:UIView = UIView();
//        sep.backgroundColor = UIColor.blackColor();
//        self.view.addSubview(sep);
//        
//        sep.translatesAutoresizingMaskIntoConstraints = false;
//        
//        self.view.addConstraints([NSLayoutConstraint(item: sep, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 1.0),
//            NSLayoutConstraint(item: sep, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0),
//            NSLayoutConstraint(item: sep, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0),
//            NSLayoutConstraint(item: sep, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 40.0)]);
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}