//
//  PdfMainToolbar.swift
//  reader
//
//  Created by lin on 14-9-10.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import LinCore

//public class PdfMainToolbar:UIView{
//    
//    required public init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    private var _document:PdfDocument;
//    public var document:PdfDocument {
//        return _document;
//    }
//
//    public var back:(()->())?
//    
//    public init(frame:CGRect, document:PdfDocument){
//        self._document = document;
//        super.init(frame:frame);
//        initView();
//    }
//    
//    public init(document:PdfDocument){
//        self._document = document;
//        super.init(frame:CGRectMake(0, 0, 0, 0));
//        initView();
//    }
//    
//    private func initView(){
//        self.backgroundColor = UIColor(red:0.95,green:0.95,blue:0.95,alpha:1.0);
//        
//        var label = UILabel();
//        label.text = document.name;
//        label.textAlignment = NSTextAlignment.Center;
//        self.addSubview(label);
//        
//        label.setTranslatesAutoresizingMaskIntoConstraints(false);
//        
//        self.addConstraints([
//            NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
//            ]);
//        
//        var button:UIButton = UIButton();
//        button.setTitle("书 库", forState:UIControlState.Normal);
//        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
//        self.addSubview(button);
//        
//        button.addActionForEvent(UIControlEvents.TouchUpInside){[weak self] (send:AnyObject) in
//            if let back = self!.back{
//                back();
//            }
//        };
//        button.setTranslatesAutoresizingMaskIntoConstraints(false);
//        self.addConstraints([
//            NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 80),
//            NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 10),
//            NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
//            ]);
//        
//        continueButton = UIButton();
//        continueButton!.setTitle("续 读", forState:UIControlState.Normal);
//        continueButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
//        continueButton!.hidden = true;
//        self.addSubview(continueButton!);
//        
//        continueButton?.addActionForEvent(UIControlEvents.TouchUpInside){[weak self] (send:AnyObject) in
//            self!.continueButtonSelected(send as UIButton);
//        };
//        
//        continueButton.setTranslatesAutoresizingMaskIntoConstraints(false);
//        self.addConstraints([
//            NSLayoutConstraint(item: continueButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: continueButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 80),
//            NSLayoutConstraint(item: continueButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 80),
//            NSLayoutConstraint(item: continueButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
//            ]);
//        
//        
//        var bottomBorder = UIView();
//        bottomBorder.backgroundColor = UIColor(red:109/255, green:109/255, blue:109/255, alpha:1.0);
//        self.addSubview(bottomBorder);
//        bottomBorder.setTranslatesAutoresizingMaskIntoConstraints(false);
//        
//        self.addConstraints([
//            NSLayoutConstraint(item: bottomBorder, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: bottomBorder, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: bottomBorder, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: bottomBorder, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 1)
//            ]);
//        
//        var catalogButton = UIButton();
//        catalogButton.setTitle("目 录", forState:UIControlState.Normal);
//        catalogButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
//        self.addSubview(catalogButton);
//        catalogButton.addTarget(self,action: "showCatalog:", forControlEvents: UIControlEvents.TouchUpInside);
//        
//        catalogButton.setTranslatesAutoresizingMaskIntoConstraints(false);
//        self.addConstraints([
//            NSLayoutConstraint(item: catalogButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: catalogButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -10),
//            NSLayoutConstraint(item: catalogButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 80),
//            NSLayoutConstraint(item: catalogButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
//            ]);
//    }
//
//    
//    public var catalogSelected:(()->())?
//    public var continueSelected:(()->())?
//    
//    private var continueButton:UIButton!;
//    private func continueButtonSelected(button:UIButton){
//        if let continueSelected = self.continueSelected{
//            continueSelected();
//        }
//        UIView.animateWithDuration(0.5,delay:0.0,options:UIViewAnimationOptions(3 << 16 | 1<<1),animations:{() in
//            button.alpha = 0;
//            },completion:{(finished:Bool)in
//                button.hidden = true;
//            });
//    }
//    public func hideCatalog(){
//        if let continueButton = self.continueButton{
//            UIView.animateWithDuration(0.5,delay:0.0,options:UIViewAnimationOptions(3 << 16 | 1<<1),animations:{() in
//                continueButton.alpha = 0;
//                },completion:{(finished:Bool)in
//                    continueButton.hidden = true;
//                });
//        }
//    }
//    func showCatalog(_:UIButton){
//        if let catalogSelected = self.catalogSelected{
//            if let continueButton = self.continueButton{
//                UIView.animateWithDuration(0.5,delay:0.0,options:UIViewAnimationOptions(3 << 16 | 1<<1),animations:{() in
//                    
//                    },completion:{(finished:Bool)in
//                        continueButton.alpha = 1;
//                        continueButton.hidden = false;
//                    });
//            }
//            catalogSelected();
//        }
//    }
//    
//    
//    
//    func backButton(_:UIButton){
//        if let back = self.back{
//            back();
//        }
//    }
//    
//    public func hide(){
//        if hidden == false{
//            //hidden = true;
//            UIView.animateWithDuration(0.5,delay:0.0,options:UIViewAnimationOptions(3 << 16 | 1<<1),animations:{() in
//                self.alpha = 0;
//                },completion:{(finished:Bool)in
//                    self.hidden = true;
//                });
//        }
//    }
//    
//    public func show(){
//        if hidden == true{
//            //hidden = true;
//            UIView.animateWithDuration(0.5,delay:0.0,options:UIViewAnimationOptions(3 << 16 | 1<<1),animations:{() in
//                
//                },completion:{(finished:Bool)in
//                    self.alpha = 1;
//                    self.hidden = false;
//                });
//        }
//    }
//    deinit{
//        println("---------------------------------------------");
//    }
//}