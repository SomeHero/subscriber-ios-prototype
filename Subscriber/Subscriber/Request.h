//
//  Request.h
//  Subscriber
//
//  Created by TechnoMac-2 on 5/27/16.
//  Copyright © 2016 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFunction.h"
#import "Constant.h"
@interface Request : UIViewController<MyFunctionDelegate>{
    
    MyFunction *myfun;
   
}

/*! Request button to sent request to publisher. */

@property (nonatomic,retain)IBOutlet UIButton *btnrequest;

/*! when request button is pressed at that time request is sent to all publisher to publish the video by calling its api. */
-(IBAction)req:(id)sender;

/*! navigate to subscriber class.*/
-(void)navigatetoSubscriber;

/*!
 when logout button is pressed logout api is called which will remove device from the device list.*/
-(void)logout;
@end
