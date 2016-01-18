//
//  ReaderThumbView.swift
//  reader
//
//  Created by lin on 14-9-7.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

let THUMB_SMALL_GAP:CGFloat = 4;
let THUMB_SMALL_WIDTH:CGFloat = 22;
let THUMB_SMALL_HEIGHT:CGFloat = 28;

let THUMB_LARGE_WIDTH:CGFloat = 28;
let THUMB_LARGE_HEIGHT:CGFloat = 36;

let PAGE_NUMBER_WIDTH:CGFloat = 96.0;
let PAGE_NUMBER_HEIGHT:CGFloat = 30.0;
let PAGE_NUMBER_SPACE:CGFloat = 20.0;

public class PdfThumbsView:UIView{
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    override class func layerClass()->AnyClass
//    {
//        return CAGradientLayer.self;
//    }
    
    private var _document:PdfDocument!;
    public var document:PdfDocument!{
        return _document;
    }
    private var trackControl:PdfTrackControl!;
//    private var trackControl2:PdfTrackControl!;
    private var pages:UInt!;
    
    public init(document:PdfDocument,initPageNo:Int)
    {
        self._document = document;
        self.pages = self._document.pages;// Pages
        self.prePage = initPageNo;
        super.init(frame:CGRectMake(0, 0, 0, 0));
        self.initView();
    }
    
    public init(frame:CGRect,document:PdfDocument,initPageNo:Int)
    {
        self._document = document;
        self.pages = self._document.pages;// Pages
        self.prePage = initPageNo;
        super.init(frame:frame);
        self.initView();
    }
    private func initView(){
        self.backgroundColor = UIColor(red:0.95,green:0.95,blue:0.95,alpha:1.0);

    self.autoresizesSubviews = true;
    self.userInteractionEnabled = true;
    self.contentMode = UIViewContentMode.Redraw;
        self.autoresizingMask = UIViewAutoresizing.FlexibleWidth;// |
        var shadowRect:CGRect = self.bounds;
        shadowRect.size.height = 4.0;
        shadowRect.origin.y -= shadowRect.size.height;
 
        let numberY:CGFloat = (0.0 - (PAGE_NUMBER_HEIGHT + PAGE_NUMBER_SPACE));
        let numberX:CGFloat = ((self.bounds.size.width - PAGE_NUMBER_WIDTH) / 2.0);
        let numberRect:CGRect = CGRectMake(numberX, numberY, PAGE_NUMBER_WIDTH, PAGE_NUMBER_HEIGHT);
    
    let pageNumberView = UIView(frame:numberRect); // Page numbers view
    
    pageNumberView.autoresizesSubviews = false;
    pageNumberView.userInteractionEnabled = false;
        pageNumberView.autoresizingMask = UIViewAutoresizing.FlexibleWidth;// | UIViewAutoresizingFlexibleRightMargin;
        pageNumberView.backgroundColor = UIColor(red:0,green:0,blue:0,alpha:0.4);
    
    pageNumberView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    pageNumberView.layer.shadowColor = UIColor(red:0,green:0,blue:0,alpha:0.6).CGColor;
//    pageNumberView.layer.shadowPath = [UIBezierPath bezierPathWithRect:pageNumberView.bounds].CGPath;
    pageNumberView.layer.shadowRadius = 2.0;
    pageNumberView.layer.shadowOpacity = 1.0;
    
        let textRect:CGRect = CGRectInset(pageNumberView.bounds, 4.0, 2.0); // Inset the text a bit
    
    let pageNumberLabel = UILabel(frame:textRect); // Page numbers label
    
    pageNumberLabel.autoresizesSubviews = false;
    pageNumberLabel.autoresizingMask = UIViewAutoresizing.None;
    pageNumberLabel.textAlignment = NSTextAlignment.Center;
    pageNumberLabel.backgroundColor = UIColor.clearColor();
    pageNumberLabel.textColor = UIColor.whiteColor();
    pageNumberLabel.font = UIFont.systemFontOfSize(16.0);
    pageNumberLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    pageNumberLabel.shadowColor = UIColor.blackColor();
    pageNumberLabel.adjustsFontSizeToFitWidth = true;
    pageNumberLabel.minimumScaleFactor = 0.75;
    
    pageNumberView.addSubview(pageNumberLabel); // Add label view
    
    //self.addSubview(pageNumberView); // Add page numbers display view
    
    self.trackControl = PdfTrackControl(frame:self.bounds); // Track control view
      
        //    func addTarget(target: AnyObject!, action: Selector, forControlEvents controlEvents: UIControlEvents)
        
//        self.trackControl.addTarget(self,action:"trackViewTouchDown:",forControlEvents:UIControlEvents.TouchDown);
//        trackControl.addTarget(self,action:"trackViewValueChanged:",forControlEvents:UIControlEvents.ValueChanged);
//    trackControl.addTarget(self,action:"trackViewTouchUp:", forControlEvents:UIControlEvents.TouchUpOutside);
//    trackControl.addTarget(self,action:"trackViewTouchUp:",forControlEvents:UIControlEvents.TouchUpInside);
    
    self.addSubview(trackControl); // Add the track control and thumbs view
//        self.trackControl2 = PdfTrackControl(frame:self.bounds);
//        self.addSubview(self.trackControl2!);
        
        self.trackControl!.addTarget(self,action:"trackViewTouchDown:",forControlEvents:UIControlEvents.TouchDown);
        self.trackControl!.addTarget(self,action:"trackViewValueChanged:",forControlEvents:UIControlEvents.ValueChanged);
        self.trackControl!.addTarget(self,action:"trackViewTouchUp:", forControlEvents:UIControlEvents.TouchUpOutside);
        self.trackControl!.addTarget(self,action:"trackViewTouchUp:",forControlEvents:UIControlEvents.TouchUpInside);
        
//    document = object; // Retain the document object for our use
    
//    [self updatePageNumberText:[document.pageNumber integerValue]];
    
//    miniThumbViews = [NSMutableDictionary new]; // Small thumbs
//    }
//
//    return self;
    }

    
    var prePage:Int = 0;
    //var prePageView:UIView?;
    var imageView:UIImageView?;
    var view:UIView?;
    
    var pageChanged:((UInt)->())?;
    
    func pageStatus(page:Int){
        
//        if let tmpv = prePageView{
//            tmpv.removeFromSuperview();
//        }
        let controlWidth:CGFloat = self.trackControl.bounds.size.width;
        
        let useableWidth:CGFloat = (controlWidth - THUMB_LARGE_WIDTH);
        
        let stride:CGFloat = (CGFloat(useableWidth) / CGFloat(self.pages - 1)); // Page stride
        //var page:Int = 200;
        let X = (stride * CGFloat(page - 1));
        let pageThumbX = X;
        
        let heightDelta:CGFloat = (self.trackControl.frame.size.height - THUMB_LARGE_HEIGHT);
        
        let thumbY = (heightDelta / 2.0);
        let thumbX = 0; // Thumb X, Y
        
        var thumbRect:CGRect = CGRectMake(CGFloat(thumbX), CGFloat(thumbY), THUMB_LARGE_WIDTH, THUMB_LARGE_HEIGHT);
        
        if (pageThumbX != thumbRect.origin.x) // Only if different
        {
            thumbRect.origin.x = pageThumbX; // The new X position
        }
        if let image = self.imageView {
            //image.image = self.images(UInt(page),thumbSize:thumbRect.size);
            image.image = self.document!.image(UInt(page),thumbSize:thumbRect.size);
            self.view!.frame = thumbRect;
            
            trackControl.bringSubviewToFront(self.view!);
        }else{
        self.view = UIView(frame:thumbRect);
            let color = UIColor(red:159/255, green:159/255, blue:159/255, alpha:1.0).CGColor;
            let bottomBorder = CALayer();
            bottomBorder.frame = CGRectMake(0.0, thumbRect.size.height-1.0, thumbRect.size.width, 1.0);
            bottomBorder.backgroundColor = color;
            self.view!.layer.addSublayer(bottomBorder);
            
            
            let upBorder = CALayer();
            upBorder.frame = CGRectMake(0.0, 0.0, thumbRect.size.width, 1.0);
            upBorder.backgroundColor = color;
            self.view!.layer.addSublayer(upBorder);
            
            let leftBorder = CALayer();
            leftBorder.frame = CGRectMake(0.0, 0.0, 1, thumbRect.size.height);
            leftBorder.backgroundColor = color;
            self.view!.layer.addSublayer(leftBorder);
            
            
            let rightBorder = CALayer();
            rightBorder.frame = CGRectMake(thumbRect.size.width - 1.0, 0.0 , 1.0, thumbRect.size.height);
            rightBorder.backgroundColor = color;
            self.view!.layer.addSublayer(rightBorder);
            
        //view.backgroundColor = UIColor.blueColor();
//        var image:UIImage = self.document!.image(UInt(page),thumbSize:thumbRect.size);
            let imageRef = self.document!.thumbnail(UInt(page));
            let image:UIImage! = UIImage(CGImage: imageRef).scaledToSize(size: thumbRect.size);
        self.imageView = UIImageView(image:image);
        
        self.imageView!.autoresizesSubviews = false;
        self.imageView!.userInteractionEnabled = false;
        self.imageView!.autoresizingMask = UIViewAutoresizing.None;
        self.imageView!.contentMode = UIViewContentMode.ScaleAspectFit;
            self.view?.userInteractionEnabled = false;
            self.view!.addSubview(self.imageView!);
            self.view!.sendSubviewToBack(self.imageView!);
        trackControl.addSubview(self.view!);
            trackControl.bringSubviewToFront(self.view!);
            
        }
        if(page == prePage){
            return;
        }
        prePage = page;
        if let pc = self.pageChanged{
            pc(UInt(page));
        }
    }
    
    func trackViewPageNumber(trackView:PdfTrackControl)->Int
    {
        let controlWidth:CGFloat = trackView.bounds.size.width; // View width
    
        let stride:Float = (Float(controlWidth) / Float(self.pages));
    
        var page:Int = Int(Float(trackView.value) / stride); // Integer page number
        if page < 0 {
            page = 0;
        }
        if UInt(page) >= self.pages {
            page = Int(self.pages) - 1;
        }
        return page; // + 1
    }
    
    func trackViewTouchDown(trackView:PdfTrackControl)
    {
        let page:Int = self.trackViewPageNumber(trackView); // Page
        self.pageStatus(page);
    }
    
    func trackViewValueChanged(trackView:PdfTrackControl)
    {
        let page:Int = self.trackViewPageNumber(trackView); // Page
        self.pageStatus(page);
    }
    
    func trackViewTouchUp(trackView:PdfTrackControl)
    {
        let page:Int = self.trackViewPageNumber(trackView); // Page
        self.pageStatus(page);
    }
    
    override public func layoutSubviews() {
    
//绘制缩略图  开始
        var controlRect:CGRect = CGRectInset(self.bounds, 4.0, 0.0);
        
        let thumbWidth:CGFloat = (THUMB_SMALL_WIDTH + THUMB_SMALL_GAP);
        
        var thumbs:CGFloat  = (controlRect.size.width / thumbWidth);
        
       
        
        if Float(thumbs) > Float(pages){ thumbs = CGFloat(pages);} // No more than total pages
        
        let controlWidth:CGFloat = ((thumbs * thumbWidth) - THUMB_SMALL_GAP);
        
        controlRect.size.width = controlWidth; // Update control width
        
        let widthDelta:CGFloat = (self.bounds.size.width - controlWidth);
        
        let X = (widthDelta / 2.0);
        controlRect.origin.x = X;
        
        trackControl.frame = controlRect;
//        trackControl2.frame = controlRect; // Update track control frame

        var strideThumbs = (thumbs - 1);
        if strideThumbs < 1{ strideThumbs = 1;}
//        
        let stride:CGFloat = (CGFloat(pages) / CGFloat(strideThumbs)); // Page stride
//        
        let heightDelta = (controlRect.size.height - THUMB_SMALL_HEIGHT);
//        
        let thumbY:CGFloat = (heightDelta / 2.0);
        let thumbX:CGFloat = 0; // Initial X, Y
//        
        var thumbRect:CGRect = CGRectMake(thumbX, thumbY, THUMB_SMALL_WIDTH, THUMB_SMALL_HEIGHT);
//        
//        NSMutableDictionary *thumbsToHide = [miniThumbViews mutableCopy];
        
        //---------------------------------------------------------
        
        for var thumb:Float = 0; thumb < Float(thumbs-1); thumb++ // Iterate through needed thumbs
        {
            var page:Int = Int(Float(stride) * thumb) + 1;
            if page > Int(pages)-1 {page = Int(pages)-1;} // Page
            
//            var size:CGSize = CGSizeMake(THUMB_SMALL_WIDTH, THUMB_SMALL_HEIGHT); // Maximum thumb size
 
            let view = PdfThumbView(frame:thumbRect,document:self.document!,pageNo:UInt(page));
            view.userInteractionEnabled = false;
            trackControl.addSubview(view);
        
            thumbRect.origin.x += thumbWidth; // Next thumb X position
        }
        
        
        //---------------------------------------------------------
        self.pageStatus(prePage);
        
//绘制缩略图  结束
    }
    
    func updatePageNumberText(){
        let page:Float = 3;
        if (pages > 1) // Only update frame if more than one page
        {
            let controlWidth:CGFloat = 40;//trackControl.bounds.size.width;
            
            let useableWidth:CGFloat = (controlWidth - THUMB_LARGE_WIDTH);
            
            let stride:CGFloat = (useableWidth / (1024 - 1.0)); // Page stride
            //var stride:CGFloat = 5 - 1.0;
            
            let x = (Float(stride) * (page - 1));
            let pageThumbX:CGFloat = CGFloat(x);
            
            var pageThumbRect:CGRect = self.frame;//pageThumbView.frame; // Current frame
            
            if (pageThumbX != pageThumbRect.origin.x) // Only if different
            {
                pageThumbRect.origin.x = pageThumbX; // The new X position
            }
        }
        
    }

    func hide(){
        if hidden == false{
            //hidden = true;
            UIView.animateWithDuration(0.5,delay:0.0,options:UIViewAnimationOptions(rawValue: 3 << 16 | 1<<1),animations:{() in
                self.alpha = 0;
                },completion:{(finished:Bool)in
                    self.hidden = true;
                });
        }
    }
    
    func show(){
        if hidden == true{
            UIView.animateWithDuration(0.5,delay:0.0,options:UIViewAnimationOptions(rawValue: 3 << 16 | 1<<1),animations:{() in
                
                },completion:{(finished:Bool)in
                    self.alpha = 1;
                    self.hidden = false;
                });
        }
    }
}