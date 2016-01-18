//
//  Catalog.swift
//  books
//
//  Created by lin on 14-9-21.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import Foundation


//@objc
public class Catalog:NSObject{
    public var items:[Catalog] = [Catalog]();
    
    public var title:String = "";
    public var page:UInt = 0;
    
    
    public func addItem(item:Catalog){
        items.append(item);
    }
}