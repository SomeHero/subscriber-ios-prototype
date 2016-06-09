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

/*!
 @brief method to get the response of api
 @discussion This method is get the response of api.
 @param response - gives the response in dictionary format.
 @param url - gives the url for which we get the response.
 @return response
 */
- (void)didReceiveResponseWithDictionary:(NSDictionary*)response AndURL:(NSString*)url;

@end

@interface MyFunction : NSObject<NSURLConnectionDataDelegate>
{
    id <MyFunctionDelegate> _delegate;
}
/*!
 @brief show alert view
 @discussion shows alert view when this method is called.
 @param title - pass the string you want to show as title in alertview.
 @param message - pass the string you want to show as message in alertview.
 @return alertview will open.
 */
-(void)showAlertwithTitle:(NSString*)title andMessage:(NSString*)message;

/*!
 @brief To check whether string is valid email id.
 @param checkstring - enter emaild string.
 @return will check if the string is valid email id.
 */
-(BOOL) IsValidEmail:(NSString *)checkString;

/*!
 @brief method to call api
 @discussion This method is to call api by passing url of the a[i and parameters string.
 @param urlstr - pass the url of the api.
 @param parameters - pass the parameters for the api.
 @return api gets call.
 */
-(void)requestWithURL:(NSString*)urlstr andParameters:(NSString*)parameters;

/*!
 @brief To stop the progressview.
 @param title - enter progressview title string.
 */
- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title;

/*!
 @brief To stop the progressview.
 */
- (void)dismissGlobalHUD;

@property (nonatomic, assign) id  <MyFunctionDelegate> delegate;

@end
