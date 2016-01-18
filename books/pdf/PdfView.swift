//
//  PdfContentView.swift
//  reader
//
//  Created by lin on 14-9-2.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore


class PdfView:UIScrollView,UIScrollViewDelegate{

    var document:PdfDocument?;
    var pageNo:UInt;
    var page:CGPDFPage?;
    var contentView:PdfContentView?;
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return contentView;
    }
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent){
//
//    }

    
    init(frame:CGRect,document:PdfDocument,pageNo:UInt){
        self.document = document;
        self.pageNo = pageNo;
        self.page = document.page(pageNo);

        super.init(frame:frame);
        self.tag = Int(pageNo);
        var viewRect = PdfDocument.pageSize(page:self.page!);
        let sy = frame.size.height/viewRect.size.height;
        let sx = frame.size.width/viewRect.size.width;
        let s = sy>sx ? sx : sy ;
        viewRect.size.width *= s;
        viewRect.size.height *= s;
        viewRect.origin.x = (frame.size.width - viewRect.size.width)/2;
        viewRect.origin.y = (frame.size.height - viewRect.size.height)/2;
        contentView = PdfContentView(frame:viewRect,page:self.page!);
        
        contentView!.autoresizesSubviews = false;
        contentView!.userInteractionEnabled = false;
        contentView!.contentMode = UIViewContentMode.Redraw;
        contentView!.autoresizingMask = UIViewAutoresizing.None;
        self.autoresizesSubviews = true;
        self.userInteractionEnabled = false;
        self.contentMode = UIViewContentMode.Redraw;
        
        self.scrollsToTop = false;
        self.delaysContentTouches = false;
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
        self.contentMode = UIViewContentMode.Redraw;
        self.userInteractionEnabled = true;
        self.autoresizesSubviews = false;
        self.bouncesZoom = true;
        
        
        self.minimumZoomScale = 1; // Set the minimum and maximum zoom scales
        
        self.maximumZoomScale = 8;
        self.zoomScale = 1;
        
        self.delegate = self;
        self.backgroundColor = UIColor(red:109/255, green:109/255, blue:109/255, alpha:1.0);

        
        self.addSubview(contentView!);
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews(){
        super.layoutSubviews();
        
        let boundsSize:CGSize = self.bounds.size;
        var viewFrame:CGRect = contentView!.frame;
        
        if viewFrame.size.width < boundsSize.width{
            viewFrame.origin.x = (((boundsSize.width - viewFrame.size.width) / 2.0));
        }else{
        viewFrame.origin.x = 0.0;
        }
        if viewFrame.size.height < boundsSize.height{
            viewFrame.origin.y = (((boundsSize.height - viewFrame.size.height) / 2.0));
        }else{
            viewFrame.origin.y = 0.0;
        }
        
        contentView!.frame = viewFrame;
    
    }
    
    func reset()
    {
        var viewRect = PdfDocument.pageSize(page:self.page!);
        let sy = self.frame.size.height/viewRect.size.height;
        let sx = self.frame.size.width/viewRect.size.width;
        let s = sy>sx ? sx : sy ;
        
        self.minimumZoomScale = 1;
        self.maximumZoomScale = 8;
        self.zoomScale = 1;
        viewRect.size.width *= s;
        viewRect.size.height *= s;
        self.contentSize = viewRect.size;
        
        viewRect.origin.x = (frame.size.width - viewRect.size.width)/2;
        viewRect.origin.y = (frame.size.height - viewRect.size.height)/2;
        
        contentView!.rect = viewRect;
        contentView!.frame = viewRect;
    }
    
}
