//
//  ViewController.m
//  PDFReader
//
//  Created by Jairam Babu on 11/03/15.
//  Copyright (c) 2015 Jairam Babu. All rights reserved.
//

#import "ViewController.h"
#import "LGTPDFViewerViewController.h"
#import "LGTUtility.h"
#import "SVProgressHUD.h"
#import "PreviewCollectionViewController.h"
@interface ViewController ()<UIWebViewDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionPDFViewer:(id)sender {
    
    LGTPDFViewerViewController *personal = [[LGTPDFViewerViewController alloc]initWithNibName:[LGTUtility uNibName:@"LGTPDFViewerViewController"] bundle:nil];
    [self presentViewController:personal animated:NO completion:NULL];
    
}





@end
