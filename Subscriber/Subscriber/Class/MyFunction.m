//
//  MyFunction.m
//  jobbookie
//
//  Created by Mrudul Shah on 14/04/15.
//  Copyright (c) 2015 Technostacks. All rights reserved.
//

#import "MyFunction.h"

@implementation MyFunction
@synthesize delegate;
-(void)showAlertwithTitle:(NSString*)title andMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(BOOL) IsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void)requestWithURL:(NSString*)urlstr andParameters:(NSString*)parameters
{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:hostURL,urlstr]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSData *data = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    [request addValue:[NSString stringWithFormat:@"%lu",(unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:data];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if (connectionError)
         {
                 [self showAlertwithTitle:appName andMessage:[NSString stringWithFormat:@"Error in Connection:%@",connectionError.localizedDescription]];
            
             [self dismissGlobalHUD];
         }
         else
         {
             if (data!=nil)
             {
                 NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",dict);
                 if (dict!=nil)
                 {

                     if (delegate!=nil)
                     {
                         [delegate didReceiveResponseWithDictionary:dict AndURL:urlstr];
                     }
                 }
                 else
                 {
                     [self showAlertwithTitle:appName andMessage:@"Invalid JSON response"];
                     [self dismissGlobalHUD];
                 }
             }
         }
     }];
}

- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.labelText = title;
    return hud;
}

- (void)dismissGlobalHUD
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD hideHUDForView:window animated:YES];
}

@end
