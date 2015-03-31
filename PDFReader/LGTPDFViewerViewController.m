



#import "LGTPDFViewerViewController.h"
#import "LGTViewerBottomCell.h"
#import "LGTPDFViewerCollectionV_Cell.h"
#import "LGTUtility.h"
#import "PDFDownLoadClass.h"
#import "AppDelegate.h"
#import "UICollectionViewCell+LGTPDFViewerCollectionViewHelper.h"
#import "PreviewCollectionViewController.h"
@interface LGTPDFViewerViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, PDFDownLoadDelegate ,PreviewCollectionViewControllerDelegate>
{

    int index,previewIndex;
    //gesture
    UITapGestureRecognizer *singleTap,*doubleTap;
    
    
    //index For gesture
    int indexForGesture;
    
    //collection Frame
    CGRect  collectionFrame;
    float brush;
    
}

@property (retain, nonatomic) IBOutlet UIView *viewForHeaderNav;

//
@property (retain, nonatomic) IBOutlet UIView *viewForFooterCollectionV;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) NSMutableArray *arrStoreWholePDFImage;

@property (nonatomic, strong)UIColor *selectedColor;

//
@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;
@property (strong, nonatomic)UIImageView *imageV_ForShowingDocGloble;


//
@property (strong, nonatomic) IBOutlet  UIScrollView *scrollV_For_FullScreen;
@property (strong, nonatomic) IBOutlet  UIImageView *imageV_For_FullScreen;

///*******************Scroll View for Reading Image****************
@property (strong, nonatomic)UIScrollView *scrollViewForPDFImage;

@property(nonatomic,weak)IBOutlet UILabel *lblPageNumberHeader;

@property (weak, nonatomic) IBOutlet UICollectionView *collecV_ForPreview;
@end

@implementation LGTPDFViewerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    collectionFrame = self.collectionV.frame;
    [self initializeGestureRecognizerForZOOM];
    [self creaTheCollectionViewMain];
    [self creaTheCollectionViewPreview];
    [self pdfMethod];
    
    self.view.backgroundColor=[UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0];
    
    [self viewForHeaderNav];
    
    
    
    
}

- (void)viewSetup{


    [LGTUtility drawShadowForInfo:self.viewForHeaderNav];
    [LGTUtility drawShadowForInfo:self.viewForFooterCollectionV];

}

-(NSString*)getPDF{

    NSString *strPDFpath = [[NSBundle mainBundle]pathForResource:@"ProgrammingWithObjectiveC" ofType:@"pdf"];
    
    return strPDFpath;

}
-(void)pdfMethod{

    PDFDownLoadClass *pdf = [[PDFDownLoadClass alloc]init];
    pdf.delegate= self;
    [pdf converterPDF_to_JPEG_PDF_Name:[self getPDF]];

}

-(void)PDFDownLoadClass:(NSArray*)arrImage{

    NSLog(@"%@",arrImage);
    
    self.arrStoreWholePDFImage = [[NSMutableArray alloc]initWithArray:arrImage];
    [self.collectionV reloadData];
    [self.collecV_ForPreview reloadData];
    if(self.arrStoreWholePDFImage.count>1)
    //[self.collectionV selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
      self.indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
     [self.collecV_ForPreview selectItemAtIndexPath:self.indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    
}
-(void)PDFDownLoadClassErorr:(NSError *)error{

    NSLog(@"%@",error);
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark BACK Button
- (IBAction)actionBackButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}


#pragma mark- Collection View Delegate method and Method

-(void)creaTheCollectionViewMain{
    
    [UICollectionViewCell creaTheCollectionViewMainCollectionView:self.collectionV parentViewController:nil];
    
}
-(void)creaTheCollectionViewPreview {
    
    
    [UICollectionViewCell creaTheCollectionViewPreviewCollectionView:self.collecV_ForPreview parentViewController:nil CollectionViewScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
}

#pragma mark Collection View Delegate and Data source Method

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    // Add inset to the collection view if there are not enough cells to fill the width.
//    CGFloat cellSpacing = ((UICollectionViewFlowLayout *) collectionViewLayout).minimumLineSpacing;
//    CGFloat cellWidth = ((UICollectionViewFlowLayout *) collectionViewLayout).itemSize.width;
//    NSInteger cellCount = [collectionView numberOfItemsInSection:section];
//    CGFloat inset = (collectionView.bounds.size.width - (cellCount * (cellWidth + cellSpacing))) * 0.5;
//    inset = MAX(inset, 0.0);
//    return UIEdgeInsetsMake(0.0, inset, 0.0, 0.0);
//}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(collectionView==self.collectionV)
    {
       return CGSizeMake(self.collectionV.bounds.size.width-10,self.collectionV.bounds.size.height-10);
    }
    else if(collectionView==self.collecV_ForPreview){
        
       return CGSizeMake(30,30);
        
    }

    return CGSizeMake(0,0);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.arrStoreWholePDFImage.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(collectionView==self.collectionV)
    {
      static NSString *cellIdentifier = @"LGTPDFViewerCollectionV_Cell";
      LGTPDFViewerCollectionV_Cell *cell = (LGTPDFViewerCollectionV_Cell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
       [self pageNumberLableUpdate:indexPath];
        self.indexPath = indexPath;
        // set zoom disable
        [cell.scrollV_ForWholeBody setMinimumZoomScale:1.0];
        cell.scrollV_ForWholeBody.scrollEnabled = NO;
        [self.scrollViewForPDFImage setMinimumZoomScale:1.0];
        
       cell.tag=indexPath.row;
      [cell collectionCellViewCellImageView:self.imageV_For_FullScreen :self.arrStoreWholePDFImage indexPath:indexPath parentViewController:self];

   
    
    return cell;
    }
    else if(collectionView==self.collecV_ForPreview)
    {
    
        static NSString *cellIdentifier = @"LGTViewerBottomCell";
        LGTViewerBottomCell *cell = (LGTViewerBottomCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        
         [cell selectionCellColor:cell];
         [cell collectionCellViewCellImageView:nil :self.arrStoreWholePDFImage indexPath:indexPath parentViewController:self];
         return cell;

    
    }
    return nil;
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if(collectionView == self.collecV_ForPreview)
    {
        [self.collectionV scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        [self.collecV_ForPreview scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        [self pageNumberLableUpdate:indexPath];
       
    }
    
    
}


#pragma mark- ************************ScrollView Delegate Method ******************


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if(scrollView==self.collectionV)
    {
        for (UICollectionViewCell *cell in [self.collectionV visibleCells])
        {
            
            if([cell isKindOfClass:[LGTPDFViewerCollectionV_Cell class]])
            {
                if(index!=cell.tag)
                {
                    [self.scrollViewForPDFImage setZoomScale:1.0 animated:YES];
                   
                }
                
                //****************** For ScrollZom **************
                self.scrollViewForPDFImage = (UIScrollView*)[cell.contentView viewWithTag:100];
                self.scrollViewForPDFImage.delegate=self;
                [self.scrollViewForPDFImage setMinimumZoomScale:1.0];
                [self.scrollViewForPDFImage setMaximumZoomScale:4.0];
                 self.scrollViewForPDFImage.scrollEnabled=YES;
                
    
                for (UIView *tempView in  self.scrollViewForPDFImage.subviews) {
                    if ([tempView isKindOfClass:[UIImageView class]]) {
                        self.imageV_ForShowingDocGloble=(UIImageView*)tempView;
                        NSIndexPath *indexPath  = [self.collectionV indexPathForCell:cell];
                        self.indexPath = indexPath;
                        [self.collecV_ForPreview selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
                        [self pageNumberLableUpdate:indexPath];
                        return;
                    }
                   
                }
                
            }
        }
        
    }
    
}


-(void)pageNumberLableUpdate:(NSIndexPath*)indexPath{


    if(self.arrStoreWholePDFImage.count)
    {
        self.lblPageNumberHeader.hidden=NO;
        self.lblPageNumberHeader.text=[NSString stringWithFormat:@"%d / %d",indexPath.row+1,(int)self.arrStoreWholePDFImage.count];
    }
    else{
        
        self.lblPageNumberHeader.hidden=YES;
        
    }


}

#pragma mark ScrollView Delegate Method

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    //self.scrollViewForReadImageForGloble=scrollView;
    
    //*************** Scroll Enable YES ***********
    self.scrollViewForPDFImage.scrollEnabled=YES;
    
    //*************** Scroll Enable YES ***********
    
    //*************** Parents Scroll Enable YES ***********
    self.collectionV.scrollEnabled=YES;
    //*************** Parents Scroll Enable YES ***********
    
  
    if(self.scrollV_For_FullScreen == scrollView){
    
      return self.imageV_For_FullScreen;
    }
    else{
    
        return self.imageV_ForShowingDocGloble;
    
    }
    
    
}

#pragma mark- ************************* ZOOM GESTURE ****************************
//INITIALIZE THE GESTURE
-(void)initializeGestureRecognizerForZOOM{
    
    UITapGestureRecognizer *singleTaps = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionZoomGestureScreen:)];
    [singleTaps setNumberOfTapsRequired:2];
    self.scrollV_For_FullScreen.delegate=self;
    [self.scrollV_For_FullScreen setMinimumZoomScale:1.0];
    [self.scrollV_For_FullScreen setMaximumZoomScale:4.0];
    self.scrollV_For_FullScreen.scrollEnabled=YES;
    [self.scrollV_For_FullScreen addGestureRecognizer:singleTaps];
    
    collectionFrame=self.collectionV.frame;
    doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionZoomGestureScreen:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.collectionV addGestureRecognizer:doubleTap];
    
    singleTaps = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionSingle:)];
    [singleTaps setNumberOfTapsRequired:1];
    [self.collectionV addGestureRecognizer:singleTaps];
    
    
}
-(void)actionSingle:(UIGestureRecognizer*)gesture{

    if(gesture.view.tag == 0){
        gesture.view.tag = 1;
        self.viewForFooterCollectionV.hidden = YES;
        self.viewForHeaderNav.hidden = YES;
    }
    else{
    
        gesture.view.tag = 0;
        self.viewForFooterCollectionV.hidden = NO;
        self.viewForHeaderNav.hidden = NO;
    }

}

#pragma mark TapGesture Zoom
-(void)actionZoomGestureScreen:(UIGestureRecognizer*)gesture{
    
   
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
   
    
    // set zoom disable
     [self.scrollV_For_FullScreen setMinimumZoomScale:1.0];
    [self.scrollViewForPDFImage setMinimumZoomScale:1.0];
    
    
    if(indexForGesture==0)
    {
       
        
        [[UIApplication sharedApplication]setStatusBarHidden:![[UIApplication sharedApplication]isStatusBarHidden] withAnimation:UIStatusBarAnimationFade];
        [UIView animateWithDuration:0.25 animations:^
         {
             
         } completion:^(BOOL finished)
         {
             self.scrollV_For_FullScreen.frame = appDelegate.window.bounds;
    
             if(self.imageV_ForShowingDocGloble.image){
             
                 self.imageV_For_FullScreen.image = self.imageV_ForShowingDocGloble.image;
             }
             [appDelegate.window addSubview:self.scrollV_For_FullScreen];
             
         }];
        
        
        indexForGesture=1;
    }
    else{
        
        [[UIApplication sharedApplication]setStatusBarHidden:![[UIApplication sharedApplication]isStatusBarHidden] withAnimation:UIStatusBarAnimationFade];
        
        [UIView animateWithDuration:0.25 animations:^
         {
            
         } completion:^(BOOL finished)
         {
             //[[UIApplication sharedApplication] isStatusBarHidden:YES];// = YES;
             self.imageV_For_FullScreen.image = nil;
            [self.scrollV_For_FullScreen removeFromSuperview];
         }];
        indexForGesture=0;
    }
    
    
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{

    
    

}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{

    NSLog(@"working");

}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{

    
    if(indexForGesture == 0){

       collectionFrame = self.collectionV.frame;
    }
    
    if(self.arrStoreWholePDFImage.count < self.indexPath.row)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(5,5, 5,5);
        
         [self collectionView:self.collectionV layout:flowLayout sizeForItemAtIndexPath:self.indexPath];
        
        //[self.collectionV performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        //[self.collectionV scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }

    [self.collectionV reloadData];
    //[self.collectionV scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}
- (IBAction)actionBtnPreview:(id)sender {
    
    PreviewCollectionViewController *preview = [[PreviewCollectionViewController alloc]init];
    preview.arrPDFImageRecord = self.arrStoreWholePDFImage;
    preview.delegate = self;
    preview.indexPathSelected = self.indexPath;
    [self presentViewController:preview animated:NO completion:NULL];
    
    
}

#pragma mark PreviewCollectionViewController Delegate Method

-(void)previewCollectionViewControllerSelectedIndexNumber:(NSIndexPath*)indexPath{

    
    [self.collecV_ForPreview selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    [self.collectionV scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    [self.collecV_ForPreview scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    [self pageNumberLableUpdate:indexPath];


}

- (void)dealloc {
    
    _viewForFooterCollectionV = nil;
    _viewForHeaderNav = nil;
    
}
@end
