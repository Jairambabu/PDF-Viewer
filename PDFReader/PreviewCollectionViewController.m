//
//  PreviewCollectionViewController.m
//  PDFReader
//
//  Created by Jairam Babu on 12/03/15.
//  Copyright (c) 2015 Jairam Babu. All rights reserved.
//

#import "PreviewCollectionViewController.h"
#import "LGTViewerBottomCell.h"
#import "UICollectionViewCell+LGTPDFViewerCollectionViewHelper.h"
@interface PreviewCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@end

@implementation PreviewCollectionViewController

static NSString * const reuseIdentifier = @"LGTViewerBottomCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    
    [self creaTheCollectionViewPreview];
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creaTheCollectionViewPreview {
    
    
    [UICollectionViewCell creaTheCollectionViewPreviewCollectionView:self.collectionView parentViewController:nil CollectionViewScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    [self.collectionView selectItemAtIndexPath:self.indexPathSelected animated:NO scrollPosition:UICollectionViewScrollPositionCenteredVertically];
    [self.collectionView scrollToItemAtIndexPath:self.indexPathSelected atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    
}


#pragma mark <UICollectionViewDataSource>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
        
        return CGSizeMake(150,150);
        
    
}
- (IBAction)actionDoneButton:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:NULL];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.arrPDFImageRecord.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"LGTViewerBottomCell";
    LGTViewerBottomCell *cell = (LGTViewerBottomCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell selectionCellColor:cell];
    [cell collectionCellViewCellImageView:nil :(NSMutableArray*)self.arrPDFImageRecord indexPath:indexPath parentViewController:self];
    //[cell collectionCellViewCellImageView:nil :(NSMutableArray*)self.arrPDFImageRecord indexPath:indexPath parentViewController:self];
    return cell;

}
#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    [self dismissViewControllerAnimated:NO completion:^{
    
        [self.delegate previewCollectionViewControllerSelectedIndexNumber:indexPath];
    
    
    }];

}





@end
