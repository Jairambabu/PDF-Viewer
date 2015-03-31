//
//  LGTPDFViewerViewController.h
//  PDFReader
//
//  Created by Jairam bau on 9/17/14.
//  Copyright (c) 2014 jairam babu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LGTPDFViewerViewControllerDelegate <NSObject>

-(void)dSPersonalNotesViewController:(NSArray*)arrPersonalNotes;

@end

#import <UIKit/UIKit.h>

@interface LGTPDFViewerViewController : UIViewController
@property(nonatomic, weak)id<LGTPDFViewerViewControllerDelegate>delegate;

@end
