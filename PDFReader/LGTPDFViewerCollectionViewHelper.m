//
//  LGTPDFViewerCollectionViewHelper.m
//  PDFReader
//
//  Created by Jairam Babu on 12/03/15.
//  Copyright (c) 2015 Jairam Babu. All rights reserved.
//

#import "LGTPDFViewerCollectionViewHelper.h"
#import "LGTPDFViewerViewController.h"
#import <UIKit/UIKit.h>
#import "LGTPDFViewerCollectionV_Cell.h"
#import "LGTViewerBottomCell.h"
#import "LGTUtility.h"
@implementation LGTPDFViewerCollectionViewHelper
+ (void)creaTheCollectionViewMainCollectionView:(UICollectionView*)collectionV parentViewController:(UIViewController*)viewController{
    
   
    [collectionV registerClass:[LGTPDFViewerCollectionV_Cell class] forCellWithReuseIdentifier:@"LGTPDFViewerCollectionV_Cell"];
    collectionV.backgroundColor=[UIColor lightGrayColor];
    [self commanclasCollectionView:collectionV :UICollectionViewScrollDirectionHorizontal];
    
}
+ (void)creaTheCollectionViewPreviewCollectionView:(UICollectionView*)collectionV parentViewController:(UIViewController*)viewController CollectionViewScrollDirection:(UICollectionViewScrollDirection)collectionViewScrollDirection{
    
   
    [collectionV registerClass:[LGTViewerBottomCell class] forCellWithReuseIdentifier:@"LGTViewerBottomCell"];
    collectionV.backgroundColor=[UIColor lightGrayColor];
    [self commanclasCollectionView:collectionV :collectionViewScrollDirection];
    
}


+(void)commanclasCollectionView:(UICollectionView *)collectionV :(UICollectionViewScrollDirection)collectionViewScrollDirection{

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(5,5, 5,5);
    [flowLayout setScrollDirection:collectionViewScrollDirection];
    [collectionV setCollectionViewLayout:flowLayout];

}

+(void)collectionCellViewCell:(UICollectionViewCell*)cell imageView:(UIImageView*)imageV_For_FullScreen :(NSMutableArray*)arrStoreWholePDFImage indexPath:(NSIndexPath*)indexPath parentViewController:(UIViewController*)viewController{

    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.frame = CGRectMake(56,74,32,32);
    [cell addSubview:indicator];
    [indicator bringSubviewToFront:viewController.view];
    [indicator startAnimating];
    

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0ul);
    dispatch_async(queue, ^{
        NSString *strOriginalImage=nil;
        if(arrStoreWholePDFImage.count>indexPath.row)
        {
            
            strOriginalImage =[arrStoreWholePDFImage objectAtIndex:indexPath.row];
            
        }
        UIImage *imageOriginal=nil;
        
        if([[NSFileManager defaultManager]fileExistsAtPath:strOriginalImage])
        {
            imageOriginal=[UIImage imageWithContentsOfFile:strOriginalImage];;//[NSData dataWithContentsOfFile:strOriginalImage]];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            if(imageOriginal)
            {
                
                if([cell isKindOfClass:[LGTPDFViewerCollectionV_Cell class]])
                {
                    LGTPDFViewerCollectionV_Cell *cellLColCell = (LGTPDFViewerCollectionV_Cell*)cell;
                    cellLColCell.imageV_For_Background.image=imageOriginal;
                    imageV_For_FullScreen.image = imageOriginal;
                }
                else  if([cell isKindOfClass:[LGTViewerBottomCell class]]){
                
                    LGTViewerBottomCell *cellLColCell = (LGTViewerBottomCell*)cell;
                    cellLColCell.imageVBackGound.image=imageOriginal;
                    cellLColCell.lblPageNumber.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
                }
            }
            
            [indicator stopAnimating];
            
        });
        
        
    });


}

+ (void)selectionCellColor:(UICollectionViewCell*)cell{
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor redColor]];
   // [LGTUtility viewShadow:bgColorView :bgColorView.backgroundColor];
    [cell setSelectedBackgroundView:bgColorView];
    
    
    
}

@end
