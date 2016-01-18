//
//  Infos.swift
//  books
//
//  Created by lin on 14-9-14.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import Foundation


class Infos{
    var files:[String] = [String]();
    var modifys:[String] = [String]();
    var md5s:[String] = [String]();
    var positions:[UInt] = [UInt]();
    var selected:UInt = 0{
    didSet{
        self.saveCache();
    }
    }
    
    var selectedBooks:Int = -1{
        didSet{
            self.saveCache();
        }
    }
    
    init(){
        self.loadCache();
    }
    
    var cacheFile:String{
    get{
//        var path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String;
//        return "\(path)/infos.cache";
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] ;
        return "\(path)/infos.cache";
    }
    }
    func loadCache(){
    
    let fm = NSFileManager.defaultManager();
    if fm.isReadableFileAtPath(self.cacheFile) == false {
        return;
    }
//        var data:NSData = NSData.dataWithContentsOfFile(cacheFile, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: nil);
        
//         var data:NSData = NSData.dataWithContentsOfFile(cacheFile, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: nil);
//        let data:NSData = NSData.dataWithContentsOfMappedFile(cacheFile) as! NSData;
        let data:NSData = try! NSData(contentsOfURL: NSURL(fileURLWithPath: cacheFile), options: NSDataReadingOptions.DataReadingMappedIfSafe);
        let dict:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! NSDictionary;
    self.files = dict["files"] as! [String];
        self.modifys = dict["modifys"]as! [String];
        self.positions = dict["positions"] as! [UInt];
        self.md5s = dict["md5s"] as! [String];
        self.selected = dict["selected"] as! UInt;
        if let tmp = dict["selectedBooks"] as? Int {
            self.selectedBooks = tmp;
        }
    }
    func saveCache(){
    
    let fm = NSFileManager.defaultManager();
    if fm.isReadableFileAtPath(cacheFile) == false {
     fm.createFileAtPath(cacheFile,contents:nil,attributes:nil);
    }
        
        let dict = ["positions":self.positions as AnyObject,"files":self.files as AnyObject,
        "md5s":self.md5s as AnyObject,"modifys":self.modifys as AnyObject,
        "selected":self.selected,
        "selectedBooks":self.selectedBooks];
        let data:NSData=NSKeyedArchiver.archivedDataWithRootObject(dict);
//    //转成NSData类型后就可以写入本地磁盘了
    data.writeToFile(cacheFile,atomically:true);
    
    }
    
    //static let _install:Infos = Infos();
    class var install:Infos{
        get{
            //return _install;
            struct YRSingleton{
                static var predicate:dispatch_once_t = 0
                static var instance:Infos? = nil
            }
            dispatch_once(&YRSingleton.predicate,{
                YRSingleton.instance=Infos()
                }
            )
            return YRSingleton.instance!
    }
    }
    
    func pushFile(file:String){
        for (_,item) in files.enumerate(){
            if item == file{
                return;
            }
        }
        //self.files += file;
        self.files.append(file);
//        self.modifys += "";
        self.modifys.append("");
//        self.md5s += "";
        self.md5s.append("");
//        self.positions += 0;
        self.positions.append(0);
        self.saveCache();
    }
    
    func position(file:String)->UInt{
        for (index,item) in files.enumerate(){
            if item == file{
                return self.positions[index];
            }
        }
        return 0;
    }
    
    func position(file:String,position:UInt){
        for (index,item) in files.enumerate(){
            if item == file{
                self.positions[index] = position;
                self.saveCache();
                break;
            }
        }
    }
    
}