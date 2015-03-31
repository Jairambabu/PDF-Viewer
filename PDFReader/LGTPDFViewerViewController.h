//
//  DSPersonalNotesViewController.h
//  DocuStrator
//
//  Created by connexmac2 on 9/17/14.
//  Copyright (c) 2014 ConnexInfoSystem. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LGTPDFViewerViewControllerDelegate <NSObject>

-(void)dSPersonalNotesViewController:(NSArray*)arrPersonalNotes;

@end

#import <UIKit/UIKit.h>

@interface LGTPDFViewerViewController : UIViewController
@property(nonatomic, weak)id<LGTPDFViewerViewControllerDelegate>delegate;

@end
