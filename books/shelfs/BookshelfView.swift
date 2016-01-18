//
//  BookshelfView.swift
//  reader
//
//  Created by lin on 14-9-13.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import Foundation
import UIKit
import LinCore


public class BookshelfView:UIView,UITableViewDataSource,UITableViewDelegate{
    public var shelf:Bookshelf?{
        didSet{
            self.table.reloadData();
            self.table.beginUpdates();           
            self.table.endUpdates();
        }
    }
    private var table:UITableView!;
    public var selected:((document:PdfDocument)->())?;
    
    public var edited:Bool = false{
        didSet{
            self.table.setEditing(self.edited, animated: true);
            self.table.allowsMultipleSelection = edited;
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(shelf:Bookshelf!,frame:CGRect = CGRectMake(0, 0, 0, 0)){
        self.shelf = shelf;
        super.init(frame:frame);
        self.initView();
    }
    
    private func initView(){

        table = UITableView();
//        self.table.allowsMultipleSelection = true;
        
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
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if(self.edited){
            return;
        }
        if let selected = self.selected{
//            var path = NSBundle.mainBundle().pathForResource("sample", ofType:"pdf",inDirectory:nil);
            if let shelf = self.shelf {
                selected(document:shelf.documents[indexPath.row]!);
            }
        }
    }
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.shelf?.documents.count ?? 0;
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 85;
    }
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
//        cell = [self.tableView dequeueReusableCellWithIdentifier:@"prototypeCell"];
        var cell = self.table.dequeueReusableCellWithIdentifier("bookshelf-cell") as? BookshelfCell;
        if(cell == nil){
            cell = BookshelfCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "bookshelf-cell");
        }
//        var cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil);
//        cell!.textLabel?.text = shelf!.documents[indexPath.row]!.name;
//
//        var image:UIImage = UIImage(named:"qq.jpg")!;
//        cell.imageView?.image = image;
        
//        var button = MGSwipeButton(title: "test", backgroundColor: UIColor.redColor());
//        cell.leftButtons = [button];
//        cell.isSwipe = false;
        cell!.update(shelf!.documents[indexPath.row]);
////        cell.setEditing(true, animated: true);
//        cell.swipeOffset = 0;
        return cell!;
    }
    
    public func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
//        return UITableViewCellEditingStyle.Delete | UITableViewCellEditingStyle.Insert;
        return UITableViewCellEditingStyle(rawValue: UITableViewCellEditingStyle.Delete.rawValue | UITableViewCellEditingStyle.Insert.rawValue)!;
    }
    
    
    
    
    
    
    
    
    
    
    
//    - (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//    {
//    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
//    }
    
    

}

public class BookshelfCell : MGSwipeTableCell{
//public class BookshelfCell : UITableViewCell{
    public override init(style:UITableViewCellStyle,reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initView();
    }
    
    private var title:UILabel!;
    private var subtitle:UILabel!;
    private var progess:UILabel!;
    private var lastDate:UILabel!;
    private var thumbnail:UIImageView!

    private func initView(){
        
//        self.contentView.backgroundColor = UIColor.grayColor();
        title = UILabel();
        
        title.translatesAutoresizingMaskIntoConstraints = false;
        
        title.font = UIFont.systemFontOfSize(24);
        self.contentView.addSubview(title);
        
        self.addConstraints([NSLayoutConstraint(item: title, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 120.0),
            NSLayoutConstraint(item: title, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -150.0),
            NSLayoutConstraint(item: title, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: title, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 0.0, constant: 50.0)]);
        
        
        subtitle = UILabel();
        subtitle.translatesAutoresizingMaskIntoConstraints = false;
        self.contentView.addSubview(subtitle);
        self.addConstraints([NSLayoutConstraint(item: subtitle, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 120.0),
            //            NSLayoutConstraint(item: title, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: subtitle, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 50.0),
            NSLayoutConstraint(item: subtitle, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 0.0, constant: 30.0)]);
        
        
        thumbnail = UIImageView();
        thumbnail.translatesAutoresizingMaskIntoConstraints = false;
        
        self.contentView.addSubview(thumbnail);
        
        self.addConstraints([NSLayoutConstraint(item: thumbnail, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 20.0),
            NSLayoutConstraint(item: thumbnail, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 100.0),
            NSLayoutConstraint(item: thumbnail, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 5.0),
            NSLayoutConstraint(item: thumbnail, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: -10.0)]);
        
        progess = UILabel();
        progess.translatesAutoresizingMaskIntoConstraints = false;
       
        self.contentView.addSubview(progess);
        
        self.addConstraints([
//            NSLayoutConstraint(item: progess, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 120.0),
            NSLayoutConstraint(item: progess, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: progess, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: progess, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 0.0, constant: 30.0)]);
        
        lastDate = UILabel();
        lastDate.translatesAutoresizingMaskIntoConstraints = false;
        self.contentView.addSubview(lastDate);
        
        self.addConstraints([
            //            NSLayoutConstraint(item: lastDate, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 120.0),
            NSLayoutConstraint(item: lastDate, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: lastDate, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 30.0),
            NSLayoutConstraint(item: lastDate, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 0.0, constant: 30.0)]);
    }
    public func update(document:PdfDocument?){
        title.text = document?.name;
        let subject = document?.subject ?? " ";
        let author = document?.author ?? " ";
//        subtitle.text = "subject:\(subject)    author:\(author)";
        subtitle.text = "\(subject)  \(author)";
        
        progess.text = "23/234   ";
        lastDate.text = "2015-12-12 23:33";
        
        let image:UIImage = UIImage(named:"qq.jpg")!;
        thumbnail.image = image;
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

