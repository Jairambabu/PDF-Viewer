
#import "PDFImageConverter.h"
#import "LGTUtility.h"
#define kBorderInset            20.0
#define kBorderWidth            1.0
#define kMarginInset            10.0

//Line drawing
#define kLineWidth              1.0

//Page Size
#define kPageSize  CGSizeMake(612, 812)



@implementation PDFImageConverter

+ (NSData *) convertImageToPDF: (UIImage *) image {
    return [PDFImageConverter convertImageToPDF: image withResolution: 96];
}

+ (NSData *) convertImageToPDF: (UIImage *) image withResolution: (double) resolution {
    return [PDFImageConverter convertImageToPDF: image withHorizontalResolution: resolution verticalResolution: resolution];
}

+ (NSData *) convertImageToPDF: (UIImage *) image withHorizontalResolution: (double) horzRes verticalResolution: (double) vertRes {
    if ((horzRes <= 0) || (vertRes <= 0)) {
        return nil;
    }
    
    double pageWidth = image.size.width * image.scale * 72 / horzRes;
    double pageHeight = image.size.height * image.scale * 72 / vertRes;
    
    NSMutableData *pdfFile = [[NSMutableData alloc] init];
    CGDataConsumerRef pdfConsumer = CGDataConsumerCreateWithCFData((CFMutableDataRef)pdfFile);
    // The page size matches the image, no white borders.
    CGRect mediaBox = CGRectMake(0, 0, pageWidth, pageHeight);
    CGContextRef pdfContext = CGPDFContextCreate(pdfConsumer, &mediaBox, NULL);
    
    CGContextBeginPage(pdfContext, &mediaBox);
    CGContextDrawImage(pdfContext, mediaBox, [image CGImage]);
    CGContextEndPage(pdfContext);
    CGContextRelease(pdfContext);
    CGDataConsumerRelease(pdfConsumer);
    
    return pdfFile;
}

+ (NSData *) convertImageToPDF: (UIImage *) image withResolution: (double) resolution maxBoundsRect: (CGRect) boundsRect pageSize: (CGSize) pageSize {
    if (resolution <= 0) {
        return nil;
    }
    
    double imageWidth = image.size.width * image.scale * 72 / resolution;
    double imageHeight = image.size.height * image.scale * 72 / resolution;
    
    double sx = imageWidth / boundsRect.size.width;
    double sy = imageHeight / boundsRect.size.height;
    
    // At least one image edge is larger than maxBoundsRect
    if ((sx > 1) || (sy > 1)) {
        double maxScale = sx > sy ? sx : sy;
        imageWidth = imageWidth / maxScale;
        imageHeight = imageHeight / maxScale;
    }
    
    // Put the image in the top left corner of the bounding rectangle
    CGRect imageBox = CGRectMake(boundsRect.origin.x, boundsRect.origin.y + boundsRect.size.height - imageHeight, imageWidth, imageHeight);
    
    NSMutableData *pdfFile = [[NSMutableData alloc] init];
    CGDataConsumerRef pdfConsumer = CGDataConsumerCreateWithCFData((CFMutableDataRef)pdfFile);
    
    CGRect mediaBox = CGRectMake(0, 0, pageSize.width, pageSize.height);
    CGContextRef pdfContext = CGPDFContextCreate(pdfConsumer, &mediaBox, NULL);
    
    CGContextBeginPage(pdfContext, &mediaBox);
    CGContextDrawImage(pdfContext, imageBox, [image CGImage]);
    CGContextEndPage(pdfContext);
    CGContextRelease(pdfContext);
    CGDataConsumerRelease(pdfConsumer);
    
    return pdfFile;
}

+ (NSString *) convertImagesToPDF: (NSArray *)images withResolution: (double) resolution maxBoundsRect: (CGRect) boundsRect pageSize: (CGSize) pageSize thefilePath:(NSString *)thefilePath {
    if (resolution <= 0) {
        return nil;
    }
    
    NSInteger currentPage = 0;
    
    UIGraphicsBeginPDFContextToFile(thefilePath, CGRectZero, nil);
    
    for (NSString *strImagePath in images) {
        
        
        UIImage *image = [UIImage imageWithContentsOfFile:[LGTUtility cacheDirectory:strImagePath]];
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil);
        [image drawInRect:CGRectMake(boundsRect.origin.x,boundsRect.origin.y*currentPage,boundsRect.size.width,boundsRect.size.height)];
        currentPage++;
        //[PDFImageConverter drawPageNumber:currentPage];
    }
    
    UIGraphicsEndPDFContext();
    
    return thefilePath;
}


+ (void)drawPageNumber:(NSInteger)pageNumber
{
    NSString* pageNumberString = [NSString stringWithFormat:@"Page %ld", (long)pageNumber];
    UIFont* theFont = [UIFont systemFontOfSize:12];
    
    CGSize pageNumberStringSize = [pageNumberString sizeWithFont:theFont
                                               constrainedToSize:kPageSize
                                                   lineBreakMode:NSLineBreakByWordWrapping];
     
    CGRect stringRenderingRect = CGRectMake(kBorderInset,
                                            kPageSize.height - 40.0,
                                            kPageSize.width - 2*kBorderInset,
                                            pageNumberStringSize.height);
    
    [pageNumberString drawInRect:stringRenderingRect withFont:theFont lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
}

@end
