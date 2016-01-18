//
//  File.m
//  books
//
//  Created by lin on 14-9-21.
//  Copyright (c) 2014年 lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PdfDictionary.h"
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>
//#import "LinCore-swift.h"
//#import "LinCore/LinCore-swift.h"
//#import "books-swift.h"


uint returnCatalogListNumber(CGPDFDictionaryRef tempCGPDFDic,CGPDFDocumentRef document,int startPage,int pageCount)
{
        CGPDFArrayRef destArray;
        //if( CGPDFDictionaryGetArray(destDic, "D", &destArray) )
    if( CGPDFDictionaryGetArray(tempCGPDFDic, "Dest", &destArray) )
        {
            NSInteger targetPageNumber = 0; // The target page number
            
            CGPDFDictionaryRef pageDictionaryFromDestArray = NULL; // Target reference
            
            if (CGPDFArrayGetDictionary(destArray, 0, &pageDictionaryFromDestArray) == true)
            {
                //NSLog(@"---------------true");
                //NSInteger pageCount = CGPDFDocumentGetNumberOfPages(tempCGPDFDoc);
                
                for (NSInteger pageNumber = startPage; pageNumber <= pageCount; pageNumber++)
                {
                    CGPDFPageRef pageRef = CGPDFDocumentGetPage(document, pageNumber);
                    
                    CGPDFDictionaryRef pageDictionaryFromPage = CGPDFPageGetDictionary(pageRef);
                    
                    if (pageDictionaryFromPage == pageDictionaryFromDestArray) // Found it
                    {
                        targetPageNumber = pageNumber-1; break;
                    }
                }
            }
            else // Try page number from array possibility
            {
                //NSLog(@"***************true");
                CGPDFInteger pageNumber = 0; // Page number in array
                
                CGPDFArrayGetInteger(destArray, 0, &pageNumber);
                if (CGPDFArrayGetInteger(destArray, 0, &pageNumber) == true)
                {
                    targetPageNumber = pageNumber; // 1-based
                }
            }
            
            return (uint)targetPageNumber;
        }
    
    CGPDFDictionaryRef destDic = NULL;
    if( CGPDFDictionaryGetDictionary(tempCGPDFDic, "A", &destDic ))
        {
            CGPDFArrayRef destArray;
            if( CGPDFDictionaryGetArray(destDic, "D", &destArray) )
            {
                NSInteger targetPageNumber = 0; // The target page number
                
                CGPDFDictionaryRef pageDictionaryFromDestArray = NULL; // Target reference
                
                if (CGPDFArrayGetDictionary(destArray, 0, &pageDictionaryFromDestArray) == true)
                {
                    //NSInteger pageCount = CGPDFDocumentGetNumberOfPages(tempCGPDFDoc);
                    
                    for (NSInteger pageNumber = startPage; pageNumber <= pageCount; pageNumber++)
                    {
                        CGPDFPageRef pageRef = CGPDFDocumentGetPage(document, pageNumber);
                        
                        CGPDFDictionaryRef pageDictionaryFromPage = CGPDFPageGetDictionary(pageRef);
                        
                        if (pageDictionaryFromPage == pageDictionaryFromDestArray) // Found it
                        {
                            targetPageNumber = pageNumber-1; break;
                        }
                    }
                }
                else // Try page number from array possibility
                {
                    CGPDFInteger pageNumber = 0; // Page number in array
                    
                    CGPDFArrayGetInteger(destArray, 0, &pageNumber);//
                }
                return targetPageNumber;
            }
            
        }
        
//    }
    
    return 0;
}

//void PdfSubDictionary(CGPDFDictionaryRef namesDictionary,CGPDFDocumentRef document,Catalog * catalog){

void PdfSubDictionary(CGPDFDictionaryRef namesDictionary,CGPDFDocumentRef document,NSMutableDictionary * catalog){
    CGPDFDictionaryRef dic = NULL;

    if(CGPDFDictionaryGetDictionary(namesDictionary, "First", &dic))
    {
        uint num = 0;
        CGPDFStringRef myTitle;
        if( CGPDFDictionaryGetString(dic, "Title", &myTitle) )
        {
            NSMutableArray * items = [[NSMutableArray alloc] init];
            catalog[@"items"] = items;
            NSInteger pageCount = CGPDFDocumentGetNumberOfPages(document);
//            Catalog * item = [[Catalog alloc] init];
            NSMutableDictionary * item = [[NSMutableDictionary alloc] init];
            NSString *tempStr = (__bridge NSString *)CGPDFStringCopyTextString(myTitle);
            //item.title = tempStr;
            item[@"title"] = tempStr;
//            [catalog addItem:item];
            [items addObject:item];
            num = returnCatalogListNumber(dic,document,num+1,pageCount);
//            item.page = num;
            item[@"page"] = [[NSNumber alloc] initWithUnsignedInt:num];
            //NSLog(@"number:%@",num);
            
            CGPDFDictionaryRef tempDic = dic;
            PdfSubDictionary(dic,document,item);
            while ( CGPDFDictionaryGetDictionary( tempDic , "Next", &tempDic) )
                {
                    CGPDFStringRef tempTitle;
                    if( CGPDFDictionaryGetString(tempDic, "Title", &tempTitle) )
                    {
//                        item = [[Catalog alloc] init];
                        item = [[NSMutableDictionary alloc] init];
//                        [catalog addItem:item];
                        [items addObject:item];
                        tempStr = (__bridge NSString *)CGPDFStringCopyTextString(tempTitle);
//                        item.title = tempStr;
                        item[@"title"] = tempStr;
                        num = returnCatalogListNumber(tempDic,document,num+1,pageCount);
//                        item.page = num;
                        item[@"page"] = [[NSNumber alloc] initWithUnsignedInt:num];
                        //NSLog(@"number:%@",num);
                        PdfSubDictionary(tempDic,document,item);
                    }
                
            }
            
        }
    }

}
//
//
NSDictionary * PdfDictionary(CGPDFDocumentRef document){
//void PdfDictionary(CGPDFDocumentRef document){

//Catalog * catalog = [[Catalog alloc] init];
    NSMutableDictionary * catalog = [[NSMutableDictionary alloc] init];
    CGPDFDictionaryRef catalogDictionary = CGPDFDocumentGetCatalog(document);

    CGPDFDictionaryRef namesDictionary = NULL;
    if (CGPDFDictionaryGetDictionary(catalogDictionary, "Outlines", &namesDictionary)) {
        PdfSubDictionary(namesDictionary,document,catalog);
        
    }
    //catalog.title = @"-------";
    catalog[@"title"] = @"---------";
    return catalog;

}



//-(CGImageRef)thumbnailFromData:(NSData *)data andSize:(int)size {
//CGImageRef thumbnailFromData(NSString * fileName,unsigned int page){
CGImageRef thumbnailFromPDFFile(NSString * fileName,unsigned int page){
//void thumbnailFromPDFFile(CFStringRef fileName){
//void ThumbnailFromFile(){
//    NSString * fileName = @"";

//    unsigned int page = 0;
//    _myThumbnailImage = NULL;
    CGImageSourceRef myImageSource;
    CFStringRef   myKeys[3];
    CFDictionaryRef myOptions = NULL;
    CFTypeRef     myValues[3];
    
    CFNumberRef   thumbnailSize;
    
//    self.data       = data;
//    self.imageSize  = size;
    
    
    CFStringRef path = CFStringCreateWithCString(NULL,[fileName UTF8String],kCFStringEncodingUTF8);
    CFURLRef url = CFURLCreateWithFileSystemPath(NULL,path,kCFURLPOSIXPathStyle,0);
    
    //    IMAGEIO_EXTERN CGImageSourceRef CGImageSourceCreateWithURL(CFURLRef url, CFDictionaryRef options)
//    myImageSource = CGImageSourceCreateWithData((__bridge CFDataRef)self.data, NULL);
    myImageSource = CGImageSourceCreateWithURL(url,NULL);
    
    if (myImageSource == NULL) {
        fprintf(stderr, "Image Source is NULL");
    }
    int size = 500;
    thumbnailSize = CFNumberCreate(NULL, kCFNumberIntType, &size);
    
    myKeys[0] = kCGImageSourceCreateThumbnailWithTransform;
    myValues[0] = (CFTypeRef)kCFBooleanTrue;
    myKeys[1] = kCGImageSourceCreateThumbnailFromImageIfAbsent;
    myValues[1] = (CFTypeRef)kCFBooleanTrue;
    myKeys[2] = kCGImageSourceThumbnailMaxPixelSize;
    myValues[2] = (CFTypeRef)thumbnailSize;
    
    myOptions = CFDictionaryCreate(NULL, (const void **) myKeys,
                                   (const void **) myValues, 2,
                                   &kCFTypeDictionaryKeyCallBacks,
                                   & kCFTypeDictionaryValueCallBacks);
    // Create the thumbnail image using the specified options.
    
//    size_t totalPages = CGImageSourceGetCount(myImageSource);
//    if (_indexPage < 0 || _indexPage > totalPages) {
//        fprintf(stderr, "Thumbnail not created because indexPage it's not valid.\n");
//    }
    int _indexPage = page;
    
    CGImageRef _myThumbnailImage = CGImageSourceCreateThumbnailAtIndex(myImageSource,
                                                            _indexPage,
                                                            myOptions);
    // Release the options dictionary and the image source
    // when you no longer need them.
    CFRelease(thumbnailSize);
    CFRelease(myOptions);
    CFRelease(myImageSource);
    // Make sure the thumbnail image exists before continuing.
    if (!_myThumbnailImage) {
        fprintf(stderr, "Thumbnail image not created from image source.");
    }
    
    return _myThumbnailImage;
//    return
}


NSDictionary * PdfDocumentInfo(CGPDFDocumentRef document){
    
    CGPDFDictionaryRef infoDict = CGPDFDocumentGetInfo(document);
    CGPDFStringRef string;
    if (CGPDFDictionaryGetString(infoDict, "Title", &string))
//        setCGPDFStringValue(titleField, string);
    if (CGPDFDictionaryGetString(infoDict, "Author", &string))
//        setCGPDFStringValue(authorField, string);
    if (CGPDFDictionaryGetString(infoDict, "Subject", &string))
//        setCGPDFStringValue(subjectField, string);
    if (CGPDFDictionaryGetString(infoDict, "Keywords", &string))
//        setCGPDFStringValue(keywordsField, string);
    if (CGPDFDictionaryGetString(infoDict, "Creator", &string))
//        setCGPDFStringValue(creatorField, string);
    if (CGPDFDictionaryGetString(infoDict, "Producer", &string))
//        setCGPDFStringValue(producerField, string);
    if (CGPDFDictionaryGetString(infoDict, "CreationDate", &string))
//        setCGPDFStringValueAsDate(createdField, string);
        if (CGPDFDictionaryGetString(infoDict, "ModDate", &string)){
            
        }
//        setCGPDFStringValueAsDate(modifiedField, string);
    return nil;
}
