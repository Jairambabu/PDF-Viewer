//
//  UICollectionViewCell+LGTPDFViewerCollectionViewHelper.h
//  PDFReader
//
//  Created by jairam Babu on 16/03/15.
//  Copyright (c) 2015 Jairam Babu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (LGTPDFViewerCollectionViewHelper)
+ (void)creaTheCollectionViewMainCollectionView:(UICollectionView*)collectionV parentViewController:(UIViewController*)viewController;
+ (void)creaTheCollectionViewPreviewCollectionView:(UICollectionView*)collectionV parentViewController:(UIViewController*)viewController CollectionViewScrollDirection:(UICollectionViewScrollDirection)collectionViewScrollDirection;
-(void)collectionCellViewCellImageView:(UIImageView*)imageV_For_FullScreen :(NSMutableArray*)arrStoreWholePDFImage indexPath:(NSIndexPath*)indexPath parentViewController:(UIViewController*)viewController;
- (void)selectionCellColor:(UICollectionViewCell*)cell;
@end
