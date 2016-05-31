//
//  Subscriber.h
//  Overlay-Graphics
//
//  Created by TechnoMac-2 on 5/16/16.
//  Copyright © 2016 Tokbox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenTok/OpenTok.h>
#import "TBExamplePublisher.h"
#import "TBExampleSubscriber.h"
#import "TBExampleVideoView.h"
#import "TBExampleVideoCapture.h"
#import "TBExampleOverlayView.h"
#import "MyFunction.h"
@interface Subscriber : UIViewController<OTSubscriberKitAudioLevelDelegate,OTSessionDelegate,OTSubscriberDelegate,OTPublisherDelegate,MyFunctionDelegate>{
    
    /*! Session to subscribe the video and publish the audio.*/
    OTSession* _session;
    
    TBExampleSubscriber* _subscriber;
    TBExamplePublisher* _publisher;
    TBExampleVideoCapture* _defaultVideoCapture;
    
    MyFunction *myfun;

    int timeSec;
    int timeMin;
    NSTimer *timer;
    
    /*! An integer taken to know wheather the session gets disconnect during the process due to low network or while leaving the view.if discoonects durring the process when session gets disconnected create new session start a new session lifecycle else when  gets disconnected at the time of leaving the view controller.*/
    int disconnect;
}
/*! label to show the Timer.*/
@property (nonatomic,retain)IBOutlet UILabel *lbltimer;

/*!Button to stop the video*/
@property (nonatomic,retain)IBOutlet UIButton *btnclose;

/*! Button to take the screenshot */
@property (nonatomic,retain)IBOutlet UIBarButtonItem *btnScreenshot;

/*!Connecting to a session*/
- (void)doConnect;


/*!method to publish the video*/
- (void)doPublish;

/*!
 @brief method to subscribe the video
 @param stream - Get the stream when stream is created in session delegate method.
 @return begin subscribing.
 */
- (void)doSubscribe:(OTStream*)stream;

/*!This is a good place to notify the end-user that Subscribing has stopped.*/
- (void)cleanupSubscriber;

/*!This is a good place to notify the end-user that publishing has stopped. */
- (void)cleanupPublisher;

/*!Stops subscribing  and publishing to a stream in the session.*/
- (void)stopsall;

/*!method to stop the video and navigate to back screen when notification to stop the video is received from publisher side.*/
- (void)stopvideo;

/*!method to start the timer. */
- (void) StartTimer;

/*!Event called every time the NSTimer ticks.*/
- (void)timerTick:(NSTimer *)timer;

/*!method to stop the timer. */
- (void) StopTimer;

/*!
 @brief show alert view
 @discussion shows alert view when this method is called.
 @param string - pass the string you want to show during alertview.
 @return alertview will open.
 */
- (void)showAlert:(NSString *)string;

/*!stop button api is called when all done button is pressed */
- (IBAction)endCallAction:(UIButton *)button;

/*!method called to take the screenshot of the video when screenshot button is pressed*/
-(IBAction)screenshot:(id)sender;
@end
