//
//  MyFunction.h
//  jobbookie
//
//  Created by Mrudul Shah on 14/04/15.
//  Copyright (c) 2015 Technostacks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constant.h"
#import "MBProgressHUD.h"

@protocol MyFunctionDelegate <NSObject>

@required

- (void)didReceiveResponseWithDictionary:(NSDictionary*)response AndURL:(NSString*)url;

@end

@interface MyFunction : NSObject<NSURLConnectionDataDelegate>
{
    id <MyFunctionDelegate> _delegate;
}
-(void)showAlertwithTitle:(NSString*)title andMessage:(NSString*)message;
-(BOOL) IsValidEmail:(NSString *)checkString;
-(void)requestWithURL:(NSString*)urlstr andParameters:(NSString*)parameters;
- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title;
- (void)dismissGlobalHUD;
@property (nonatomic, assign) id  <MyFunctionDelegate> delegate;

@end
