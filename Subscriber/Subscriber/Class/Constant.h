//
//  Constant.h
//  food delivery
//
//  Created by TechnoMac-2 on 12/15/15.
//  Copyright © 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#endif /* Constant_h */

#define hostURL @"http://livestream.technostacks.com/%@"

//#define hostURL @"http://192.168.0.135/live_stream/%@"

#define devicename [[UIDevice currentDevice]name]

#define devicetoken [[NSUserDefaults standardUserDefaults]valueForKey:@"Devicetoken"]

#define appName @"Subscriber"

#define isiPhone [UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPhone

#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#define isiPhone4 [[UIScreen mainScreen] bounds].size.height == 480

#define isiPhone5 [[UIScreen mainScreen] bounds].size.height == 568

#define isiPhone6 [[UIScreen mainScreen] bounds].size.height == 667

#define isiPhone6P [[UIScreen mainScreen] bounds].size.height == 736