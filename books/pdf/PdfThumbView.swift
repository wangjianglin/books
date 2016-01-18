//
//  PdfThumbView.swift
//  books
//
//  Created by lin on 14-9-27.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import Foundation
import UIKit

//增加缓存功能
class PdfThumbView:UIView{
    
    var document:PdfDocument;
    var pageNo:UInt;
    
//    class var queue:Infos{
//        get{
//            //return _install;
//            struct YRSingleton{
//                static var predicate:dispatch_once_t = 0
//                static var instance:Infos? = nil
//            }
//            dispatch_once(&YRSingleton.predicate,{
//                YRSingleton.instance=Infos()
//                }
//            )
//            return YRSingleton.instance!
//    }
//    }
    
    init(frame:CGRect,document:PdfDocument,pageNo:UInt){
        self.document = document;
        self.pageNo = pageNo;
        super.init(frame:frame);
        self.backgroundColor = UIColor.whiteColor();
        
        let color = UIColor(red:159/255, green:159/255, blue:159/255, alpha:1.0).CGColor;
        let bottomBorder = CALayer();
        bottomBorder.frame = CGRectMake(0.0, self.frame.size.height-1.0, self.frame.size.width, 1.0);
        bottomBorder.backgroundColor = color;
        self.layer.addSublayer(bottomBorder);
        
        
        let upBorder = CALayer();
        upBorder.frame = CGRectMake(0.0, 0.0, self.frame.size.width, 1.0);
        upBorder.backgroundColor = color;
        self.layer.addSublayer(upBorder);
        
        let leftBorder = CALayer();
        leftBorder.frame = CGRectMake(0.0, 0.0, 1, self.frame.size.height);
        leftBorder.backgroundColor = color;
        self.layer.addSublayer(leftBorder);
        
        
        let rightBorder = CALayer();
        rightBorder.frame = CGRectMake(self.frame.size.width - 1.0, 0.0 , 1.0, self.frame.size.height);
        rightBorder.backgroundColor = color;
        self.layer.addSublayer(rightBorder);
        
        
        
//        var lock = NSLock();
        struct YRSingleton{
            static var predicate:dispatch_once_t = 0
            static var instance:NSLock? = nil
        }
        dispatch_once(&YRSingleton.predicate,{
            YRSingleton.instance = NSLock()
        })
        
        //对性能影响较大，暂时去掉
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
//            {()in
////                var image:UIImage! = self.document.image(pageNo,thumbSize:self.frame.size);
//                
//                YRSingleton.instance?.lock();//防止同步出现大量操作，降低性能
//                var imageRef = self.document.thumbnail(pageNo);
////                var image = UIImage(CGImage: imageRef)?.scaledToSize(size: self.frame.size);
//                var image = UIImage(CGImage: imageRef);
//                if(image != nil){
//                    image = image?.scaledToSize(size: self.frame.size);
//                }
//                            var imageView:UIImageView = UIImageView(image:image);
//                
//                            imageView.autoresizesSubviews = false;
//                            imageView.userInteractionEnabled = false;
//                            imageView.autoresizingMask = UIViewAutoresizing.None;
//                            imageView.contentMode = UIViewContentMode.ScaleAspectFit;
//                YRSingleton.instance?.unlock();
//                //dispatch_get_main_queue
//                dispatch_async(dispatch_get_main_queue(),
//                    {()in
//                        
//                        self.addSubview(imageView);
//                        self.sendSubviewToBack(imageView);
//                        //println("Current Thread = \(NSThread.currentThread())");
//                    });
//            });
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}