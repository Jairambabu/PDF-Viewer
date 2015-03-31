//
//  LGTPDFViewerCollectionViewHelper.h
//  PDFReader
//
//  Created by Jairam Babu on 12/03/15.
//  Copyright (c) 2015 Jairam Babu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface LGTPDFViewerCollectionViewHelper : NSObject
+ (void)creaTheCollectionViewMainCollectionView:(UICollectionView*)collectionV parentViewController:(UIViewController*)viewController;
+ (void)creaTheCollectionViewPreviewCollectionView:(UICollectionView*)collectionV parentViewController:(UIViewController*)viewController CollectionViewScrollDirection:(UICollectionViewScrollDirection)collectionViewScrollDirection;
+(void)collectionCellViewCell:(UICollectionViewCell*)cell imageView:(UIImageView*)imageV_For_FullScreen :(NSMutableArray*)arrStoreWholePDFImage indexPath:(NSIndexPath*)indexPath parentViewController:(UIViewController*)viewController;
+ (void)selectionCellColor:(UICollectionViewCell*)cell;
@end
