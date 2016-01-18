//
//  Header.h
//  books
//
//  Created by lin on 14-9-21.
//  Copyright (c) 2014年 lin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
//#import "books-Swift.h"
//#import "Catalog.h"

//@class Catalog;

//Catalog * PdfDictionary(CGPDFDocumentRef document);
NSDictionary * PdfDictionary(CGPDFDocumentRef document);
//void PdfDictionary(CGPDFDocumentRef document);

//CGImageRef thumbnailFromFile(NSString * fileName,unsigned int page);
CGImageRef thumbnailFromPDFFile(NSString * fileName,unsigned int page);
//void ThumbnailFromFile();

NSDictionary * PdfDocumentInfo(CGPDFDocumentRef document);