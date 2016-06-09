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

@end

