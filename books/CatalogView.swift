//
//  CatalogView.swift
//  books
//
//  Created by lin on 14-9-21.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import Foundation
import UIKit


class CatalogView:UIView,UITableViewDataSource,UITableViewDelegate{

    private var catalog:Catalog!;
    private var table:UITableView!;
    private var pageNos:[UInt?]!;// = UInt?[]();
    private var titles:[String?]!;// = String?[]();
    init(catalog:Catalog){
        self.catalog = catalog;
        super.init(frame:CGRectMake(0, 0, 0, 0));
        
        table = UITableView(frame:frame);
        self.addSubview(table);
        //self.toArray(catalog);
        let count = catalogCount(catalog);
        self.titles = [String?](count: count, repeatedValue:"");
        self.pageNos = [UInt?](count: count, repeatedValue:0);
        var pos:Int = 0;
        for var n=0;n<catalog.items.count;n++ {
            pos = self.toArray(catalog.items[n],index:0,pos:pos);
        }
        
        table.dataSource = self;
        table.delegate = self;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func catalogCount(catalog:Catalog)->Int{
        var r:Int = 1;
        for var n=0;n<catalog.items.count;n++ {
            r += catalogCount(catalog.items[n]);
        }
        return r;
    }
    func toArray(catalog:Catalog,index:Int,pos:Int)->Int{
        var tmp = "";
        for var n=0;n<index;n++ {
            tmp += "        ";
            }
        self.titles[pos] = tmp+catalog.title;
        self.pageNos[pos] = catalog.page;
        var tmpPos = pos+1;
        for var n=0;n<catalog.items.count;n++ {
            tmpPos = self.toArray(catalog.items[n],index:index+1,pos:tmpPos);
        }
        return tmpPos;
    }
    
    var pageChanged:((page:UInt)->())?;
    
    override func layoutSubviews() {
        table.frame = self.bounds;
    }
 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return titles.count;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if let pageChanged = self.pageChanged{
            pageChanged(page:self.pageNos[indexPath.row]!);
        }
    }
    
    private let CatalogViewCellTableIdentifier = "CatalogViewCell";
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell = tableView.dequeueReusableCellWithIdentifier(CatalogViewCellTableIdentifier);
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CatalogViewCellTableIdentifier);
        }
        cell?.textLabel?.text = titles[indexPath.row];
        return cell!;
    }
}
