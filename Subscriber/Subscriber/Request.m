//
//  Request.m
//  Subscriber
//
//  Created by TechnoMac-2 on 5/27/16.
//  Copyright © 2016 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "Request.h"
#import "Subscriber.h"
#import "ViewController.h"
#import "AllMediaVC.h"
@interface Request ()

@end

@implementation Request
@synthesize btnrequest;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //myfunction is utitlity class to implement api
    myfun = [[MyFunction alloc]init];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
        
    self.title = @"Subscriber";
    
    myfun.delegate = self;
    
    
    //call the api to register device in list of devices
//    NSString *str = [NSString stringWithFormat:@"name=%@&device_token=%@&status=0",devicename,devicetoken];
//    [myfun requestWithURL:@"add_device.php" andParameters:str];

    //set background
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    //set the orientation
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"ispresented"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationMaskPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    
   

    //notification called to navigate to video screen i.e subscriber screen
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(navigatetoSubscriber)
                                                 name:@"Requestaccepted"
                                               object:nil];
    
    // ui for  request button
    btnrequest.layer.borderColor = [UIColor whiteColor].CGColor;
    btnrequest.layer.borderWidth = 1.0f;
    btnrequest.layer.cornerRadius = 10.0f;
    
    //logout button programatically set
//    UIBarButtonItem *btnlogout = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"power"] style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
//    btnlogout.tintColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = btnlogout;

    //gallery button programatically set
    UIBarButtonItem *btngallery = [[UIBarButtonItem alloc]initWithTitle:@"Gallery" style:UIBarButtonItemStylePlain target:self action:@selector(gallery)];
    btngallery.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = btngallery;

    
}

-(void)gallery{
    
    UIStoryboard *story = [[UIStoryboard alloc]init];
    story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AllMediaVC *view = [story instantiateViewControllerWithIdentifier:@"AllMediaVC"];
    
    [self.navigationController pushViewController:view animated:YES];
    
}
#pragma mark - User Defined Methods
//-(void)logout{
//    
//
//    NSString *param = [[NSString alloc]initWithFormat:@"name=%@&device_token=%@&status=1",devicename,devicetoken];
//    [myfun requestWithURL:@"delete_device.php" andParameters:param];
//    
//    
//}

-(void)navigatetoSubscriber{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Requestaccepted" object:nil];
    
    UIStoryboard *story = [[UIStoryboard alloc]init];
    story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Subscriber *view = [story instantiateViewControllerWithIdentifier:@"Subscriber"];
    [self.navigationController pushViewController:view animated:YES];
    
}

-(IBAction)req:(id)sender{
    
    [myfun showGlobalProgressHUDWithTitle:@""];
    NSString *str = [NSString stringWithFormat:@"name=%@&device_token=%@",devicename,devicetoken];
    [myfun requestWithURL:@"request.php" andParameters:str];
    
}

#pragma mark - Delegate method to get the response of api
-(void)didReceiveResponseWithDictionary:(NSDictionary *)response AndURL:(NSString *)url{
    
    [myfun dismissGlobalHUD];
    
//    if ([url isEqualToString:@"add_device.php"]) {
//        if ([[response valueForKey:@"status"] intValue]==0) {
//            NSLog(@"User Added");
//        }
//    }
//     if ([url isEqualToString:@"delete_device.php"]){
//        if ([[response valueForKey:@"status"] intValue]==0) {
//            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Login"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//            UIStoryboard *story = [[UIStoryboard alloc]init];
//            story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            ViewController *view = [story instantiateViewControllerWithIdentifier:@"ViewController"];
//            [self.navigationController pushViewController:view animated:YES];
//        }
//    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
