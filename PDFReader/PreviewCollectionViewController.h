//
//  PreviewCollectionViewController.h
//  PDFReader
//
//  Created by Jairam Babu on 12/03/15.
//  Copyright (c) 2015 Jairam Babu. All rights reserved.
//
#import <Foundation/Foundation.h>
@protocol PreviewCollectionViewControllerDelegate <NSObject>

-(void)previewCollectionViewControllerSelectedIndexNumber:(NSIndexPath*)indexPath;

@end

#import <UIKit/UIKit.h>

@interface PreviewCollectionViewController : UIViewController
@property id delegate;
@property (nonatomic,  strong) NSArray *arrPDFImageRecord;
@property (nonatomic,  strong) NSIndexPath *indexPathSelected;
@end
