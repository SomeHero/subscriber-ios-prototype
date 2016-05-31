//
//  AppDelegate.h
//  Subscriber
//
//  Created by TechnoMac-2 on 5/16/16.
//  Copyright © 2016 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFunction.h"
#import <GLKit/GLKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,MyFunctionDelegate>
{
    MyFunction *myfun;
    int sendid;
    int stopid;
    float value;
}

@property (strong, nonatomic) UIWindow *window;

/*! To get the screenshot of video we take screenshot of current frame drawn on glkview*/
@property (strong, nonatomic) GLKView *_screenshotview;

/*!screenshotstatus is yes when screenshot button is pressed.if screenshotstatus is yes then it will save the current glkview to _screenshotview and will take the screenshot of it and change the screenshot status to no.so that during the process glkview does not get updated.*/
@property (nonatomic,assign) BOOL screenshotstatus;
@end

