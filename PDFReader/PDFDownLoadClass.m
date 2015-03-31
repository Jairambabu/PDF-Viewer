//
//  PDFDownLoadClass.m
//  DocuStrator
//
//  Created by connexmac2 on 6/11/14.
//  Copyright (c) 2014 ConnexInfoSystem. All rights reserved.
//

#import "PDFDownLoadClass.h"
#import "PTJUtility.h"
#import "SVProgressHUD.h"

@implementation PDFDownLoadClass

-(void)downloadImageImageName:(NSString*)strImageName{
    
    [SVProgressHUD dismiss];
    
    //[self cacheDirectory:[NSString stringWithFormat:@"%@.png",strImageName];
    NSMutableArray *arrImage=[[NSMutableArray alloc]init];
    [arrImage addObject:[self cacheDirectory:[NSString stringWithFormat:@"%@.png",strImageName]]];
    [self.delegate PDFDownLoadClass:arrImage];
    
}
-(void)converterPDF_to_JPEG_PDF_Name:(NSString*)strPDF_Name{
    
    // NSString *strFileName = @"TestFile1";
    
    
    
    [SVProgressHUD showWithStatus:@"Please wait..."];
    
    dispatch_queue_t Queue= dispatch_queue_create("Queue", NULL);
    
    dispatch_async(Queue, ^{
        
        NSArray *pageArray;
        
        pageArray = [NSArray arrayWithArray:[[PTJUtility sharedPTJUtility] ptjGetImagesFromPDFWithName:strPDF_Name progressView:nil]];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            [SVProgressHUD dismiss];
            
            
            [self.delegate PDFDownLoadClass:pageArray];
            
            
        });
        
    });
    
    
    
}
-(NSString*)cacheDirectory:(NSString*)strName{
    
    NSString *strPath=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *strFilePath=[strPath stringByAppendingPathComponent:strName];
    
    return strFilePath;
}

@end
