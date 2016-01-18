//
//  ClassView.swift
//  books
//
//  Created by lin on 14-9-14.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import Foundation
import UIKit

public class ClassView:UIView,UITableViewDataSource,UITableViewDelegate{
    
    public var shelfs:Bookshelfs!;
    public var selected:((shelf:Bookshelf)->())?;
    
   
    public init(shelfs:Bookshelfs){
        self.shelfs = shelfs;
        super.init(frame:CGRectMake(0, 0, 0, 0));
        
        let table = UITableView(frame:frame);
        table.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(table);
        
        self.addConstraints([
            NSLayoutConstraint(item: table, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: table, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: table, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: table, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0)
            ]);
        
        table.dataSource = self;
        table.delegate = self;
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if let selected = self.selected{
//            var path = NSBundle.mainBundle().pathForResource("sample", ofType:"pdf",inDirectory:nil);
            selected(shelf:self.shelfs.shelfs![indexPath.row]!);
        }
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.shelfs.shelfs!.count;
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell();
        
        cell.textLabel?.text = shelfs.shelfs![indexPath.row]!.name;
        return cell;
    }
}