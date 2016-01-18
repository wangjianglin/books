//
//  bookshelfs.swift
//  reader
//
//  Created by lin on 14-9-13.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import Foundation


public class Bookshelfs{
    
    //var shelfs: Dictionary<String, Bookshelf>!;
    public var shelfs: [Bookshelf?]?;//  = Bookshelf[]();
    public var selected:Bookshelf?{
    didSet{
        if let shelfs = self.shelfs{
        for (index,item) in shelfs.enumerate(){
            if item === self.selected! {
                Infos.install.selected = UInt(index);
                return;
            }
        }
        }
        Infos.install.selected = 0;
    }
    }
    
//    class func shelfs()->Bookshelfs{
//        
//        var shelfs = Bookshelfs();
//        return shelfs;
//    }
    
    public init(){}
    public init(path:String){
//        println("path:\(path)");
        let fm = NSFileManager.defaultManager();
        let files = try? fm.contentsOfDirectoryAtPath(path);
        
        if let files = files{
            
            //var tmps:Bookshelf?[] = new Bookshelf?[files.count];//(count:4);
            var tmps:[Bookshelf?] = [Bookshelf?]();//(count:4);
            var N:Int = 0;
            for file in files{
                if let tmp = self.initShelf(fm,dir:path,name:file){
                    //tmps[N] = tmp;
                    tmps.append(tmp);
                    N++;
                }
            }
            //self.shelfs = new Bookshelf?[N];
            self.shelfs = [Bookshelf?]();
            for var n=0;n<N;n++ {
                //self.shelfs![n] = tmps[n];
                self.shelfs!.append(tmps[n]);
                }
        }else{
            self.shelfs = [Bookshelf?]();
        }
        var pos = Infos.install.selected;
//        if Int(pos) >= self.shelfs.count{
//            pos = 0;
//        }
        if self.shelfs!.count > 0 {
            if pos < 0{
                pos = 0;
            }
            if Int(pos) >= self.shelfs!.count{
                pos = UInt(self.shelfs!.count - 1);
            }
            self.selected = self.shelfs![Int(pos)];
        }
    }
    
    private func initShelf(fm:NSFileManager,dir:String,name:String)->Bookshelf!{
        let path = "\(dir)/\(name)";
        if fm.fileExistsAtPath(path) == false{
            return nil;
        }
        if fm.isReadableFileAtPath(path) == false{
            return nil;
        }
        let attrs = (try? fm.attributesOfItemAtPath(path)) as Dictionary?;
        if let attrs = attrs{
            for (name,value) in attrs{
                if name == "NSFileType" {
                    if value as! String != "NSFileTypeDirectory" {
                        return nil;
                    }
                    break;
                }
                //println("name:\(name)\tvalue:\(value)");
            }
        }else{
            return nil;
        }
        
        //self.shelfs += Bookshelf(name:name,path:path);
        return Bookshelf(name:name,path:path);
    }
    
}