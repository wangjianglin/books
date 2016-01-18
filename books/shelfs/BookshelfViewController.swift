//
//  BooksViewController.swift
//  reader
//
//  Created by lin on 14-9-12.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import Foundation
import UIKit
import LinCore
import LinUtil


//public class BookshelfCell : JASwipeCell{
//    
//}

public class BookshelfViewController:UIViewController{
    
    public var documentSelected:((document:PdfDocument!)->())?{
        didSet{
            if let shelfView = self.shelfView{
                shelfView.selected = self.documentSelected;
            }
        }
    }
    
    public var shelfSelected:((shelf:Bookshelf)->())?;
    
    private var shelfView:BookshelfView!;
    public init(books:Bookshelfs) {
        super.init(nibName: nil, bundle: nil);
        self.books = books;
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var books:Bookshelfs?{
    didSet{
    
    }
    }
    
//    private var classButton:UIBarButtonItem!;
    private var editButton:UIBarButtonItem!;
    private var wifiButton:UIBarButtonItem!;
    private var titleButton:UIButton!;
    private var doneButton:UIBarButtonItem!;
    private var moveButton:UIBarButtonItem!;
    private var deleteButton:UIBarButtonItem!;
    private var segmentedButton:UIBarButtonItem!;
    
    private var edited:Bool = false{
        didSet{
            self.shelfView.edited = edited;
            if(edited){
                self.navigationItem.rightBarButtonItems = [deleteButton,moveButton];
                
                self.navigationItem.leftBarButtonItem = doneButton;
            }else{
                self.navigationItem.rightBarButtonItems = [segmentedButton,wifiButton];
                self.navigationItem.leftBarButtonItem = editButton;
            }
        }
    }
    
    
    private func titleView(){
        let frame = CGRectMake(0.0, 0.0, 200.0, self.navigationController!.navigationBar.bounds.size.height);
        
        titleButton = UIButton();
        titleButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        titleButton.frame = frame;
        
        titleButton.addActionForEvent(UIControlEvents.TouchUpInside, action: {[weak self] (sender:AnyObject) -> () in
            self?.classButtonClick();
            });
    }
     override public func viewDidLoad() {
        super.viewDidLoad();
        titleView();
        self.navigationItem.titleView = titleButton;
        
        
        editButton = UIBarButtonItem();
        editButton.title = "编 辑";
    
        editButton.setDelegateAction(){[weak self](_:AnyObject) in
            self?.edited = true;
        }
        
        doneButton = UIBarButtonItem();
        doneButton.title = "完 成";
        doneButton.setDelegateAction(){[weak self](_:AnyObject) in
            self?.edited = false;
        }
        
        
        moveButton = UIBarButtonItem();
        moveButton.title = "移 动";
//        moveButton.setDelegateAction(){[weak self](_:AnyObject) in
////            if let _self = self {
////                
////            }
//        }
        
        deleteButton = UIBarButtonItem();
        deleteButton.title = "删 除";
//        deleteButton.setDelegateAction(){[weak self](_:AnyObject) in
////            if let _self = self {
////                
////            }
//        }
        
        let wifiBtn: UIButton = UIButton(type: UIButtonType.Custom);
        //        var btn = UIButton();
        
        wifiBtn.frame = CGRectMake(0, 0, 28, 20);
        
        wifiBtn.setBackgroundImage(UIImage(named: "resources.bundle/pdf/wifi.png"), forState: UIControlState.Normal);
        wifiBtn.addActionForEvent(UIControlEvents.TouchUpInside) {[weak self] (send) -> () in
            self?.wifiSelected();
        }
        wifiButton = UIBarButtonItem(customView: wifiBtn);
        
        
        let segmented:UISegmentedControl = UISegmentedControl(items: ["a","b"]);
        segmented.frame = CGRectMake(0, 0, 128, 20);
        
//        segmented.setBackgroundImage(UIImage(named: "resources.bundle/pdf/wifi.png"), forState: UIControlState.Normal);
//        segmented.addActionForEvent(UIControlEvents.TouchUpInside) {[weak self] (send) -> () in
//            //self?.catalogSelected();
//        }
        segmentedButton = UIBarButtonItem(customView: segmented);
        
        
        
        self.shelfView = BookshelfView(shelf:nil);
        shelfView.selected = self.documentSelected;
        
        self.view.addSubview(self.shelfView!);
        
        self.shelfView?.translatesAutoresizingMaskIntoConstraints = false;
        
        self.view.addConstraints([
            NSLayoutConstraint(item: shelfView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: shelfView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: shelfView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: shelfView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
            ]);
        
        self.view.bringSubviewToFront(self.shelfView!);
        
        if let sel = self.books?.selected {
            self.classSelected(sel);
        }
        
        
        
        self.edited = false;
    }
    

    private var popoverController:UIPopoverController?;
    private func classButtonClick(){
        let contentViewController:UIViewController = UIViewController();
        //contentViewController.view.backgroundColor = UIColor(red:0.95,green:0.95,blue:0.95,alpha:1.0);
        let pView = ClassView(shelfs:self.books!);
        pView.frame = CGRectMake(0,0,350.0, 500.0);
        pView.selected = self.classSelected;
        contentViewController.view = pView;
        
        popoverController = UIPopoverController(contentViewController:contentViewController);
        popoverController!.popoverContentSize = CGSizeMake(350.0, 500.0);
        
        let pos = CGRectMake(0, 0, self.titleButton.frame.width, self.titleButton.bounds.height-2);
        popoverController!.presentPopoverFromRect(pos, inView: self.titleButton, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true);
    }
    
    private func classSelected(shelf:Bookshelf){
        popoverController?.dismissPopoverAnimated(true);
//        self.navigationItem.title = shelf.name;
        
//        titleButton.setTitle(shelf.name, forState: UIControlState.Normal);
        
        let content:NSString = shelf.name;
        
        //        CGSize size =[content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        
        //        titleButton.
        var size = content.sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize(14)]);
        
        editButton.stopAnimation();
        editButton.stopAnimation();
        
        if(size.width < 150){
            size.width = 150;
        }
        
        let frame = CGRectMake(0.0, 0.0, size.width, self.navigationController!.navigationBar.bounds.size.height);
        self.titleButton.frame = frame;
//        self.navigationItem.titleView = titleButton;
        self.shelfView.shelf = shelf;
        self.books?.selected = shelf;
        self.shelfSelected?(shelf: shelf);
        Queue.asynQueue({ () -> () in
            NSThread.sleepForTimeInterval(0.1);
            Queue.mainQueue({[weak self] () -> () in
                
                self?.titleButton.setTitle(content as String, forState: UIControlState.Normal);
//                self?.editButton.startAnimation();
            })
        })
    }

    private func wifiSelected(){
        
        let vc:UIViewController = WifiViewController();
        vc.modalPresentationStyle = UIModalPresentationStyle.FormSheet;
        
        self.presentViewController(vc, animated: true, completion: nil);
    }
}