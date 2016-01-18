//
//  NSExceptions.swift
//  LinCore
//
//  Created by lin on 2/3/15.
//  Copyright (c) 2015 lin. All rights reserved.
//

import Foundation


public extension NSException{
 public func toString(method:String? = __FUNCTION__, file:String? = __FILE__, line:Int = __LINE__)->String{
        
        var str = "";
        let message = "\(self.name): \(self.reason!)"
        str = str + message;
        str = str + "\n" + "type:" + self.name;
        str = str + "\n" + "value:" + (self.reason ?? "");
        
        if (method != nil && file != nil && line > 0) {
            str = str + "\nfilename\t" + (file! as NSString).lastPathComponent + " function\t" + method! + "lineno\t\(line)";
        }
        
        let callStack = self.callStackSymbols
        
        for call in callStack {
            str = str + "\nfunction:\(call)";
        }
//        Log.log.error(error: str);

        return str;
    }
}