//
//  TBSubscriber.h
//  Lets-Build-OTPublisher


#import <OpenTok/OpenTok.h>
#import "TBExampleVideoView.h"
@interface TBExampleSubscriber : OTSubscriberKit <TBExampleVideoViewDelegate>

 /*!video view class.*/
@property (readonly) TBExampleVideoView *view;
@end

@protocol TBExampleSubscriberDelegate <OTSubscriberKitDelegate>

/*!
  Notifies the controller for this subscriber that video is being received.
 */
- (void)subscriberVideoDataReceived:(TBExampleSubscriber*)subscriber;

@end
