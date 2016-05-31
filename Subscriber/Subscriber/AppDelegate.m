//
//  AppDelegate.m
//  Subscriber
//
//  Created by TechnoMac-2 on 5/16/16.
//  Copyright © 2016 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "constant.h"
#import "Request.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    myfun = [[MyFunction alloc]init];
    myfun.delegate = self;
    
    //to register for device token
    if ([UIApplication respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    
    //facebook
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    
    //set the rootview controller
    UIStoryboard *story = [[UIStoryboard alloc]init];
    story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *view = [story instantiateViewControllerWithIdentifier:@"ViewController"];
    UINavigationController *navController = [[UINavigationController alloc]  initWithRootViewController:view];
    self.window.rootViewController = navController;
    
    
    //Check Weather User is login or not
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Login"]==YES) {
        UIStoryboard *story = [[UIStoryboard alloc]init];
        story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Request *view = [story instantiateViewControllerWithIdentifier:@"Request"];
        UINavigationController *navController = [[UINavigationController alloc]
                                                 initWithRootViewController:view];
        navController.navigationBar.barTintColor = [UIColor colorWithRed:1.0/255.0 green:72.0/255.0 blue:165.0/255.0 alpha:1.0f];
        navController.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0],NSForegroundColorAttributeName: [UIColor whiteColor]};
        self.window.rootViewController = navController;
    }
    else{
        UIStoryboard *story = [[UIStoryboard alloc]init];
        story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *view = [story instantiateViewControllerWithIdentifier:@"ViewController"];
        UINavigationController *navController = [[UINavigationController alloc]  initWithRootViewController:view];
        navController.navigationBar.barTintColor = [UIColor colorWithRed:1.0/255.0 green:72.0/255.0 blue:165.0/255.0 alpha:1.0f];
        navController.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0],NSForegroundColorAttributeName: [UIColor whiteColor]};
        
        self.window.rootViewController = navController;
    }
    

    return YES;
}

//method to open the facebook login in browser
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
}

//method to get the device token

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@", token);
    //save the device token in user defaults
    [[NSUserDefaults standardUserDefaults]setValue:token forKey:@"Devicetoken"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSLog(@"%@", [[UIDevice currentDevice]name]);

}

-(void)didReceiveResponseWithDictionary:(NSDictionary *)response AndURL:(NSString *)url{
    [myfun dismissGlobalHUD];

    //if the value sent by the publisher is accepted then stop the video and refresh the the request list.
        if([url isEqualToString:@"accept_send_notification.php"]){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stopvideo"
                                                            object:self];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshtable"
                                                            object:self];
    }
    
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{

    NSString *str = [NSString stringWithFormat: @"Error: %@", error];
    NSLog(@"Error %@",str);
    
}

//method to get the notification
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
 
    // if notification received that request is accepted then move the video screen and start subscribing i.e to subscriber class.
    if ([[[userInfo valueForKey:@"aps"] valueForKey:@"alert"]isEqualToString:@"Your Request has been accepted"]) {
        
        [[NSUserDefaults standardUserDefaults] setValue:[[userInfo objectForKey:@"aps"] objectForKey:@"id"] forKey:@"stopid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Requestaccepted"
                                                            object:nil];
    }
    //else if notification received is the total value that is sent by the publisher then show alert view asking to accept the value or not.
    else if ([[[userInfo valueForKey:@"aps"] valueForKey:@"alert"]containsString:@"Total Value"]){
        value = 0;
        sendid = [[[userInfo objectForKey:@"aps"] objectForKey:@"send_id"] intValue];
        stopid = [[[userInfo objectForKey:@"aps"] objectForKey:@"id"] intValue];
        value = [[[userInfo objectForKey:@"aps"] objectForKey:@"value"] floatValue];
              value = value*0.019;
     
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:appName message:[NSString stringWithFormat:@"Total Value:%f",value] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes",@"No", nil];
        alert.tag = 1;
        [alert show];
        
    }
    //else if notification received is to stop the video as video has been stopped by the publishewr then move to request class.
    else if ([[[userInfo valueForKey:@"aps"] valueForKey:@"alert"]containsString:@"Video has been stoped by"]){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stopvideo"
                                                            object:self];
        
    }
  
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //call api to accept  or reject the value  sent by publisher accordingly
    if (alertView.tag ==1) {
        //if yes
        if (buttonIndex == 0) {
            [myfun showGlobalProgressHUDWithTitle:@""];
            NSString *param = [NSString stringWithFormat:@"send_id=%d&status=1&id=%d",sendid,stopid];
            [myfun requestWithURL:@"accept_send_notification.php" andParameters:param];
            
        }
        //if no
        else if(buttonIndex == 1){
            [myfun showGlobalProgressHUDWithTitle:@""];
            NSString *param = [NSString stringWithFormat:@"send_id=%d&status=0&id=%d",sendid,stopid];
            [myfun requestWithURL:@"accept_send_notification.php" andParameters:param];
        }
    }
    
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    //facebook method to activateapp
    [FBSDKAppEvents activateApp];
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - InterfaceOrientations methods
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    //if ispresented is yes then landscape mode else potrait mode.is presented is set to yes only in subscriber class.
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"ispresented"] == YES){
        return UIInterfaceOrientationMaskLandscape;
    }
    else
    {
        return UIInterfaceOrientationMaskPortrait;
    }
    
}
@end
