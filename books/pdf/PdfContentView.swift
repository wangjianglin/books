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

class PdfContentView:UIView{
    
    override class func layerClass() -> AnyClass {
        return PdfContentTile.self;
    }

    private var page:CGPDFPage?;

  
    var rect:CGRect;
    init(frame:CGRect,page:CGPDFPage){

        self.page = page;//CGPDFDocumentGetPage (self.document, self.pageNo+1);
        self.rect = frame;
        super.init(frame:frame);
        self.backgroundColor = UIColor.blueColor();
        self.backgroundColor = UIColor(red:0.1,green:0.1,blue:0.1,alpha:1.0);
   
        self.autoresizesSubviews = false;
        self.userInteractionEnabled = false;
        self.contentMode = UIViewContentMode.Redraw;
        self.backgroundColor = UIColor.whiteColor();
        
        self.contentMode = UIViewContentMode.Redraw;
        self.backgroundColor = UIColor.blueColor();
        self.userInteractionEnabled = true;
        self.autoresizesSubviews = false;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        PdfDocument.draw(ctx,page:self.page!,rect: self.rect);
    }

}
