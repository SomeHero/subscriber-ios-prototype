//
//  AllMediaVC.h
//  Solve Now
//
//  Created by TechnoMac-4 on 28/10/15.
//  Copyright © 2015 Technostacks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
@interface AllMediaVC : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    /*! list of media */
    NSArray *mediaList;//
    /*! filepath */
    NSString *filepath;//
    /*! cell frame */
    CGRect cellRect;//
    /*! Back Button */
    UIButton *btnBack;
    
    __weak IBOutlet UINavigationBar *objNavBar;
    
    UINavigationItem *Navitem;
}
/*! for full screen display */
@property (weak, nonatomic) IBOutlet UICollectionView *mediaCollectionView2;//
/*! for thumbnail view */
@property (weak, nonatomic) IBOutlet UICollectionView *mediaCollectionView;
/*! view for showing image */
@property (weak, nonatomic) IBOutlet UIView *viewImage;
/*! Thread id  */
@property (strong,nonatomic) NSString *threadID;

@end
