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
#import "XMLDictionary.h"
@interface ViewController ()<UIWebViewDelegate>
@property (retain, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.webview.delegate=self;
    [self.webview setOpaque:NO];
    self.webview.backgroundColor=[UIColor clearColor];
    //    NSURL *urlVal = [NSURL URLWithString:url];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:urlVal];
    //    [webView loadRequest:request];
    //[parentView addSubview:webView];
  ///  NSLog(@"%@",[self data]);
    [self.webview loadHTMLString:[self data] baseURL:nil];
    
    
    
    
    NSString *strFrame =[NSString stringWithFormat:@"<iframe width=\"%f\" height=\"315\" src=\"https://www.youtube.com/embed/w9i0PRLVLwY\" frameborder=\"0\" allowfullscreen></iframe>",[UIScreen mainScreen].bounds.size.width - 15];
    NSString *strWholedata = [self data];
    
    NSString *strAppendData = [strWholedata stringByReplacingOccurrencesOfString:@"iframe" withString:strFrame];
    
    [self.webview loadHTMLString:strAppendData baseURL:nil];
    
   //NSLog(@"%@",strAppendData);
    
}

    //   frame.size.height=webView.scrollView.contentSize.height;
   // self.webview.frame=frame;
    
/*
    NSRange range = [[self data] rangeOfString:@"iframe width="];
    if (range.location == NSNotFound) {
        NSLog(@"string was not found");
    } else {
        NSLog(@"position %lu", (unsigned long)range.location);
    }
    int  count = 13;
    NSString *substring = [[self data] substringToIndex:range.location + count + 4];
   
  
*/


    - (void)webViewDidFinishLoad:(UIWebView *)webView
    {
       // if (!self.didFirstLoad) {
            // Disable the default contextual menu.
            //[webView stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitTouchCallout='none';"];
        //}
    }
    
    // Called by the gesture recognizer.
    - (IBAction)longPressDetected:(UILongPressGestureRecognizer *)sender
    {
        if (sender.state == UIGestureRecognizerStateBegan) {
            
            NSLog(@"Long press detected.");
            
            CGPoint webViewCoordinates = [sender locationInView:self.webview];
            NSLog(@"WebView coordinates are: %@", NSStringFromCGPoint(webViewCoordinates));
            
            // Find the DOM element
            NSString *locatorString = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).innerHTML", webViewCoordinates.x, webViewCoordinates.y];
            NSString *result = [self.webview stringByEvaluatingJavaScriptFromString: locatorString];
            NSLog(@"Element Found: %@", result);
            
        }
        
    }
    
    // Necessary or the gesture recognizer won't call the IBAction.
    - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
    {
        return YES;
    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionPDFViewer:(id)sender {
    
     LGTPDFViewerViewController *personal = [[LGTPDFViewerViewController alloc]initWithNibName:[LGTUtility uNibName:@"LGTPDFViewerViewController"] bundle:nil];
     [self presentViewController:personal animated:NO completion:NULL];
    
}

-(NSString*)data{

    
    NSString *strData = @"<span style=\"font-family: HelveticaNeue; font-size: 14; color: #353840 \"><head><style type='text/css'>body{font-size: 14px; font-weight: normal; line-height: 18px; color: #353840; word-wrap: break-word; font-family: arial;}h1{font-size: 18px; font-weight:normal; color:#1e3f5a; margin:0 0 10px; padding:0; word-wrap:break-word; font-family:arial;}h2{font-size:16px; color:#353840; margin:0 0 10px; padding:0; word-wrap:break-word; font-family:arial;}h3{font-size:14px; color:#353840; margin:0 0 10px; padding:0; word-wrap:break-word; font-family:arial;}h4{font-size:14px; color:#353840; margin:0 0 10px; padding:0; word-wrap:break-word; font-family:arial;}h5{font-size:14px; color:#353840; margin:0 0 10px; padding:0; word-wrap:break-word; font-family:arial;}h6{font-size:12px; color:#353840; margin:0 0 10px; padding:0; word-wrap:break-word; font-family:arial;}p{font-size:14px; line-height:18px; color:#353840; margin:0 0 10px; padding:0; word-wrap:break-word; font-family:arial;}img{max-width:100%; width:100% !important; height:inherit !important;}ul{ margin:0 0 10px; padding:0;}ol{ margin:0 0 10px 15px; padding:0;}ul li{ margin:0 0 10px; padding:0; list-style-type:disc; list-style-position:inside; font-family:arial; font-size:14px;}ol li{ margin:0 0 10px; padding:0; font-family:arial; font-size:14px;}a{color:#1e3f5a; font-family:arial;}a:hover{text-decoration:underline;}ul.ollist{margin:0 0 10px 15px; padding:0;}ul.ollist li{list-style-type: decimal; margin:0 0 10px; padding:0; font-family:arial; font-size:14px;}</style></head><body><p>On 9 September, Twitter exploded with the hashtag #AppleLive as Apple CEO Tim Cook revealed the new iPhone 6, iPhone 6 Plus, the Apple Watch and new services like Apple Pay.</p><p>These live events and the reaction they receive from users of Twitter and other social media are all part of Apple’s business strategy. The huge amount of free press the company gets from its announcements helps to generate major spikes in demand as products launch. But the model only works if the products remain innovative and the supply chain is able to respond.</p><p>According to the supply chain community, Apple does extremely well on innovation. SCM World is currently running a quick poll on Apple vs Amazon iframe1 (you can <u><a href=\"http://www.cvent.com/Surveys/Welcome.aspx?s=245e31ea-1e97-4dbc-aa65-9c488fa59c8b\" target=\"_blank\"><strong>vote here</strong></a></u>), which asks participants to rate the two companies on agility, collaboration, innovation and execution. When it comes to innovation, Apple wins hands down.</p><p style=\"text-align: center;\"> <img src=\"http://qa2.scmworld.com/uploadedImages/Member_Content/Blog/The_Secret_Source/1MDFig17092014(3).jpg\" alt=\"blog17092014-1\" title=\"blog17092014-1\" /></p><p>Apple product launches show why its supply chain is admired. The ability to use product innovation to create demand and back it up with supply continuity requires integration across each of the business functions responsible for demand, supply and product strategy. </p><p>As one executive commented in our poll: “I admire Apple to be able to be very secretive with new product launches and then quickly supply millions of new products worldwide. This is a real challenge… because of the risks involved with stressing the supply chain with new products.”</p><h2>The value of integrating product and supply chain strategy</h2><p>SCM World’s 2014 Chief Supply Chain Officer study shows that just one-third of executives believe supply chain, product design and engineering, and R&amp;D are fully integrated. Another third say that these functions are semi-integrated, while the remaining third say they are either linked or operate as pure silos. Completely integrated organisations seem to value revenue and agility more highly than their counterparts.</p><p>As the chart below shows, as integration of product and supply chain organisations becomes stronger, the value placed on increasing revenue, agility and speed increases. The data highlights the fact that as supply chain becomes integrated with other business functions, the leadership in supply chain better appreciates its role in delivering business value.</p><p style=\"text-align: center;\"> <img src=\"http://qa2.scmworld.com/uploadedImages/Member_Content/Blog/The_Secret_Source/2MDFig17092014(1).jpg\" alt=\"blog17092014-2\" title=\"blog17092014-2\" /></p><p>Apple is frequently called a marketing engine or just a product design company. As one poll respondent stated: “I don't see Apple as a supply chain company, but rather as a marketing company. I don't see anything that other companies can emulate in their own supply chain journeys.”</p><p>The quality of Apple’s supply chain is often a hot topic, but perhaps there is at least one area to emulate. Supply chain organisations are constantly looking for ways to collaborate further with business partners. As the data above shows, changing the message from one of cost to one of revenue, speed and agility is a likely hook into product design and R&amp;D.</p><h2>Is Apple really more innovative than Amazon?  </h2><p>With the product announcements done, it is supply chain’s turn to step up for Apple. In our provisional poll data, Apple is lagging Amazon for the remaining attributes of collaboration, agility and execution. This is likely a result, at least in part, of the long lines of consumers waiting each day to buy Apple products as a visual sign of mismatched demand and supply.</p><p>Innovation at Amazon largely comes from its business model’s ability to shrink the direct delivery window. It has, however, made some forays into product innovation with the Kindle, Kindle Fire, Amazon Dash and, most recently, the Amazon Fire phone. </p><p>Each of these devices is intended to either monetise content distribution or capture greater control of the point of sale. These devices themselves have yet to prove a point of innovation and are typically selling at cost as a result. (See the <a href=\"http://www.scmworld.com/Columns/Beyond-Supply-Chain/Amazon-and-the-limits-of-ambition/\"><strong>recent blog post</strong></a> by SCM World’s Kevin O’Marah for more on this.)</p><p>So is Apple’s supply chain ready? Is Apple truly more innovative than Amazon? Weigh in with your opinion in our <strong><u><a href=\"http://www.cvent.com/Surveys/Welcome.aspx?s=245e31ea-1e97-4dbc-aa65-9c488fa59c8b\" target=\"_blank\">online poll</a></u></strong> now.</p></body></span>iframe <iframe width=\"300\" height=\"315\" src=\"https://www.youtube.com/embed/w9i0PRLVLwY\" frameborder=\"0\" allowfullscreen></iframe>";
    

    return strData;

}

//#pragma mark- WebView Delegate Method
//
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    
//    return YES;
//}
//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    
//    [SVProgressHUD showWithStatus:@"Please wait..."];
//    NSLog(@"start");
//}
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [SVProgressHUD dismiss];
//    NSLog(@"stop");
//}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    
//    NSLog(@"fail");
//    [SVProgressHUD dismiss];
//    
//}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    
  
    NSString *strFrame = nil;
//    if([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height){
//       NSLog(@"landscape mode %f",[UIScreen mainScreen].bounds.size.height);
//      strFrame =[NSString stringWithFormat:@"<iframe width=\"%f\" height=\"315\" src=\"https://www.youtube.com/embed/w9i0PRLVLwY\" frameborder=\"0\" allowfullscreen></iframe>",[UIScreen mainScreen].bounds.size.height - 15];
//        
//    }else{
//        NSLog(@"portrait mode %f",[UIScreen mainScreen].bounds.size.height);
//        strFrame =[NSString stringWithFormat:@"<iframe width=\"%f\" height=\"315\" src=\"https://www.youtube.com/embed/w9i0PRLVLwY\" frameborder=\"0\" allowfullscreen></iframe>",[UIScreen mainScreen].bounds.size.height - 15];
//    
//    }
    
    strFrame =[NSString stringWithFormat:@"<iframe width=\"%f\" height=\"315\" src=\"https://www.youtube.com/embed/w9i0PRLVLwY\" frameborder=\"0\" allowfullscreen></iframe>",[UIScreen mainScreen].bounds.size.height - 15];
    NSString *strWholedata = [self data];
    
    NSString *strAppendData = [strWholedata stringByAppendingString:strFrame];
    
    [self.webview loadHTMLString:strAppendData baseURL:nil];
    
}


@end
