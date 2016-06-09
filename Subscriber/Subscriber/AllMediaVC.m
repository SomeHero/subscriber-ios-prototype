//
//  AllMediaVC.m
//  Solve Now
//
//  Created by TechnoMac-4 on 28/10/15.
//  Copyright © 2015 Technostacks. All rights reserved.
//

#import "AllMediaVC.h"

@interface AllMediaVC ()

@end

@implementation AllMediaVC

@synthesize mediaCollectionView,mediaCollectionView2;
@synthesize viewImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IPAD) {
        Navitem = [[UINavigationItem alloc]init];
        objNavBar.items = [NSArray arrayWithObject:Navitem];
    }
    if (self)
    {
        self.title = NSLocalizedString(@"Gallery",@"");
        Navitem.title = self.title;
    }
    
   // [self backButtonwithVC:self];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(usertap)];
    [self.mediaCollectionView2 addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    //fetching the images from directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [NSString stringWithFormat:@"%@",[paths firstObject]];
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    filepath = path;
    mediaList = directoryContent;
    [mediaCollectionView reloadData];
    [mediaCollectionView2 reloadData];
}


#pragma mark - User Methods -

-(void)usertap
{
    if (IPAD)
    {
        if (objNavBar.alpha == 0.0)//is navigation bar visible
        {
            [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.navigationController.navigationBar.alpha = 1.0;
            } completion:^(BOOL finished)
             {
                 
             }];
            
        }
        else
        {
            [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.navigationController.navigationBar.alpha = 0.0;
            } completion:^(BOOL finished)
             {
                 
             }];
        }
        
    }
    else
    {
        if (self.navigationController.navigationBar.alpha == 0.0)//is navigation bar visible
        {
            [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.navigationController.navigationBar.alpha = 1.0;
            } completion:^(BOOL finished)
             {
                 
             }];
            
        }
        else
        {
            [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.navigationController.navigationBar.alpha = 0.0;
            } completion:^(BOOL finished)
             {
                 
             }];
        }
    }
}

- (IBAction)backClicked:(UIButton *)sender
{
   
    self.navigationItem.leftBarButtonItem = nil;
    NSIndexPath *index = [NSIndexPath indexPathForRow:btnBack.tag inSection:0];
    UICollectionViewCell *cell = [mediaCollectionView cellForItemAtIndexPath:index];
    cell.layer.masksToBounds = NO;
    UICollectionViewLayoutAttributes *attributes = [mediaCollectionView layoutAttributesForItemAtIndexPath:index];
    cellRect = attributes.frame;
    UIImageView *img = (UIImageView*) [cell viewWithTag:100];
    [mediaCollectionView bringSubviewToFront:cell];
    img.frame = self.view.bounds;
    cell.frame = self.view.frame;
    viewImage.hidden = TRUE;
    
    int x = isiPhone?isiPhone4?8:isiPhone5?8:isiPhone6?10:12:15;
    x = x*5;
    int w = (self.view.frame.size.width-x)/4;
    
    [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        cell.frame=cellRect;
        img.frame = CGRectMake(0, 0, w, w);
        img.contentMode = UIViewContentModeScaleAspectFill;
    } completion:^(BOOL finished)
     {
         cell.layer.masksToBounds = YES;
     }];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return mediaList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (collectionView==mediaCollectionView)
    {
        int x = isiPhone?isiPhone4?8:isiPhone5?8:isiPhone6?10:12:15;
        return UIEdgeInsetsMake(x, x, x, x);
    }
    else
    {
        return UIEdgeInsetsMake(0,0,0,0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Adjust cell size for orientation
    if (collectionView==mediaCollectionView)
    {
        int x = isiPhone?isiPhone4?8:isiPhone5?8:isiPhone6?10:12:15;
        
        x = x*5;
        
        int w = (self.view.frame.size.width-x)/4;
        
        return CGSizeMake(w,w);
    }
    else
    {
        return mediaCollectionView2.frame.size;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==mediaCollectionView)
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mediaCell" forIndexPath:indexPath];
        
        NSString *imgPath = [NSString stringWithFormat:@"%@/%@",filepath,[mediaList objectAtIndex:indexPath.row]];
        
        UIImageView *img = (UIImageView*)[cell viewWithTag:100];
        
        img.image = [UIImage imageWithContentsOfFile:imgPath];
        
        return cell;
    }
    else
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mediaCell2" forIndexPath:indexPath];
        
        NSString *imgPath = [NSString stringWithFormat:@"%@/%@",filepath,[mediaList objectAtIndex:indexPath.row]];
        
        UIImageView *img = (UIImageView*)[cell viewWithTag:100];
        
        img.image = [UIImage imageWithContentsOfFile:imgPath];
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == mediaCollectionView)
    {
        [mediaCollectionView2 scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        UICollectionViewLayoutAttributes *attributes = [mediaCollectionView layoutAttributesForItemAtIndexPath:indexPath];
        cellRect = attributes.frame;
        cellRect.origin = CGPointMake(cellRect.origin.x, cellRect.origin.y - mediaCollectionView.contentOffset.y);
        viewImage.frame = attributes.frame;
        viewImage.hidden = FALSE;
        [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            viewImage.frame = self.view.frame;
        } completion:^(BOOL finished)
         {
             btnBack = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 36)];
             btnBack.tag = indexPath.row;
             
             //[btnBack setImage:[[UIImage imageNamed:@"back"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
            // [btnBack.imageView setTintColor:[UIColor whiteColor]];
             
             [btnBack setTitle:@"<" forState:UIControlStateNormal];
             [btnBack addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
             [btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             UIBarButtonItem *bar= [[UIBarButtonItem alloc] initWithCustomView:btnBack];
             self.navigationItem.leftBarButtonItem = bar;
         }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==mediaCollectionView2)
    {
        NSArray *temp = [mediaCollectionView2 visibleCells];
        UICollectionViewCell *cell = [temp firstObject];
        NSIndexPath *index = [mediaCollectionView2 indexPathForCell:cell];
        btnBack.tag = index.row;
    }
}

@end
