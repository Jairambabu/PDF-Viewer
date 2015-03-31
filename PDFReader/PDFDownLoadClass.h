//
//  PDFDownLoadClass.h
//  DocuStrator
//
//  Created by Jairam Babu on 6/11/14.
//  Copyright (c) 2014 JairamBabu. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PDFDownLoadDelegate <NSObject>

-(void)PDFDownLoadClass:(NSArray*)arrImage;
-(void)PDFDownLoadClassErorr:(NSError *)error;
@end

@class ASINetworkQueue;
@interface PDFDownLoadClass : NSObject
{
  ASINetworkQueue *networkQueue;
    BOOL failed;
}
@property (nonatomic, weak) id<PDFDownLoadDelegate>delegate;
-(void)PDFDownLoad_URL:(NSString*)strUrl DocumentName:(NSString*)strDocumentName FileWithUserId:(NSString*)strNameOfFile progressIndicator:(UIProgressView*)progressIndicator;
-(void)converterPDF_to_JPEG_PDF_Name:(NSString*)strPDF_Name;
@end
