
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PTJUtility : NSObject {
    
}

///Public Methods
///PDF Utility
- (NSArray *)ptjGetImagesFromPDFWithName:(NSString *)fileName progressView:(UIProgressView*)progressBar; ///To Get the array of images paths from PDF
+ (PTJUtility*)sharedPTJUtility; ///To get shared object
- (NSString *)joinImagesAsPDF:(NSArray *)images fileName:(NSString *)fileName; ///Join Images into PDF

///File System
- (BOOL)ptjFileExistsAtPath:(NSString *)path; ///To Check existance of file
- (void)ptjRemoveFilesInFolder:(NSString *)folderName; ///To Remove the file
- (NSMutableArray *)ptjGetPathsInFolder:(NSString *)folderName; ///To get file paths in folder
//error message "meeting not started "

@end
