//
//  BooksToolbar.swift
//  reader
//
//  Created by lin on 14-9-13.
//  Copyright (c) 2014年 lin. All rights reserved.
//

//import Foundation
//import UIKit
//import QuartzCore
//
//class BooksToolbar:UIView{
//    
//    var shelfs:Bookshelfs!;
//    
//    init(frame:CGRect,shelfs:Bookshelfs){
//        self.shelfs = shelfs;
//        super.init(frame:frame);
//        self.backgroundColor = UIColor(red:0.95,green:0.95,blue:0.95,alpha:1.0);
//        
//        
//        bottomBorder = CALayer();
//        var height=self.frame.size.height-1.0;
//        var width=self.frame.size.width;
//        bottomBorder.frame = CGRectMake(0.0, height, width, 1.0);
//        bottomBorder.backgroundColor = UIColor(red:109/255, green:109/255, blue:109/255, alpha:1.0).CGColor;
//        self.layer.addSublayer(bottomBorder);
//        
//        
//        var editButtonFrame = self.frame;
////        editButtonFrame.size.height -= STATUS_HEIGHT;
////        editButtonFrame.origin.y = STATUS_HEIGHT;
//        editButtonFrame.origin.x = editButtonFrame.size.width - 90;
//        editButtonFrame.size.width = 80;
//        
//        self.editButton = UIButton(frame:editButtonFrame);
//        editButton.setTitle("编 辑", forState:UIControlState.Normal);
//        editButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
//        self.addSubview(editButton);
//        
//        
//        var classButtonFrame = self.frame;
////        classButtonFrame.size.height -= STATUS_HEIGHT;
////        classButtonFrame.origin.y = STATUS_HEIGHT;
//        classButtonFrame.origin.x = 10;
//        classButtonFrame.size.width = 80;
//        
////        UIBarButtonItem *popoverButton = [[UIBarButtonItem alloc]
////            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
////            target:self
////            action:@selector(showPopover:)];
////        self.navigationItem.rightBarButtonItem = popoverButton;
//        // init(title: String!, style: UIBarButtonItemStyle, target: AnyObject!, action: Selector)
////        var classButton = UIBarButtonItem(title:"分 类",style: UIBarButtonItemStyle.Plain, target: self, action: "classButtonAction:");
//        var classButton = UIButton(frame:classButtonFrame);
//        classButton.setTitle("分 类", forState:UIControlState.Normal);
//        classButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
//        self.addSubview(classButton);
//        classButton.addTarget(self,action: "classButtonAction:", forControlEvents: UIControlEvents.TouchUpInside);
//        
//        
//        var lframe = self.bounds;
////        lframe.size.height -= STATUS_HEIGHT;
////        lframe.origin.y = STATUS_HEIGHT;
//        label = UILabel(frame:lframe);
//        if let shelf = shelfs.selected {
//            label!.text = shelf.name;
//        }
//        label!.textAlignment = NSTextAlignment.Center;
//        self.addSubview(label!);
//    }
//
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    var label:UILabel?;
//    
//    var popController:UIPopoverController?
//    
//    
//    var selected:((shelf:Bookshelf)->())?;
//    
////    var pView:ClassView?;
//    
//    func classSelected(shelf:Bookshelf){
//        
//        if let popController = self.popController{
//            popController.dismissPopoverAnimated(true);
//        }
//        if let label = self.label{
//            label.text = shelf.name;
//        }
//        if let selected = self.selected{
//            selected(shelf:shelf);
//        }
//        
//        self.shelfs.selected = shelf;
//    }
//    
//    func classButtonAction(button:UIButton){
//        var contentViewController:UIViewController = UIViewController();
//        //contentViewController.view.backgroundColor = UIColor(red:0.95,green:0.95,blue:0.95,alpha:1.0);
//        var pView = ClassView(shelfs:self.shelfs);
//        pView.frame = CGRectMake(0,0,350.0, 500.0);
//        pView.selected = self.classSelected;
//        contentViewController.view = pView;
//        
//        popController = UIPopoverController(contentViewController:contentViewController);
//        popController!.popoverContentSize = CGSizeMake(350.0, 500.0);
//        
//        var pos = button.frame;
//        pos.origin.y -= 5;
//        popController!.presentPopoverFromRect(pos, inView: self, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true);
//        
//        //self.popController = popController;
//        //popController.presentPopoverFromBarButtonItem(nil,permittedArrowDirections:UIPopoverArrowDirection.Up, animated: true);
//// func presentPopoverFromBarButtonItem(item: UIBarButtonItem!, permittedArrowDirections arrowDirections: UIPopoverArrowDirection, animated: Bool)
//        
////        popController.presentPopoverFromBarButtonItem:sender
////        permittedArrowDirections:UIPopoverArrowDirectionUp
////        animated:YES];
//    }
//    var editButton:UIButton!;
//    
//    var bottomBorder:CALayer!;
//    
//    override func layoutSubviews() {
//        var height=self.frame.size.height-1.0;
//        var width=self.frame.size.width;
//        bottomBorder.frame = CGRectMake(0.0, height, width, 1.0);
//        
//        
//        var editButtonFrame = self.frame;
////        editButtonFrame.size.height -= STATUS_HEIGHT;
////        editButtonFrame.origin.y = STATUS_HEIGHT;
//        editButtonFrame.origin.x = editButtonFrame.size.width - 90;
//        editButtonFrame.size.width = 80;
//        
//        self.editButton.frame = editButtonFrame;
//        
//        
//        var lframe = self.bounds;
////        lframe.size.height -= STATUS_HEIGHT;
////        lframe.origin.y = STATUS_HEIGHT;
//        label!.frame = lframe;
//
//        
//        super.layoutSubviews();
//    }
//}