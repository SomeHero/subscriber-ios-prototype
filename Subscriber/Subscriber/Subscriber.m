//
//  Subscriber.m
//  Overlay-Graphics
//
//  Created by TechnoMac-2 on 5/16/16.
//  Copyright © 2016 Tokbox. All rights reserved.
//

#import "Subscriber.h"

#define widgetHeight  [UIScreen mainScreen].bounds.size.height-100
#define widgetWidth  [UIScreen mainScreen].bounds.size.width
#define TimeStamp [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000]
@interface Subscriber ()

@end

@implementation Subscriber

@synthesize btnclose,btnScreenshot;

// Replace with your OpenTok API key
static NSString *const kApiKey = @"45589122";
// Replace with your generated session ID
static NSString *const kSessionId = @"2_MX40NTU4OTEyMn5-MTQ2MzE0NDQ0NjE0Mn45dkg4am5JYnlRK21IeVRoN245QVZyWk5-UH4";
// Replace with your generated token
static NSString *const kToken = @"T1==cGFydG5lcl9pZD00NTU4OTEyMiZzaWc9MDkyOTg5YTBkYmI0ZWRlZWRiYWQyNWNjOTM1YTU4ZTBjZTQ3M2ZjODpzZXNzaW9uX2lkPTJfTVg0ME5UVTRPVEV5TW41LU1UUTJNekUwTkRRME5qRTBNbjQ1ZGtnNGFtNUpZbmxSSzIxSWVWUm9OMjQ1UVZaeVdrNS1VSDQmY3JlYXRlX3RpbWU9MTQ2MzE0NDQ2NiZub25jZT0wLjUwNDM4MTIzODI1MDA2MTkmcm9sZT1wdWJsaXNoZXImZXhwaXJlX3RpbWU9MTQ2NTczNjQ2NA==";

// Change to NO to subscribe to streams other than your own.
static bool subscribeToSelf = NO;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    disconnect = 0;
    // Do any additional setup after loading the view from its nib.
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ispresented"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
 
    //to set the background
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    //Screenshot button to get the screenshot of the view
    btnScreenshot = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"screen_captureic"] style:UIBarButtonItemStylePlain target:self action:@selector(screenshot:)];
    btnScreenshot.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = btnScreenshot;
  
}

-(void)viewWillAppear:(BOOL)animated{
    
    [myfun showGlobalProgressHUDWithTitle:@""];
    
    disconnect = 0;
    
    self.title = @"Subscriber";
    
    //bool set to userdefaults to save the current view in landscape mode
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ispresented"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    
    //Initializing an OTSession object
    
    _session = [[OTSession alloc] initWithApiKey:kApiKey
                                       sessionId:kSessionId
                                        delegate:self];
    

    [self doConnect];
    
    //notification to stop the video
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopvideo)
                                                 name:@"stopvideo"
                                               object:nil];
    
   

    
    myfun = [[MyFunction alloc]init];
    myfun.delegate = self;

    //button close ui
    btnclose.layer.borderColor = [UIColor whiteColor].CGColor;
    btnclose.layer.borderWidth = 1.0f;
    btnclose.layer.cornerRadius = 10.0f;

}

//when view is disappearing
-(void)viewWillDisappear:(BOOL)animated{

    [myfun dismissGlobalHUD];
    
    disconnect = 1;
    
    [self sessionDidDisconnect:nil];
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"ispresented"];
    [[NSUserDefaults standardUserDefaults]synchronize];

}

#pragma mark - Open Token Methods

- (void)doConnect
{
    [myfun dismissGlobalHUD];
    [myfun showGlobalProgressHUDWithTitle:@"Connecting"];
    OTError *error = nil;
    [_session connectWithToken:kToken error:&error];
    if (error)
    {
        [self showAlert:[error localizedDescription]];
    }
}

- (void)doPublish
{
    [myfun dismissGlobalHUD];
    _publisher = [[TBExamplePublisher alloc]
                  initWithDelegate:self
                  name:[[UIDevice currentDevice] name]];

    OTError *error = nil;
    [_session publish:_publisher error:&error];
    
    //if error show alert
    if (error)
    {
        [self showAlert:[error localizedDescription]];
    }
    
    //set frame for video
    [_publisher.view setFrame:CGRectMake(0, 0, 0, 0)];
    
    [self.view addSubview:_publisher.view];
    
}

- (void)doSubscribe:(OTStream*)stream
{
    _subscriber = [[TBExampleSubscriber alloc] initWithStream:stream
                                                     delegate:self];
    OTError *error = nil;
    [_session subscribe:_subscriber error:&error];
    if (error)
    {
        [self showAlert:[error localizedDescription]];
    }
    _subscriber.audioLevelDelegate = self;
}

- (void)cleanupSubscriber
{
    [_subscriber.view removeFromSuperview];
    _subscriber = nil;
}

- (void)cleanupPublisher {
    [_publisher.view removeFromSuperview];
    _publisher = nil;
    
}

-(void)stopsall{

    OTError* error = nil;
    [_session unsubscribe:_subscriber error:&error];
    [_session unpublish:_publisher error:&error];
    [_session disconnect:nil];
    if (error) {
        NSLog(@"Stopped Due to (%@)", error);
    }
    [_subscriber.view removeFromSuperview];
}

#pragma mark - Show Alert message function method
- (void)showAlert:(NSString *)string
{
    [myfun dismissGlobalHUD];
    
    // show alertview on main UI
    dispatch_async(dispatch_get_main_queue(), ^{
        [myfun dismissGlobalHUD];
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:appName
                                    message:@"Please check the Network"
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
        [alert show];
    });


}
#pragma mark - Helper Methods

-(void)stopvideo{
    [myfun dismissGlobalHUD];
    [self StopTimer];
    [self stopsall];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"stopvideo" object:nil];

    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)endCallAction:(UIButton *)button
{
    
    [myfun showGlobalProgressHUDWithTitle:@""];
    NSString *param = [NSString stringWithFormat:@"id=%d&name=%@",[[[NSUserDefaults standardUserDefaults]valueForKey:@"stopid"] intValue],devicename];
    
    [myfun requestWithURL:@"cancel.php" andParameters:param];
    
}

-(void) StartTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)timerTick:(NSTimer *)timer
{
    timeSec++;
    if (timeSec == 60)
    {
        timeSec = 0;
        timeMin++;
    }
    //Format the string 00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", timeMin, timeSec];
    //Display on your label
   
    _lbltimer.text= timeNow;
    
    if ([_lbltimer.text isEqualToString:@"30:00"]) {
        [self StopTimer];
        [self stopsall];
    }
}


- (void) StopTimer
{
    [timer invalidate];
    timeSec = 0;
    timeMin = 0;
    //Since we reset here, and timerTick won't update your label again, we need to refresh it again.
    //Format the string in 00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", timeMin, timeSec];
    //Display on your label
    
    _lbltimer.text= timeNow;
}


#pragma mark - screenshot
-(IBAction)screenshot:(id)sender{
    UIView* screenCapture = [_subscriber.view
                             snapshotViewAfterScreenUpdates:YES];
    [self.view addSubview:screenCapture];
    
    UIGraphicsBeginImageContextWithOptions(_subscriber.view.bounds.size,
                                           NO, [UIScreen mainScreen].scale);
    [self.view drawViewHierarchyInRect:_subscriber.view.bounds
               afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //save image to document directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:TimeStamp];
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:savedImagePath atomically:NO];
    
    [screenCapture removeFromSuperview];
    
    
    [screenCapture removeFromSuperview];
}

# pragma mark - My function Delegate method to get the response of api
-(void)didReceiveResponseWithDictionary:(NSDictionary *)response AndURL:(NSString *)url{
    
    [myfun dismissGlobalHUD];
    
    if ([url isEqualToString:@"cancel.php"]) {
        [self StopTimer];
        [self stopsall];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"stopvideo" object:nil];
       
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else{
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"stopvideo" object:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}
# pragma mark - Orientation methods
- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (UIUserInterfaceIdiomPhone == [[UIDevice currentDevice]
                                      userInterfaceIdiom])
    {
        return NO;
    } else {
        return YES;
    }
}

# pragma mark - OTSession delegate callbacks

- (void)sessionDidConnect:(OTSession*)session
{
    NSLog(@"sessionDidConnect (%@)", session.sessionId);
   
    // Step 2: We have successfully connected, now instantiate a publisher and
    // begin pushing A/V streams into OpenTok.
    [self doPublish];
}

- (void)sessionDidDisconnect:(OTSession*)session
{
    [myfun dismissGlobalHUD];
    
    NSString* alertMessage =
    [NSString stringWithFormat:@"Session disconnected: (%@)",
     session.sessionId];
    NSLog(@"sessionDidDisconnect (%@)", alertMessage);
    
    if (disconnect == 0) {
        [self cleanupSubscriber];
        [myfun showGlobalProgressHUDWithTitle:@"Connecting"];
        [self doConnect];
    }
    
}

# pragma mark - Detecting streams in a session
- (void)session:(OTSession*)mySession
  streamCreated:(OTStream *)stream
{
    [myfun dismissGlobalHUD];
    [myfun showGlobalProgressHUDWithTitle:@"Begin Subscribing"];
    NSLog(@"session streamCreated (%@)", stream.streamId);
    
    // Step 3a: (if NO == subscribeToSelf): Begin subscribing to a stream we
    // have seen on the OpenTok session.
    if (nil == _subscriber && !subscribeToSelf)
    {
        [self doSubscribe:stream];
    }
}

- (void)session:(OTSession*)session
streamDestroyed:(OTStream *)stream
{
    [myfun dismissGlobalHUD];
    NSLog(@"session streamDestroyed (%@)", stream.streamId);
    
    if ([_subscriber.stream.streamId isEqualToString:stream.streamId])
    {
        [self cleanupSubscriber];
    }
}

- (void)  session:(OTSession *)session
connectionCreated:(OTConnection *)connection
{
    NSLog(@"session connectionCreated (%@)", connection.connectionId);
}

- (void)    session:(OTSession *)session
connectionDestroyed:(OTConnection *)connection
{
    [myfun dismissGlobalHUD];
    NSLog(@"session connectionDestroyed (%@)", connection.connectionId);
    if ([_subscriber.stream.connection.connectionId
         isEqualToString:connection.connectionId])
    {
        [self cleanupSubscriber];
    }
}

- (void) session:(OTSession*)session
didFailWithError:(OTError*)error
{
    [myfun dismissGlobalHUD];
    NSLog(@"didFailWithError: (%@)", error);
    [myfun showGlobalProgressHUDWithTitle:@"Connecting"];
    [self doConnect];
}
# pragma mark - OTPublisher delegate callbacks

- (void)publisher:(OTPublisherKit *)publisher
    streamCreated:(OTStream *)stream
{
    // Step 3b: (if YES == subscribeToSelf): Our own publisher is now visible to
    // all participants in the OpenTok session. We will attempt to subscribe to
    // our own stream. Expect to see a slight delay in the subscriber video and
    // an echo of the audio coming from the device microphone.
        if (nil == _subscriber && subscribeToSelf)
        {
            [self doSubscribe:stream];
        }
}

- (void)publisher:(OTPublisherKit*)publisher
  streamDestroyed:(OTStream *)stream
{
        if ([_subscriber.stream.streamId isEqualToString:stream.streamId])
        {
            [self cleanupSubscriber];
        }
    
      [self cleanupPublisher];
    
}

- (void)publisher:(OTPublisherKit*)publisher
 didFailWithError:(OTError*) error
{
    NSLog(@"publisher didFailWithError %@", error);
    [self cleanupPublisher];
    [self doConnect];
}

- (void)     session:(OTSession*)session
archiveStartedWithId:(NSString *)archiveId
                name:(NSString *)name
{
    NSLog(@"session archiving started with id:%@ name:%@", archiveId, name);
    TBExampleOverlayView *overlayView =
    [(TBExampleVideoView *)[_publisher view] overlayView];
    [overlayView startArchiveAnimation];
}

- (void)     session:(OTSession*)session
archiveStoppedWithId:(NSString *)archiveId
{
    NSLog(@"session archiving stopped with id:%@", archiveId);
    TBExampleOverlayView *overlayView =
    [(TBExampleVideoView *)[_publisher view] overlayView];
    [overlayView stopArchiveAnimation];
}

# pragma mark - OTSubscriber delegate callbacks
//method when subscriber did connect to stream then set the frame and start the timer
- (void)subscriberDidConnectToStream:(OTSubscriberKit*)subscriber
{
    [myfun dismissGlobalHUD];
    NSLog(@"subscriberDidConnectToStream (%@)",
          subscriber.stream.connection.connectionId);
    [_subscriber.view setFrame:CGRectMake(0, 0, widgetWidth,
                                          widgetHeight)];
    [self.view addSubview:_subscriber.view];
    
     [self StartTimer];
}

- (void)subscriber:(OTSubscriberKit*)subscriber
  didFailWithError:(OTError*)error
{
    [myfun dismissGlobalHUD];
    NSLog(@"subscriber %@ didFailWithError %@",
          subscriber.stream.streamId,
          error);
    [self cleanupSubscriber];
    [self doConnect];
}

- (void)subscriberVideoDisabled:(OTSubscriberKit*)subscriber
                         reason:(OTSubscriberVideoEventReason)reason
{
    [(TBExampleVideoView*)subscriber.videoRender audioOnlyView].hidden = NO;
    
    if (reason == OTSubscriberVideoEventQualityChanged)
        [[(TBExampleVideoView*)subscriber.videoRender overlayView]
         showVideoDisabled];
    
    _subscriber.audioLevelDelegate = self;
}

- (void)subscriberVideoEnabled:(OTSubscriberKit*)subscriber
                        reason:(OTSubscriberVideoEventReason)reason
{
    [(TBExampleVideoView*)subscriber.videoRender audioOnlyView].hidden = YES;
    
    if (reason == OTSubscriberVideoEventQualityChanged)
        [[(TBExampleVideoView*)subscriber.videoRender overlayView] resetView];
    
    _subscriber.audioLevelDelegate = nil;
}

- (void)subscriberVideoDisableWarning:(OTSubscriberKit*)subscriber
{
    NSLog(@"subscriberVideoDisableWarning");
    [[(TBExampleVideoView*)subscriber.videoRender overlayView]
     showVideoMayDisableWarning];
}

- (void)subscriberVideoDisableWarningLifted:(OTSubscriberKit*)subscriber
{
    NSLog(@"subscriberVideoDisableWarningLifted");
    [[(TBExampleVideoView*)subscriber.videoRender overlayView] resetView];
}

- (void)subscriber:(OTSubscriberKit *)subscriber
 audioLevelUpdated:(float)audioLevel{
    float db = 20 * log10(audioLevel);
    float floor = -40;
    float level = 0;
    if (db > floor) {
        level = db + fabsf(floor);
        level /= fabsf(floor);
    }
    _subscriber.view.audioLevelMeter.level = level;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)subscriberVideoDataReceived:(OTSubscriber *)subscriber{

}

@end
