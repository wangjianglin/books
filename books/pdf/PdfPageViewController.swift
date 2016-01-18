//
//  PdfPageViewController.swift
//  books
//
//  Created by lin on 14-9-16.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import Foundation
import UIKit

class PdfPageViewController:UIViewController,UIScrollViewDelegate{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var document:PdfDocument!;
    var pview:UIView?;
    var contentScrollView:UIScrollView!;
    //var pageNo:UInt = UInt.max;
    var pageNo:UInt = 0{
    didSet{
        if oldValue != self.pageNo{
        if let pageChanged = self.pageChanged{
            pageChanged(page:self.pageNo);
        }
        }
    }
    }
    var pageViews:[PdfView?]!;
    var pageViewCount:UInt = 3;
    
    var pageChanged:((page:UInt)->())?;
    
    init(document:PdfDocument,pageNo:UInt = 0){
        self.document = document;
        self.pageNo = pageNo;
        super.init(nibName:nil, bundle:nil);
        //self.view.backgroundColor = UIColor.blueColor();
        
    }
    
    func scrollViewDidEndDecelerating(scrollView:UIScrollView){
        //println("scrollViewDidEndDecelerating(scrollView:UIScrollView)");
        let contentOffsetX:CGFloat = self.contentScrollView.contentOffset.x;
        var page:Int = 0;
        for (_,item) in self.contentViews.enumerate(){
            let tmp = item.frame.origin.x - contentOffsetX;
            let w = item.frame.size.width / 2 - 10;
            if tmp > -w && tmp < w {
                page = item.tag;
                //println("page:\(page)\n");
                self.showPage(UInt(page));
                return;
            }
        }
        //println("content offset x:\(contentOffsetX)");
        //self.pageNo = UInt(page);
        
//        contentViews.enumerateKeysAndObjectsUsingBlock( // Enumerate content views
//            {(key:AnyObject, object:AnyObject, stop:Bool)in
//        
//            PdfView *contentView = object;
//            
//            if (contentView.frame.origin.x == contentOffsetX)
//            {
//            page = contentView.tag; *stop = YES;
//            }
//        
//        );
    }
    var contentViews:[PdfView] = [];
    func showPage(pageNo:UInt,redraw:Bool = false){
        if pageNo == self.pageNo && self.contentViews.count != 0 && redraw == false {
            return;
        }
        //self.pageNo = pageNo;
        if pageNo >= self.document.pages{
            self.pageNo = self.document.pages - 1;
        }else{
            self.pageNo = pageNo;
        }
        
        var minvalue:UInt = self.pageNo;
        if minvalue > 0{
            minvalue -= 1;
        }
        var maxvalue:UInt = minvalue + self.pageViewCount - 1;
        if maxvalue >= self.document.pages{
            maxvalue = self.document.pages - 1;
            if(maxvalue + 1 > self.pageViewCount){
                minvalue = maxvalue + 1 - self.pageViewCount;
            }else{
                minvalue = 0;
            }
        }
        
        var viewRect:CGRect = CGRectZero;
        viewRect.size = self.contentScrollView.bounds.size;
        let width:CGFloat = viewRect.size.width;
        for (_,item) in self.contentViews.enumerate(){
            item.frame.origin.x = -1024;
        }
        
        var tmpContentViews:[PdfView] = [];
        for index in minvalue ... maxvalue{
            if let pv = self.pageViews[Int(index)]{
                pv.frame = viewRect;
                pv.reset();
                tmpContentViews.append(pv);
                self.contentScrollView.addSubview(pv);
            }else{
                let v = PdfView(frame:viewRect,document:self.document,pageNo:UInt(index));
                tmpContentViews.append(v);
                self.pageViews[Int(index)] = v;
                
                self.contentScrollView.addSubview(v);
            }
            viewRect.origin.x += viewRect.size.width;
        }
        
        if self.pageNo == 0{
            self.contentScrollView.contentOffset.x = 0;
        }else if self.pageNo == self.document.pages - 1 {
            self.contentScrollView.contentOffset.x = width * CGFloat(self.pageViewCount - 1);
        }else{
            self.contentScrollView.contentOffset.x = width;
        }
        
//        if (page == (PAGING_VIEWS - 1))
//        contentOffset.x = viewWidthX1;
        for (_,item) in self.contentViews.enumerate(){
            if item.frame.origin.x == -1024{
                item.removeFromSuperview();
            }
        }
        self.contentViews = tmpContentViews;
    }
    
    override func viewDidLoad() {
        //self.view.backgroundColor = UIColor.blueColor();
//        println("width:\(self.view.frame.size.width)\theight:\(self.view.frame.size.height)");
        let rect = self.view.frame;
        
        pageViews = [PdfView?](count:Int(document.pages),repeatedValue:nil);
        
//        rect.size.width = 1024;
//        rect.size.height = 768;
//        
//        rect.size.width = 1024;
//        rect.size.height = 768;
        contentScrollView = UIScrollView(frame:rect);
        contentScrollView.backgroundColor = UIColor(red:109/255, green:109/255, blue:109/255, alpha:1.0);
        
        contentScrollView.autoresizesSubviews = false;
        contentScrollView.contentMode = UIViewContentMode.Center;
        contentScrollView.showsHorizontalScrollIndicator = false;
        contentScrollView.showsVerticalScrollIndicator = false;
        contentScrollView.scrollsToTop = false;
        contentScrollView.delaysContentTouches = false;
        contentScrollView.pagingEnabled = true;
//        contentScrollView.bouncesZoom = true;
        //println("mask:\((1<<1) | (1<<4))");
        contentScrollView.autoresizingMask = UIViewAutoresizing(rawValue: 18)//.FlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //contentScrollView.backgroundColor = [UIColor clearColor];
        //contentScrollView.delegate = self;
        contentScrollView.delegate = self;
        
        self.view.addSubview(contentScrollView);
        
        if self.pageViewCount > self.document.pages{
            self.pageViewCount = self.document.pages;
        }
        
        contentScrollView.contentSize = CGSizeMake(self.view.frame.size.width * CGFloat(self.pageViewCount), self.view.frame.size.height+1);
        //self.pageNo = 10;
        showPage(self.pageNo,redraw:true);
//        pview = PdfView(frame:rect,document:self.document!,pageNo:1);//[[PDFView
//        //        var containerView:UIScrollView = UIScrollView();
//        //        preview = view;
//        self.view.addSubview(pview!);
    }
    
    override func willAnimateRotationToInterfaceOrientation(interfaceOrientation:UIInterfaceOrientation,duration:NSTimeInterval){
        contentScrollView.frame = self.view.frame;
        showPage(self.pageNo,redraw:true);
         contentScrollView.contentSize = CGSizeMake(self.view.frame.size.width * CGFloat(self.pageViewCount), self.view.frame.size.height+1);
    }
    override func viewWillLayoutSubviews(){
        contentScrollView.frame = self.view.frame;
        showPage(self.pageNo,redraw:true);
         contentScrollView.contentSize = CGSizeMake(self.view.frame.size.width * CGFloat(self.pageViewCount), self.view.frame.size.height+1);
//        pview!.frame = self.view.frame;
//        println("width:\(self.view.frame.size.width)\theight:\(self.view.frame.size.height)");
    }
}