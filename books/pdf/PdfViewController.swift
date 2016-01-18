//
//  PdfViewController.swift
//  reader
//
//  Created by lin on 14-8-26.
//  Copyright (c) 2014年 lin. All rights reserved.
//


////获取屏幕亮度
////        var bl = CFPreferencesCopyAppValue("SBBacklightLevel","com.apple.springboard");
////        println("value:\(bl)");
////
////        GSEventSetBacklightLevel(0.3);//设置屏幕亮度
//
////        [UIScreen mainScreen].brightness
//
//println("brightness:\(UIScreen.mainScreen().brightness)");
//UIScreen.mainScreen().brightness = 0.3;

import Foundation
import UIKit
import LinCore

private let PAGING_VIEWS:Int = 3;

//let STATUS_HEIGHT:CGFloat = 20.0;
//
//let TOOLBAR_HEIGHT:CGFloat = 44.0;
//let PAGEBAR_HEIGHT:CGFloat = 48.0;
//
//let TAP_AREA_SIZE:CGFloat = 48.0;

public class PdfViewController: UINavigationController {
    
    
    public var document:PdfDocument{
        get{return self.rootViewController.document;}
    }
    public var back:(()->())?{
        get{return self.rootViewController.back;}
        set{self.rootViewController.back = newValue;}
    }
    public var pageChanged:((UInt)->())?{
        get{return self.rootViewController.pageChanged;}
        set{self.rootViewController.pageChanged = newValue;}
    }
    
    private var rootViewController:PdfRootViewController!;
    init(document:PdfDocument,pageNo:UInt = 0){
//        self._document = document;
//        super.init(nibName: nil, bundle: nil);
//        self.pageNo = pageNo;
        let rootViewController = PdfRootViewController(document: document, pageNo: pageNo);
        super.init(rootViewController: rootViewController);
        self.rootViewController = rootViewController;
    }

    
    private override init(nibName: String?, bundle: NSBundle?){
        super.init(nibName: nibName, bundle: bundle);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

public class PdfRootViewController : UIViewController,UIGestureRecognizerDelegate{//UIPageViewControllerDataSource,UIScrollViewDelegate, ,UIPageViewControllerDelegate{//,MFMailComposeViewControllerDelegate{
    
    private var document:PdfDocument;
    private var back:(()->())?;
    private var pageNo:UInt = 0;// {

    private var pageCount:UInt = 0;
    private var thumbView:PdfThumbsView!;
    
    private init(document:PdfDocument,pageNo:UInt = 0){
        self.document = document;
        super.init(nibName: nil, bundle: nil);
        self.pageNo = pageNo;
        self.navigationItem.title = document.name;
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var pageChanged:((UInt)->())?;
    
    private func pageViewPageChanged(page:UInt){
        self.thumbView!.pageStatus(Int(page));
        if let pageChanged = self.pageChanged{
            pageChanged(page);
        }
    }
    
    @objc public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool{
        if(touch.view is UIScrollView){
            return true;
        }
        return false;
    }
    
    private var pageViewController:PdfPageViewController!;//{
    private func pageViewControllerPageChanged(page:UInt){
        if let pageChanged = self.pageChanged {
            pageChanged(page);
        }
    }
    
    private var continueButton:UIBarButtonItem!;
    private var booksButton:UIBarButtonItem!;
    private var catalogButton:UIBarButtonItem!;

    override public func viewDidLoad() {
        super.viewDidLoad();
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = UIColor(red:109/255, green:109/255, blue:109/255, alpha:1.0);
        
        booksButton = UIBarButtonItem();
        booksButton.title = "书 库  ";
        booksButton.setDelegateAction {[weak self] (send) -> () in
            if let back = self?.back {
                back();
            }
        }
        
        
        continueButton = UIBarButtonItem();
        continueButton.title = "  续 读";
        continueButton.setDelegateAction {[weak self] (send) -> () in
            self!.continueSelected();
        }
        
//        catalogButton = UIBarButtonItem();
//        catalogButton.title = "目 录";
//        catalogButton.setDelegateAction {[weak self] (send) -> () in
//            self!.catalogSelected();
//        }
        
//        UIImage* img=[UIImage imageNamed:@"ib_tb_icon_list.png"];
        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        let btn: UIButton = UIButton(type: UIButtonType.Custom);
//        var btn = UIButton();
        
        btn.frame = CGRectMake(0, 0, 28, 16);
        
//        [btn setBackgroundImage:img forState:UIControlStateNormal];
        btn.setBackgroundImage(UIImage(named: "resources.bundle/pdf/mulu.png"), forState: UIControlState.Normal);
        btn.addActionForEvent(UIControlEvents.TouchUpInside) {[weak self] (send) -> () in
            self?.catalogSelected();
        }
//        btn.userInteractionEnabled = true;
//        btn.setTitle("ok", forState: UIControlState.Normal);
        
//        
//        [btn addTarget: self action: @selector(exitAction) forControlEvents: UIControlEventTouchUpInside];
//        
//        UIBarButtonItem* item=[[UIBarButtonItemalloc]initWithCustomView:btn
        catalogButton = UIBarButtonItem(customView: btn);
        
//        catalogButton.setDelegateAction {[weak self] (send) -> () in
//            self?.catalogSelected();
//        }
        
        
        self.navigationItem.leftBarButtonItems = [booksButton,catalogButton];
        
//        self.navigationItem.rightBarButtonItem = catalogButton;
        
        

        self.pageViewController = PdfPageViewController(document:self.document,pageNo:self.pageNo);
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController.view)
        
        self.pageViewController.pageChanged = {[weak self](page:UInt) in
            self!.pageViewPageChanged(page);
        }
        
        self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addConstraints([
            NSLayoutConstraint(item: self.pageViewController.view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.LessThanOrEqual, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.pageViewController.view, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.pageViewController.view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.pageViewController.view, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
            ]);
        
        //var singleTapOne = UITapGestureRecognizer(target: self, action: "handleSingleTap:");
        let singleTapOne = UITapGestureRecognizer(){[weak self](_:AnyObject) in
            self!.fullScroll = !self!.fullScroll;
        };
        singleTapOne.numberOfTouchesRequired = 1;
        singleTapOne.numberOfTapsRequired = 1;
        self.pageViewController!.view.addGestureRecognizer(singleTapOne);
 
        thumbView = PdfThumbsView(document:self.document,initPageNo:Int(self.pageNo));
        thumbView!.pageChanged = {[weak self](page:UInt) in
            self!.pageViewController!.showPage(page);
        };
        self.view.addSubview(thumbView!);
        self.view.bringSubviewToFront(thumbView!);
        thumbView?.translatesAutoresizingMaskIntoConstraints = false;
        
        self.view.addConstraints([
            NSLayoutConstraint(item: thumbView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 48),
            NSLayoutConstraint(item: thumbView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: thumbView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: thumbView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
            ]);
        self.fullScroll = false;
//        Queue.asynQueue(){[weak self] in
//            NSThread.sleepForTimeInterval(1.0);
//            Queue.mainQueue({ () -> () in
//                self!.automaticallyAdjustsScrollViewInsets = true;
//            })
//            
//        };
//        self.toolbar = PdfMainToolbar(document:self.document);
//        self.toolbar.back = {[weak self] in
//            if let back = self!.back {
//                back();
//            }
//        }
//        self.view.addSubview(self.toolbar!);
//        
//        self.view.bringSubviewToFront(self.toolbar!);
//        
//        toolbar.setTranslatesAutoresizingMaskIntoConstraints(false);
//        self.view.addConstraints([
//            NSLayoutConstraint(item: toolbar, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: toolbar, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: toolbar, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: toolbar, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
//            ]);
//        
//        self.toolbar!.catalogSelected = {[weak self] in
//            self!.catalogSelected();
//        }
//        self.toolbar!.continueSelected = {[weak self] in
//            self!.continueSelected();
//        };
        
    }

    private func continueSelected(){
        UIView.animateWithDuration(0.5,delay:0.0,options:UIViewAnimationOptions(rawValue: 3 << 16 | 1<<1),animations:{() in
            self.catalogView!.alpha = 0;
            },completion:{[weak self](finished:Bool)in
//                self?.navigationItem.rightBarButtonItem = self.catalogButton;
                self?.navigationItem.leftBarButtonItems = [self!.booksButton,self!.catalogButton];
                self?.catalogView!.hidden = true;
            });
    }
    private var catalogView:CatalogView?;
    private func catalogSelected(){
        
        if self.catalogView == nil{
            catalogView = CatalogView(catalog:self.document.catalog);
            self.view.addSubview(catalogView!);
            
            catalogView?.translatesAutoresizingMaskIntoConstraints = false;
            self.navigationController!.view.addConstraints([
                NSLayoutConstraint(item: catalogView!, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: catalogView!, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: catalogView!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.navigationController!.navigationBar, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: catalogView!, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
                ]);
            
            self.view.bringSubviewToFront(catalogView!);
            catalogView!.pageChanged = {(page:UInt)->()in
                    UIView.animateWithDuration(0.5,delay:0.0,options:UIViewAnimationOptions(rawValue: 3 << 16 | 1<<1),animations:{() in
                        self.catalogView!.alpha = 0;
                        },completion:{(finished:Bool)in
                            self.catalogView!.hidden = true;
                            self.navigationItem.rightBarButtonItem = self.catalogButton;
                        });
                self.pageViewController!.showPage(page);
            };
            
            catalogView?.hidden = true;
        }
//        self.navigationItem.rightBarButtonItem = self.continueButton;
        
//        if let catalogView = self.catalogView{
            UIView.animateWithDuration(0.5,delay:0.0,options:UIViewAnimationOptions(rawValue: 3 << 16 | 1<<1),animations:{() in
                
                },completion:{[weak self](finished:Bool)in
                    self?.catalogView!.alpha = 1;
                    self?.catalogView!.hidden = false;
//                    self.navigationItem.rightBarButtonItem = self.continueButton;
                    self?.navigationItem.leftBarButtonItems = [self!.booksButton,self!.continueButton];
            });
//            return;
//        }
    }
    
//    private func thumbViewPageChanged(page:UInt){
//        self.pageViewController!.showPage(page);
//    }
    private var fullScroll:Bool = false{
        didSet{
            if fullScroll {
                thumbView.hide();
                UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade)
                self.navigationController?.navigationBar.hidden = true;
            }else{
                thumbView.show();
                UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade);
                self.navigationController?.navigationBar.hidden = false;
            }
        }
    }
//    func handleSingleTap(recognizer:UITapGestureRecognizer)
//    {
//        println("handle single tap.");
//        if let thumbView = self.thumbView{
//            if thumbView.hidden{
//                thumbView.show();
//            }else{
//                thumbView.hide();
//            }
//        }
//        
//        if let toolbar = self.toolbar{
//            if toolbar.hidden{
//                toolbar.show();
//                UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade);//.setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
//            }else{
//                toolbar.hide();
//                UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade);
//            }
//        }
//    }
    
//    private func toolbarBack(){
//        if let back = self.back {
//            back();
////            self.toolbar.back = nil;
//            self.toolbar = nil;
//        }
//    }
//    private var toolbar:PdfMainToolbar!;


//    
//    deinit{
//        println("======================================================");
//    }
}