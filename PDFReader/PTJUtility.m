

#import "PTJUtility.h"
#import "LGTUtility.h"
#import "PDFImageConverter.h"
#define  kPrefix @"PDFToJPG"
#define  kPrefixPDF @"JPGToPDF"


int PDFPagesInBuffer;
CGRect pageRect;
static PTJUtility* _sharedPTJUtility;

@interface PTJUtility () {
    const char *filename;
    NSString *strFileName;
    
}

@end


@implementation PTJUtility

+ (PTJUtility *)sharedPTJUtility {
    
    @synchronized(self) {
        if (_sharedPTJUtility == nil)
        {
            _sharedPTJUtility = [[self alloc] init]; // assignment not done here
        }
    }
    
    return _sharedPTJUtility;
}



#pragma mark- Public Methods

- (NSArray *)ptjGetImagesFromPDFWithName:(NSString *)fileName progressView:(UIProgressView*)progressBar {
    
    NSArray *arrfileName = [fileName componentsSeparatedByString:@"/"];
    strFileName = [arrfileName lastObject];
    strFileName = [strFileName stringByReplacingOccurrencesOfString:@".pdf" withString:@""];
   
    
    //NSString *strFilePath =NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
   // NSString *strFileNameTemp=[strFilePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",fileName]];
    
    //NSString *strFileNameTemp = [[NSBundle mainBundle] pathForResource:fileName ofType:@"pdf"];
    
    if (!fileName) {
        return nil;
    }
    
    filename = [fileName cStringUsingEncoding:NSASCIIStringEncoding];
    getPDFDocumentRef(filename);
    ///work with image array - code field
    NSMutableArray *arrImageName=[[NSMutableArray alloc]init];
    for (int counter = 0; counter < PDFPagesInBuffer; counter++)
    {
        
        [arrImageName addObject:[LGTUtility cacheDirectory:[NSString stringWithFormat:@"%@%d.jpg",strFileName,counter+1]]];
        [_sharedPTJUtility loadPageToBuffer:counter+1 append:YES imageName:strFileName];
        
        
        
        
    }
    progressBar.hidden=YES;
    return arrImageName;
    // return [_sharedPTJUtility ptjGetPathsInFolder:strFileName];
}

- (NSString *)joinImagesAsPDF:(NSArray *)images fileName:(NSString *)fileName {
    if ([images count] == 0) {
        return nil;
    }
    
    //return [PDFImageConverter convertImagesToPDF:images withResolution:612.0*792.0 maxBoundsRect:CGRectMake(0, 0, 612, 792) pageSize:CGSizeMake(612, 792) thefilePath:[_sharedPTJUtility ptjGetFilePathWithFileName:[NSString stringWithFormat:@"%@.pdf",fileName] folderName:[NSString stringWithFormat:@"%@%@",kPrefixPDF,strFileName]]];
    
    return  [PDFImageConverter convertImagesToPDF:images withResolution:612.0*792.0 maxBoundsRect:CGRectMake(0, 0, 612, 792) pageSize:CGSizeMake(612, 792) thefilePath:[LGTUtility cacheDirectory:[NSString stringWithFormat:@"%@.pdf",fileName]]];
    
    return nil;
}

#pragma PDF To Image Array

- (void) loadPageToBuffer:(int)counter append:(BOOL) append imageName:(NSString*)strImageName
{
    @autoreleasepool {
        // if append == YES then append to tail, else insert to the beginning of the array
        
        
        
        CGPDFDocumentRef document;
        CGPDFPageRef page;
        
        document = getPDFDocumentRef (filename);
        page = CGPDFDocumentGetPage (document, 1);
        pageRect =  CGPDFPageGetBoxRect(page, kCGPDFCropBox);
        
        CGPDFDocumentRelease (document);
        
        
        //CGSize size = CGSizeMake(736,564);
        CGSize size = pageRect.size;
        UIGraphicsBeginImageContext(size);
        
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(context, 0, size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        displayPDFPage(context, counter, filename);
        
        UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
        if (append) {
            
            NSData *imageData = UIImageJPEGRepresentation(image,0.7);
            if(![[NSFileManager defaultManager]fileExistsAtPath:[LGTUtility cacheDirectory:[NSString stringWithFormat:@"%@%d.jpg",strImageName,counter]]])
            {
                [imageData writeToFile:[LGTUtility cacheDirectory:[NSString stringWithFormat:@"%@%d.jpg",strImageName,counter] ] atomically:YES];
                
            }
            //[_sharedPTJUtility uSaveImage:image imageName:[NSString stringWithFormat:@"%@%d.jpg",strImageName,counter] folderName:[NSString stringWithFormat:@"%@%@",kPrefix,strFileName]];
            //[NSThread sleepForTimeInterval:1.0];
        }
        else {
            NSLog(@"Added page's in begin of array");
        }
        
        image = nil;
        
        UIGraphicsEndImageContext();
    }
}


void displayPDFPage (CGContextRef myContext, size_t pageNumber, const char *filename)
{
    CGPDFDocumentRef document;
    CGPDFPageRef page;
    
    document = getPDFDocumentRef (filename);
    page = CGPDFDocumentGetPage (document, pageNumber);
    CGContextDrawPDFPage (myContext, page);
    CGPDFDocumentRelease (document);
}


CGPDFDocumentRef getPDFDocumentRef (const char *filename)
{
    CFStringRef path;
    CFURLRef url;
    CGPDFDocumentRef document;
    
    
    path = CFStringCreateWithCString (NULL, filename, kCFStringEncodingUTF8);
    url = CFURLCreateWithFileSystemPath (NULL, path, kCFURLPOSIXPathStyle, 0);
    CFRelease (path);
    document = CGPDFDocumentCreateWithURL (url);
    CFRelease(url);
    PDFPagesInBuffer =(int) CGPDFDocumentGetNumberOfPages (document);
    if (PDFPagesInBuffer == 0) {
        printf("`%s' needs at least one page!", filename);
        return NULL;
    }
    //printf("'%d' pages ", count);
    return document;
}


#pragma mark- File System
- (void)uSaveImage:(UIImage *)image imageName:(NSString *)imageName folderName:(NSString *)folderName {
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *tempPath = [docPaths objectAtIndex:0];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSFileManager *fileMGR = [NSFileManager defaultManager];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    BOOL isDir= TRUE;
    if (![fileMGR fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",folderName]] isDirectory:&isDir]) {
        [fileMGR createDirectoryAtPath:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",folderName]]  withIntermediateDirectories:FALSE attributes:nil error:nil];
    }
    
    NSString *fileName = [NSString stringWithFormat:@"%@/%@/%@",tempPath,folderName,imageName];
    
    [imageData writeToFile:fileName atomically:YES]; //Write the file
    
}



- (NSString *)uGetPath:(NSString *)folderName fileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",folderName,fileName]];
    return savedImagePath;
}

- (BOOL)ptjFileExistsAtPath:(NSString *)path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return TRUE;
    }
    return FALSE;
}

- (void)ptjRemoveFilesInFolder:(NSString *)folderName {
    NSMutableArray *arrPaths = [_sharedPTJUtility ptjGetPathsInFolder:folderName];
    for (NSString *strImagePath in arrPaths) {
        [_sharedPTJUtility ptjRemoveFileAtPath:strImagePath];
    }
}


- (BOOL)ptjRemoveFileAtPath:(NSString *)path {
    if ([_sharedPTJUtility ptjFileExistsAtPath:path]) {
        NSError *error;
        if ([[NSFileManager defaultManager] removeItemAtPath:path error:&error]) {
            return TRUE;
        }
    }
    
    return FALSE;
}


- (NSString *)ptjGetPath:(NSString *)folderName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/",folderName]];
    return savedImagePath;
}

- (NSMutableArray *)ptjGetPathsInFolder:(NSString *)folderName {
    
    folderName = [NSString stringWithFormat:@"%@%@",kPrefix,folderName];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [cacheDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/",folderName]];
    
    NSError* error = nil;
    
    NSMutableArray* filePathsArray = [NSMutableArray arrayWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:savedImagePath error:&error]];
    
    if(error == nil) {
        NSMutableArray* filesAndProperties = [NSMutableArray arrayWithCapacity:[filePathsArray count]];
        
        for(NSString* imgName in filePathsArray) {
            NSString *imgPath = [NSString stringWithFormat:@"%@/%@",[_sharedPTJUtility ptjGetPath:folderName],imgName];
            NSDictionary* properties = [[NSFileManager defaultManager]
                                        attributesOfItemAtPath:imgPath
                                        error:&error];
            
            NSDate* modDate = [properties objectForKey:NSFileModificationDate];
            
            if(error == nil) {
                [filesAndProperties addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                               imgPath, @"path",
                                               modDate, @"lastModDate",
                                               nil]];
            }
            else {
                NSLog(@"%@",[error description]);
            }
        }
        
        NSArray* sortedFiles = [filesAndProperties sortedArrayUsingFunction:&lastModifiedSort context:nil];
        
        NSMutableArray *arrTempSort = [NSMutableArray array];
        
        NSLog(@"sortedFiles: %@", sortedFiles);
        
        for (NSDictionary *dictTemp in sortedFiles) {
            [arrTempSort addObject:[dictTemp valueForKey:@"path"]];
        }
        return arrTempSort;
    }
    else {
        NSLog(@"Encountered error while accessing contents of %@: %@", savedImagePath, error);
    }
    return filePathsArray;
}

NSInteger lastModifiedSort(id path1, id path2, void* context)
{
    int comp = [[path1 objectForKey:@"lastModDate"] compare:
                [path2 objectForKey:@"lastModDate"]];
    return comp;
}


- (void)uSaveFile:(NSData *)file fileName:(NSString *)fileName folderName:(NSString *)folderName {
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *tempPath = [docPaths objectAtIndex:0];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSFileManager *fileMGR = [NSFileManager defaultManager];
    
    
    BOOL isDir= TRUE;
    if (![fileMGR fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",folderName]] isDirectory:&isDir]) {
        [fileMGR createDirectoryAtPath:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",folderName]]  withIntermediateDirectories:FALSE attributes:nil error:nil];
    }
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@/%@",tempPath,folderName,fileName];
    
    [file writeToFile:filePath atomically:YES]; //Write the file
    
}


- (NSString *)ptjGetFilePathWithFileName:(NSString *)fileName folderName:(NSString *)folderName {
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *tempPath = [docPaths objectAtIndex:0];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSFileManager *fileMGR = [NSFileManager defaultManager];
    
    
    BOOL isDir= TRUE;
    if (![fileMGR fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",folderName]] isDirectory:&isDir]) {
        [fileMGR createDirectoryAtPath:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",folderName]]  withIntermediateDirectories:FALSE attributes:nil error:nil];
    }
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@/%@",tempPath,folderName,fileName];
    
    return filePath;
}

@end
