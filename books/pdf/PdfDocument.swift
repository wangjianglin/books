//
//  PdfDocument.swift
//  reader
//
//  Created by lin on 14-9-11.
//  Copyright (c) 2014年 lin. All rights reserved.
//


//文档密码


import Foundation
import QuartzCore
import UIKit
import ImageIO
//import CommonDigest
//import "CommonCrypto/CommonDigest-Swift.h"

func PDFViewController_GetPDFDocumentRef(filename:String)->CGPDFDocument!
{
    //    CFStringRef path;
    //    CFURLRef url;
    //    CGPDFDocumentRef document;
    
    //testmd5(filename);
//    var md5 = md5WithPath(filename);
    //println("md5:\(md5)");
    //println("md5:\(testmd5(filename))");
    
//    var path = CFStringCreateWithCString (nil, filename.bridgeToObjectiveC().UTF8String, 0x08000100);
//    var url = CFURLCreateWithFileSystemPath (nil, path, CFURLPathStyle.CFURLPOSIXPathStyle, 0);
    
    let url = CFURLCreateWithFileSystemPath (nil, filename, CFURLPathStyle.CFURLPOSIXPathStyle, false);
    
//    var document:CGPDFDocument! = CGPDFDocumentCreateWithURL (url);
//    return document;
    print("url:\(url)");
    return CGPDFDocumentCreateWithURL (url);
}

public class PdfDocument{
    
    public var file:String!;
    private var _document:CGPDFDocument?;
    public var document:CGPDFDocument?{
        get{
            if let document = self._document{
                return document;
            }
             objc_sync_enter(self)
            if self._document == nil{
                self._document = PDFViewController_GetPDFDocumentRef(path);
            }
             objc_sync_exit(self)
            return self._document;
        }
    }
    
    public func clean(){
        _document = nil;
    }
    
    private var _pages:UInt = UInt.max;
    public var pages:UInt{
    get{
        if self._pages == UInt.max{
            self._pages = UInt(CGPDFDocumentGetNumberOfPages (self.document));
        }
        return self._pages;
    }
    }
    public var name:String!;
    private var path:String!;
    
    private var _title:String!;
    public var title:String!{
        self.initInof();
        return _title;
    }
//    println("title:\(t)");
//    t = self.getStringInfo(infoDict, key: "Author");
    
    private var _author:String!;
    public var author:String!{
        self.initInof();
        return _author;
    }
//    println("title:\(t)");
//    t = self.getStringInfo(infoDict, key: "Subject");
    private var _subject:String!;
    public var subject:String!{
        self.initInof();
        return _subject;
    }
//    println("title:\(t)");
//    t = self.getStringInfo(infoDict, key: "Keywords");
    private var _keywords:String!;
    public var keywords:String!{
        self.initInof();
        return _keywords;
    }
//    println("title:\(t)");
//    t = self.getStringInfo(infoDict, key: "Creator");
    private var _creator:String!;
    public var creator:String!{
        self.initInof();
        return _creator;
    }
//    println("title:\(t)");
//    CreationDate
    
    private var _creationDate:NSDate!;
    public var creationDate:NSDate!{
        self.initInof();
        return _creationDate;
    }
    
//    t = self.getStringInfo(infoDict, key: "Producer");
//    println("title:\(t)");
    private var _producer:String!;
    public var producer:String!{
        self.initInof();
        return _producer;
    }
    
    
//    var d = self.getDateInfo(infoDict, key: "ModDate");
    private var _modDate:NSDate!;
    public var modDate:NSDate!{
        self.initInof();
        return _modDate;
    }
    
    public init(file:String,path:String){
        self.file = file;
        self.path = path;
        //self.document = PDFViewController_GetPDFDocumentRef(path);
        //self.pages = CGPDFDocumentGetNumberOfPages (self.document);
        
        //var str = file as NSString;
        //substringWithRange(range: NSRange)
//        var r = file.rangeOfString("/");
        //path.l
//        var s :String.Index = path.lastIndexOf("/");
        var l = path.length;
        var index = path.lastIndexOf("/") + 1;
        self.name = path.subString(index, length: l - index);
//        self.name = path.substringFromIndex(path.lastIndexOf("/")+1); // File name only
        
        l = self.name.length;
        index = self.name.lastIndexOf(".");
        self.name = self.name.subString(0, length: index);
        
        //self.name = "name";
        //self.dir();
//        var tmp = self.catalog;
//        println("value:\(tmp)");
//        println("value:\(tmp.items[2].title)");
//        println("value:\(tmp.items[2].items[0].title)");
        //show(tmp,N:0);
    }
    
//    func show(item:Catalog,N:Int){
//        //println(")
//    for var n = 0;n<N;n++ {
//    print("---|.");
//    }
//        print(item.title);
//        println("               \(item.page)");
//    for var n=0;n<item.items.count;n++ {
//        show(item.items[n],N:N+1);
//    }
//    }
    
    private var _catalog:Catalog? = nil;
    
    private func dictToCatalog(dic:Dictionary<String,AnyObject>!)->Catalog!{
        if(dic == nil || dic.count == 0){
            return nil;
        }
        let catalog = Catalog();
        
        catalog.title = dic["title"] as! String;
        let page: AnyObject? = dic["page"];
        if let page: AnyObject = page {
            catalog.page = (page as! NSNumber).unsignedLongValue;
        }else{
            catalog.page = 0;
        }
        let items = dic["items"] as? [Dictionary<String,AnyObject>!];
        if let items = items{
            for var n=0;n<items.count;n++ {
                catalog.addItem(dictToCatalog(items[n]));
            }
        }
        return catalog;
    }
    
    private func getStringInfo(info:CGPDFDictionaryRef,key:String)->String?{
        let string = UnsafeMutablePointer<CGPDFStringRef>.alloc(1);
        if (CGPDFDictionaryGetString(info, key, string)){
            let stringValue = CGPDFStringCopyTextString(string.memory);
            if (stringValue != nil) {
                return stringValue as? String;
            }
        }
        return nil;
        
    }
    
    private func getDateInfo(info:CGPDFDictionaryRef,key:String)->NSDate!{
        let string = UnsafeMutablePointer<CGPDFStringRef>.alloc(1);
        if (CGPDFDictionaryGetString(info, key, string)){
            let date = CGPDFStringCopyDate(string.memory);
            if (date != nil) {
                return date as? NSDate;
            }
        }
        return nil;
        
    }
    
    public var catalog:Catalog!{
        self.initInof();
        return self._catalog!;
    }
    
    
    private var isInit:Bool = false;
    private func initInof(){
        
        // var isInit:Bool = false;
        if(isInit){
            return;
        }
        
        objc_sync_enter(self);
        
        let tmp = PdfDictionary(self.document);
        self._catalog = self.dictToCatalog(tmp as! Dictionary<String,AnyObject>!);
        
        
        let infoDict = CGPDFDocumentGetInfo(self.document);
        //            var string = UnsafeMutablePointer<CGPDFStringRef>.alloc(1);
        
        //            var t = "Title";
        //            if (CGPDFDictionaryGetString(infoDict, t, string)){
        ////                CFDateRef date;
        //
        //                var date = CGPDFStringCopyTextString(string.memory);
        //                if (date != nil) {
        ////                    [field setStringValue:[(NSDate *)date description]];
        ////                    var t = (date.takeRetainedValue() as NSDate).description;
        //                    println("title:\(date.takeRetainedValue())");
        ////                    CFRelease(date);
        //                }
        //            }
        self._title = self.getStringInfo(infoDict, key: "Title");

        self._author = self.getStringInfo(infoDict, key: "Author");
       
        self._subject = self.getStringInfo(infoDict, key: "Subject");
        
        self._keywords = self.getStringInfo(infoDict, key: "Keywords");
        
        self._creator = self.getStringInfo(infoDict, key: "Creator");
        
        self._producer = self.getStringInfo(infoDict, key: "Producer");
        
        self._creationDate = self.getDateInfo(infoDict, key: "CreationDate");
        self._modDate = self.getDateInfo(infoDict, key: "ModDate");
            
        isInit = true;
        objc_sync_exit(self);
    }
    
    
    public func page(page:UInt)->CGPDFPageRef! {
       return CGPDFDocumentGetPage(self.document, Int(page+1));
    }
    
    public func pageSize(page:UInt)->CGRect!{
//        func pdfPageRect()->CGRect{
        return PdfDocument.pageSize(page:self.page(page));
    }
    
    public func draw(context:CGContextRef!,pageNo:UInt,rect:CGRect?){
        PdfDocument.draw(context,page:self.page(pageNo),rect:rect);
    }
    public class func draw(context:CGContextRef,page:CGPDFPageRef!,rect:CGRect?){
        //        var viewRect = self.pdfPageRect();
        //var context:CGContextRef = UIGraphicsGetCurrentContext();
        //CGContextSetRGBFillColor(context, 109/255, 109/255, 109/255, 1.0);
//        var page:CGPDFPageRef = self.page(page);
        var tmp:CGRect!;
        var s:Float = 1.0;
        tmp = pageSize(page:page);
        var h = tmp.size.height;
        if let rect = rect {
            
            let sy:Float = Float(rect.size.height/tmp.size.height);
            let sx:Float = Float(rect.size.width/tmp.size.width);
            s = sy > sx ? sx : sy ;
//            s = 1/s;
//            tmp = rect;
            h = rect.size.height;
        }
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0)
        CGContextFillRect(context, CGContextGetClipBoundingBox(context));

        CGContextTranslateCTM(context, 0.0, h);
        CGContextScaleCTM(context, CGFloat(s), CGFloat(-s));
        
//        CGContextTranslateCTM(context, 0.0f, self.bounds.size.height);
//        //CGContextScaleCTM(context, 1.0f, -1.0f);
        
//        CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(_PDFPageRef, kCGPDFCropBox, self.bounds, 0, true));
        
        CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(page, CGPDFBox.CropBox, tmp, 0, true));
        CGContextDrawPDFPage(context, page);
    }
    
    public func image(page:UInt)->UIImage{
        return self.image(page,thumbSize:self.pageSize(page).size);
    }
    
    public func image(page:UInt,thumbSize:CGSize)->UIImage!{
        let thePDFPageRef:CGPDFPageRef!  = self.page(page);//CGPDFDocumentGetPage(self.document, page);
        if(thePDFPageRef == nil){
            return nil;
        }
        var imageRef:CGImage? = nil;
        //if (thePDFPageRef != nil) // Check for non-NULL CGPDFPageRef
        if(true)
        {
            let thumb_w:CGFloat = thumbSize.width; // Maximum thumb width
            let thumb_h:CGFloat = thumbSize.height; // Maximum thumb height
            
            let cropBoxRect:CGRect = CGPDFPageGetBoxRect(thePDFPageRef, CGPDFBox.CropBox);
            let mediaBoxRect:CGRect = CGPDFPageGetBoxRect(thePDFPageRef, CGPDFBox.MediaBox);
            let effectiveRect:CGRect = CGRectIntersection(cropBoxRect, mediaBoxRect);
            
            let pageRotate:CInt = CGPDFPageGetRotationAngle(thePDFPageRef); // Angle
            
            var page_w:CGFloat = 0.0;
            var page_h:CGFloat = 0.0; // Rotated page size
            
            switch (Int(pageRotate)) // Page rotation (in degrees)
                {
                
            case 90:
                fallthrough
            case 270: // 90 and 270 degrees
                
                page_h = effectiveRect.size.width;
                page_w = effectiveRect.size.height;
                break;
                
            case 0:
                fallthrough
            case 180: // 0 and 180 degrees
                fallthrough
            default: // Default case
                
                page_w = effectiveRect.size.width;
                page_h = effectiveRect.size.height;
                break;
            }
            
            let scale_w:CGFloat = (thumb_w / page_w); // Width scale
            let scale_h:CGFloat = (thumb_h / page_h); // Height scale
            
            var scale:CGFloat = 0.0; // Page to target thumb size scale
            
            if page_h > page_w{
                scale = ((thumb_h > thumb_w) ? scale_w : scale_h); // Portrait
            }else{
                scale = ((thumb_h < thumb_w) ? scale_h : scale_w); // Landscape
            }
            var target_w:Float = Float(Float(page_w) * Float(scale));
            // Integer target thumb width
            var target_h:Float = Float(page_h * scale); // Integer target thumb height
            
            if target_w % 2 == 1{
                target_w--;
            }
            if target_h % 2 == 1{ target_h--; }// Even
            
            
            let rgb:CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!; // RGB color space
            
//            let bmi:CGBitmapInfo = CGBitmapInfo(rawValue: 8198);
            
//            func CGBitmapContextCreate(data: UnsafeMutablePointer<Void>, width: Int, height: Int, bitsPerComponent: Int, bytesPerRow: Int, space: CGColorSpace!, bitmapInfo: CGBitmapInfo) -> CGContext!
//            var context:CGContextRef = CGBitmapContextCreate(nil, UInt(target_w), UInt(target_h), 8, 0, rgb, bmi);
            let context:CGContext = CGBitmapContextCreate(nil, Int(target_w), Int(target_h), 8, 0, rgb, 8198)!;
            
            //if (context != nil) // Must have a valid custom CGBitmap context to draw into
            if(true)
            {
                let thumbRect:CGRect = CGRectMake(0.0, 0.0, CGFloat(target_w), CGFloat(target_h)); //
                
                CGContextSetRGBFillColor(context, 0.97, 0.97, 0.97, 1.0);
                CGContextFillRect(context, thumbRect); // White fill
                
                CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(thePDFPageRef, CGPDFBox.CropBox, thumbRect, 0, true)); // Fit rect
                
                CGContextDrawPDFPage(context, thePDFPageRef); // Render the PDF page into the custom CGBitmap context
                
                imageRef = CGBitmapContextCreateImage(context); // Create CGImage from custom CGBitmap context
                
            }
            
        }
        
        let image:UIImage = UIImage(CGImage:imageRef!,scale:1,orientation:UIImageOrientation.Up);
        return image;
    }
    
   public class func pageSize(page page:CGPDFPageRef!)->CGRect!{
        if(page == nil){
        return nil;
        }
            let cropBoxRect:CGRect = CGPDFPageGetBoxRect(page, CGPDFBox.CropBox);
            let mediaBoxRect:CGRect = CGPDFPageGetBoxRect(page, CGPDFBox.MediaBox);
            let effectiveRect:CGRect = CGRectIntersection(cropBoxRect, mediaBoxRect);
            
            let _pageAngle = CGPDFPageGetRotationAngle(page); // Angle
            
            
            var _pageWidth:CGFloat;
            var _pageHeight:CGFloat;
//            var _pageOffsetX:CGFloat;
//            var _pageOffsetY:CGFloat;
            switch (_pageAngle) // Page rotation angle (in degrees)
                {
                
            case 90:
                fallthrough;
            case 270: // 90 and 270 degrees
                //{
                _pageWidth = effectiveRect.size.height;
                _pageHeight = effectiveRect.size.width;
//                _pageOffsetX = effectiveRect.origin.y;
//                _pageOffsetY = effectiveRect.origin.x;
                break;
                
            case 0:
                fallthrough;
            case 180:
                fallthrough;
            default: // Default case
                //; // 0 and 180 degrees
                //{
                _pageWidth = effectiveRect.size.width;
                _pageHeight = effectiveRect.size.height;
//                _pageOffsetX = effectiveRect.origin.x;
//                _pageOffsetY = effectiveRect.origin.y;
                break;
                //}
                
                //}
            }
            
            var page_w = _pageWidth; // Integer width
            var page_h = _pageHeight; // Integer height
            
            if (page_w % 2 != 0){
                page_w--;
            }
            if (page_h % 2 != 0) {
                page_h--;
            } // Even
            
            var viewRect:CGRect = CGRect();
            viewRect.size = CGSizeMake(page_w, page_h); // View size
            return viewRect;
    }
    
    
//    -(CGImageRef)thumbnailFromData:(NSData *)data andSize:(int)size {
    public func thumbnail(page:UInt)->CGImageRef!{
    
//        var s:String = self.path!;
//        let s:CFStringRef! = nil;
//        var ss = self.path.cStringUsingEncoding(NSUTF8StringEncoding);
        let image:Unmanaged<CGImage>! = thumbnailFromPDFFile(self.path,UInt32(page));
//        var image:Unmanaged<CGImage>! = thumbnailFromFile(s);
        //return image.autorelease().takeRetainedValue();
        return image.takeRetainedValue();
        
//        return nil;
    }
//    _myThumbnailImage = NULL;
//    CGImageSourceRef myImageSource;
//    CFStringRef   myKeys[3];
//    CFDictionaryRef myOptions = NULL;
//    CFTypeRef     myValues[3];
//    
//    CFNumberRef   thumbnailSize;
//    
//    self.data       = data;
//    self.imageSize  = size;
//    
//    //    IMAGEIO_EXTERN CGImageSourceRef CGImageSourceCreateWithURL(CFURLRef url, CFDictionaryRef options)
//    myImageSource = CGImageSourceCreateWithData((__bridge CFDataRef)self.data, NULL);
//        CGImageSourceCreateWithData();
//        CFStringRef  path = CFStringCreateWithCString (NULL, [fullFilePath UTF8String], kCFStringEncodingUTF8);
//         CFURLRef   url = CFURLCreateWithFileSystemPath (NULL, path, kCFURLPOSIXPathStyle, 0);
//        var s:UnsafePointer<Int8> = UnsafePointer<Int8>();
//        var ss = self.path.cStringUsingEncoding(NSUTF8StringEncoding);
//        var s = reinterpretCast(self.path.withCString(getenv));
//        var ss = self.path.
//        s.
//        var e:CFStringEncoding = CFStringEncoding(0x08000100);
//        var a:CFAllocator! = nil;
//        var paths = CFStringCreateWithCString(a, ss!, e);
        
//        func CFURLCreateWithFileSystemPath(allocator: CFAllocator!, filePath: CFString!, pathStyle: CFURLPathStyle, isDirectory: Boolean) -> CFURL!
//        var url = CFURLCreateWithFileSystemPath(a,paths,CFURLPathStyle.CFURLPOSIXPathStyle,0);
//        var myImageSource:CGImageSource! = CGImageSourceCreateWithURL(url,nil);
//
//    if (myImageSource == NULL) {
//    fprintf(stderr, "Image Source is NULL");
//    }
//        if(myImageSource == nil){
//            println("error.");
//            return nil;
//        }
        
//    
////    thumbnailSize = CFNumberCreate(NULL, kCFNumberIntType, &size);
//        var sizePrt = UnsafePointer<Void>();
//        
//        var thumbnailSize = CFNumberCreate(a,CFNumberType.IntType,sizePrt);
        //size = sizePrt.
//    
//        CFStringRef   myKeys[3];
//         CFTypeRef     myValues[3];
//        var myKeys:[CFStringRef] = [];
//        var myValues:[CFTypeRef] = [];
//    myKeys[0] = kCGImageSourceCreateThumbnailWithTransform;
//    myValues[0] = CFBooleanTrue;
//    myKeys[1] = kCGImageSourceCreateThumbnailFromImageIfAbsent;
//    myValues[1] = CFBooleanTrue;
//    myKeys[2] = kCGImageSourceThumbnailMaxPixelSize;
//    myValues[2] = (CFTypeRef)thumbnailSize;
//
//    myOptions = CFDictionaryCreate(NULL, (const void **) myKeys,
//    (const void **) myValues, 2,
//    &kCFTypeDictionaryKeyCallBacks,
//    & kCFTypeDictionaryValueCallBacks);
//    // Create the thumbnail image using the specified options.
//    
//    size_t totalPages = CGImageSourceGetCount(myImageSource);
//    if (_indexPage < 0 || _indexPage > totalPages) {
//    fprintf(stderr, "Thumbnail not created because indexPage it's not valid.\n");
//    }
//    
//    _myThumbnailImage = CGImageSourceCreateThumbnailAtIndex(myImageSource,
//    _indexPage,
//    myOptions);
//    // Release the options dictionary and the image source
//    // when you no longer need them.
//    CFRelease(thumbnailSize);
//    CFRelease(myOptions);
//    CFRelease(myImageSource);
//    // Make sure the thumbnail image exists before continuing.
//    if (!_myThumbnailImage) {
//    fprintf(stderr, "Thumbnail image not created from image source.");
//    }
//    
//    return _myThumbnailImage;
//    return nil;
//    }

  }