//
//  ViewController.m
//  Subscriber
//
//  Created by TechnoMac-2 on 5/16/16.
//  Copyright © 2016 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"
#import "Subscriber.h"
#import "Request.h"
@interface ViewController ()

@end

@implementation ViewController
//@synthesize myLoginButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    
  //  self.title = @"LOGIN";
    
    //hide backbutton
  //  [self.navigationItem setHidesBackButton:YES];
    
    // set the potrait orientation
  //  [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"ispresented"];
  //  [[NSUserDefaults standardUserDefaults]synchronize];
    
    
  //  NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationMaskPortrait];
  //  [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    //set the background
  //  UIGraphicsBeginImageContext(self.view.frame.size);
  //  [[UIImage imageNamed:@"live_main"] drawInRect:self.view.bounds];
  //  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  //  UIGraphicsEndImageContext();
    
   // self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
    //facebook
  //  myLoginButton.layer.borderColor = [UIColor whiteColor].CGColor;
  //  myLoginButton.layer.borderWidth = 1.0f;
  //  myLoginButton.layer.cornerRadius = 10.0f;
}

//-(IBAction)loginButtonClicked:(id)sender;
//{
//    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
//    [login
//     logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]
//     fromViewController:self
//     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//         if (error) {
//             NSLog(@"Process error");
//         } else if (result.isCancelled) {
//             NSLog(@"Cancelled");
//         } else {
//             NSLog(@"Logged in");
//             
//             [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"Login"];
//             [[NSUserDefaults standardUserDefaults]synchronize];
//             
//             UIStoryboard *story = [[UIStoryboard alloc]init];
//             story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//             Request *view = [story instantiateViewControllerWithIdentifier:@"Request"];
//             [self.navigationController pushViewController:view animated:YES];
//         }
//         
//     }];
//    
//}

@end
