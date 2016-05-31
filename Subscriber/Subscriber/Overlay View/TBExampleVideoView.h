//
//  OTVideoView.h
//  Overlay-Graphics


#import <UIKit/UIKit.h>
#import <OpenTok/OpenTok.h>
#import "TBExampleVideoRender.h"
#import "TBAudioLevelMeter.h"

typedef enum {
    OTVideoViewTypeSubscriber,
    OTVideoViewTypePublisher
} OTVideoViewType;

@class TBExampleGLViewRender,TBExampleOverlayView;
@protocol TBExampleVideoViewDelegate;

/**
 * A generic view hierarchy for viewable objects with video in the OpenTok iOS 
 * SDK.
 */
@interface TBExampleVideoView : UIView <OTVideoRender>

/*!
 - This view holds the bottom bar of video panels. Included is a
 - nameplate showing the stream's name, and buttons for muting tracks
 - and (for a publisher) switching the camera.
 */
@property(readonly, retain) UIView* toolbarView;

/*!
 * This view contains the video track for a stream, when available.
 * For subscribers, this view renders frames of the stream.
 * For publishers, this view renders frames as they are encoded to a stream.
 */
@property(readonly, retain) TBExampleVideoRender *videoView;

/*!
 *name of publisher/subscriber.
 */
@property(nonatomic, copy) NSString *displayName;

/*!
 *To check wheather stream has video or not.
 */
@property(nonatomic) BOOL streamHasVideo;

/*!
 *To check wheather stream has audio or not.
 */

@property(nonatomic) BOOL streamHasAudio;

/*!
 *Button bar view.
*/

@property(nonatomic, retain) TBExampleOverlayView *overlayView;

/*!
 *Audiolevelmeter view.
*/

@property (retain, nonatomic) TBAudioLevelMeter *audioLevelMeter;

/*!
 *Audio view.
*/

@property (retain, nonatomic) UIView *audioOnlyView;

/*!
 @brief video frame
 
 @discussion set the video frame
 
 @param frame - set the frame of video
 @param delegate - self
 @param type - OTVideoViewTypeSubscriber or OTVideoViewTypePublisher
 @param displayname - nil
 
 @return will set the frmae of type of video view and will set the delegate.
 */

- (id)initWithFrame:(CGRect)frame
           delegate:(id<TBExampleVideoViewDelegate>)delegate
               type:(OTVideoViewType)type
        displayName:(NSString*)displayName;

@end

@protocol TBExampleVideoViewDelegate <NSObject>

@optional

/*!
 @brief Toggle the camera button.
 
 @discussion it will toggle the front camera and back camera.
 
 @param videoview.
 
 @return will toggle front and back.
*/

- (void)videoViewDidToggleCamera:(TBExampleVideoView*)videoView;

/*!
 @brief Check Mute publisher
 
 @discussion Method to make Subscriber mute or unmute.
 
 @param videoView:(UIView*)videoView
 
 @param publisherWasMuted:publisherMuted or !publisherMuted.
 
 @return
*/

- (void)videoView:(TBExampleVideoView*)videoView
publisherWasMuted:(BOOL)publisherMuted;

/*!
 @brief Check Mute Subscriber
 
 @discussion Method to make Subscriber mute or unmute.
 
 @param videoView:(UIView*)videoView
 
 @param publisherWasMuted:subscriberMuted or !subscriberMuted.
 
 @return
*/

- (void)videoView:(TBExampleVideoView*)videoView
subscriberVolumeWasMuted:(BOOL)subscriberMuted;

@end
