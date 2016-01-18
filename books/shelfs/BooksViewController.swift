//
//  ViewController.swift
//  reader
//
//  Created by lin on 14-8-26.
//  Copyright (c) 2014年 lin. All rights reserved.
//

import UIKit
import LinCore
import LinUtil

public class BooksViewController: UINavigationController {
    
    private var booksVeiwController:BookshelfViewController!;
    
    public init(){
        
        //---------------------------------------------------------------------------
        //var file = "";
        //        var path = NSBundle.mainBundle().pathForResource("sample", ofType:"pdf",inDirectory:nil);
        //        var pdfc:UIViewController = PdfViewController(document:PdfDocument(file:"file",path:path!));
        //        pdfc.view.frame = self.view.frame;
        //
        //
        //        self.addChildViewController(pdfc);
        //
        //        self.view.addSubview(pdfc.view);
        //        self.view.bringSubviewToFront(pdfc.view);
        //---------------------------------------------------------------------------
        
//        NSNumber *bl = (NSNumber*) CFPreferencesCopyAppValue(CFSTR("SBBacklightLevel" ), CFSTR("com.apple.springboard"));
//        
//        　　previousBacklightLevel = [bl floatValue]; //a variable to store the previous level so you can reset it.
       // func CFPreferencesCopyAppValue(key: CFString!, applicationID: CFString!) -> CFPropertyList!

        //******************************************************************************
        
#if TARGET_IPHONE_SIMULATOR
    let books = Bookshelfs(path:"/material");
#else
    var path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] ;
    var books = Bookshelfs(path:path+"/books");
#endif
        let booksc = BookshelfViewController(books: books);

        
        super.init(rootViewController: booksc);
        
        booksc.documentSelected = self.selected;
        booksc.shelfSelected = self.shelfSelected;
        
        self.booksVeiwController = booksc;
        
        let shelfs = booksc.books?.selected?.documents;//[Infos.install.selectedBooks]
        if let shelfs = shelfs {
            if Infos.install.selectedBooks >= 0 && Infos.install.selectedBooks < shelfs.count {
                let document = shelfs[Infos.install.selectedBooks];
                if let document = document {
                    Queue.mainQueue({[weak self] () -> () in
                        self!.selected(document);
                    })
                    
                }
            }
        }
    }
    
    var pdfc:PdfViewController?{
        didSet{
            if let pdfc = self.pdfc{
                pdfc.back = self.back;
                pdfc.pageChanged = self.pageChanged;
            }
            
            if let pdfc = oldValue{
                pdfc.view.removeFromSuperview();
                pdfc.removeFromParentViewController();
                pdfc.back = nil;
                pdfc.pageChanged = nil;
            }
        }
    }
    
    func pageChanged(page:UInt){
        Infos.install.position(self.pdfc!.document.file,position:page);
    }
    func back(){
        self.pdfc?.dismissViewControllerAnimated(true, completion: nil);
        self.selected(nil);
    }
    var selectedDocument:PdfDocument?;
    func selected(document:PdfDocument!){
        if(document == nil){
            Infos.install.selectedBooks = -1;
            return;
        }
        if(document.document == nil){
            AlertView.show("图书已损坏，不能打开！");
            return;
        }
        
        let documents = self.booksVeiwController.books?.selected?.documents;//[Infos.install.selectedBooks]
        if let documents = documents {
            for (index,item) in documents.enumerate() {
                if item != nil && item!.name == document.name {
                    Infos.install.selectedBooks = index;
                    break;
                }
            }
            //            if Infos.install.selectedBooks >= 0 && Infos.install.selectedBooks < shelfs.count {
            //                var document = shelfs[Infos.install.selectedBooks];
            //                if let document = document {
            //                    self.selected(document);
            //                }
            //            }
        }
        
        
        let pageNo = Infos.install.position(document.file)
        pdfc = PdfViewController(document:document,pageNo:pageNo);
        self.pdfc!.view.frame = self.view.frame;
        
        
        self.presentViewController(self.pdfc!, animated: true, completion: nil);
        
    }
    
    func shelfSelected(shelf:Bookshelf){
//         var documents = self.booksVeiwController.books?.selected?.documents;
        let shelfs = self.booksVeiwController.books?.shelfs;
        if let shelfs = shelfs {
            for (index,item) in shelfs.enumerate(){
                if(shelf.name == item?.name){
                    Infos.install.selected = UInt(index);
                }
            }
        }
    }
    
    private override init(nibName: String?, bundle: NSBundle?){
        super.init(nibName: nibName, bundle: bundle);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad();
        self.tabBarItem = UITabBarItem();
        self.tabBarItem.title = "图书";
    }
}