//
//  Bookshelf.swift
//  reader
//
//  Created by lin on 14-9-13.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import Foundation


public class Bookshelf{
    
    var documents:[PdfDocument?]!;// = PdfDocument[]();
    var name:String!;
    
    init(name:String,path:String){
        self.name = name;
        
        let fm = NSFileManager.defaultManager();
        let files = try? fm.contentsOfDirectoryAtPath(path);
        if let files = files{
            //var tmps:PdfDocument?[] = new PdfDocument?[files.count];
            var tmps:[PdfDocument?] = [PdfDocument?]();
            var N:Int = 0;
            for file in files {
                if file.hasSuffix(".pdf") {
                    //tmps[N] = PdfDocument(file:"\(name)/\(file)",path:"\(path)/\(file)");
                    tmps.append(PdfDocument(file:"\(name)/\(file)",path:"\(path)/\(file)"))
                    N++;
                    Infos.install.pushFile("\(name)/\(file)");
                }
            }
            //self.documents = new PdfDocument?[N];
            self.documents = [PdfDocument?]();
            for var n=0;n<N;n++ {
                self.documents.append(tmps[n]);
            }
        }else{
            self.documents = [PdfDocument?]();
        }
    }
    
}