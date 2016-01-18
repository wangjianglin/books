//
//  CacheImage.swift
//  LinCore
//
//  Created by lin on 1/18/15.
//  Copyright (c) 2015 lin. All rights reserved.
//

import Foundation
import UIKit
import LinUtil

public class CacheImageOperation:NSOperation{
    
    private var path:String;
    private var imageView:CacheImageView;
    
    private init(path:String,imageView:CacheImageView){
        self.path = path;
        self.imageView = imageView;
    }
    
    public override func main(){
        
        var isCancelled = false;
        //self.imageView.lock.lock();
        isCancelled = self.cancelled;
        //self.imageView.lock.unlock();
        if isCancelled {
            return;
        }
//        var url = NSURL(string:self.path);
        var data:NSData? = nil;
        if let url = NSURL(string:self.path){
            data = CacheImageView.cachedataForUrl(url)
        }
        
        
        dispatch_async(dispatch_get_main_queue(), {() in
            if !self.cancelled {
                if let data = data {
                self.imageView.setImage(UIImage(data:data));
                }else{
                    self.imageView.setImage(nil);
                }
            }
        });
        
//        let md5 = self.path.md5 + ".imagecache";
//        //var urlString = HTTP_COMM_URL + photo.path + "/" + photo.name;// + "." + photo.ext;
//        var filename:String!;
//        if CacheImageView.cachePath.hasSuffix("/") {
//            filename = CacheImageView.cachePath + md5;
//        }else{
//            filename = CacheImageView.cachePath + "/" + md5;
//        }
//
//        
//        var data = NSData(contentsOfFile: filename);
//        if data == nil {
//            var url = NSURL(string:self.path);
//            data = NSData(contentsOfURL:url!);
//            if let data = data {
//                dispatch_async(dispatch_get_main_queue(), {() in
//                    if !self.cancelled {
//                        self.imageView.setImage(UIImage(data:data));
//                    }
//                });
//                data.writeToFile(filename, atomically: true);
//            }
//        }else{
//            dispatch_async(dispatch_get_main_queue(), {() in
//                //self.imageView.lock.lock();
//                if !self.cancelled {
//                    self.imageView.setImage(UIImage(data:data!));
//                }
//                ///self.imageView.lock.unlock();
//                
//            });
//        }
    }
}

private var CacheImageView_Cache_Path_tmpvar:String?;
public class CacheImageView : UIImageView{
    
    
    public class func cachedataForUrl(url:NSURL)->NSData!{
        let md5 = "\(url)".md5 + ".imagecache";
        
        var filename:String!;
        if CacheImageView.cachePath.hasSuffix("/") {
            filename = CacheImageView.cachePath + md5;
        }else{
            filename = CacheImageView.cachePath + "/" + md5;
        }
    
    
        var data = NSData(contentsOfFile: filename);
        if data == nil {
            data = NSData(contentsOfURL:url);
            if let data = data {
                data.writeToFile(filename, atomically: true);
            }
        }
        return data;
    }
    
    public class var cachePath:String{
        get{
            if CacheImageView_Cache_Path_tmpvar == nil {
                CacheImageView_Cache_Path_tmpvar = pathFor(Documents.Cache, path: "imagecache");
            }
            createCachePath()
            return CacheImageView_Cache_Path_tmpvar!
        }
        set{CacheImageView_Cache_Path_tmpvar = newValue;createCachePath();}
    }
    
    private class func createCachePath(){
        let fileManager = NSFileManager.defaultManager();
//        isDirectory: UnsafeMutablePointer<ObjCBool>
        let isDir = UnsafeMutablePointer<ObjCBool>.alloc(1);
        isDir.initialize(ObjCBool(false));
        if !fileManager.fileExistsAtPath(CacheImageView_Cache_Path_tmpvar!,isDirectory:isDir) ||
            isDir.move().boolValue == false{
            do {
                //            func createDirectoryAtPath(path: String, withIntermediateDirectories createIntermediates: Bool, attributes: [NSObject : AnyObject]?, error: NSErrorPointer)
                try fileManager.createDirectoryAtPath(CacheImageView_Cache_Path_tmpvar!,withIntermediateDirectories:true,attributes:nil)
            } catch _ {
            };
        }
    }
    
    private class var imageCacheQueue:NSOperationQueue{
        struct YRSingleton{
            static var predicate:dispatch_once_t = 0
            static var instance:NSOperationQueue? = nil
        }
        dispatch_once(&YRSingleton.predicate,{
            YRSingleton.instance = NSOperationQueue();
            YRSingleton.instance!.maxConcurrentOperationCount = 10;
        })
        return YRSingleton.instance!
    }

    
    private var operation:CacheImageOperation?;
    
    public var path:String?{
        didSet{
            if self.path == oldValue && self.isImage == false {
                return;
            }
            self.loadImage();
        }
    }
    //
    
//    public init(path:String){
//        super.init();
//        self.path = path;
////        super.init();
//    }
    
//    public init(){
//        super.init();
//    }

    public override init(frame: CGRect) {
        super.init(frame:frame);
    }
    
    private func loadImage(){
        lock.lock();
        if let operation = self.operation {
            operation.cancel();
        }
        super.image = nil;
        if let path = self.path {
            isImage = false;
            operation = CacheImageOperation(path: path,imageView:self);
            CacheImageView.imageCacheQueue.addOperation(operation!);
        }
        lock.unlock();
    }
    
    public var imageChanged:(()->())?

    private var isImage:Bool = false;
    private var lock:NSRecursiveLock = NSRecursiveLock();
    public override var image: UIImage?{
        get{
            return super.image;
        }
        set{
            lock.lock();
            self.isImage = true;
            if let operation = self.operation {
                operation.cancel();
            }
            super.image = newValue;
            lock.unlock();
            if let imageChanged = self.imageChanged {
                imageChanged();
            }
        }
    }
    
    private func setImage(image:UIImage?){
        lock.lock();
        if self.isImage == false {
            super.image = image;
        }
        lock.unlock();
        if let imageChanged = self.imageChanged {
            imageChanged();
        }
    }

    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func removeFromSuperview() {
        if let operation = self.operation {
            operation.cancel();
        }
    }
    
//    public func reuse(){
//    
//    }

//    required public init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder);
//    }
}
