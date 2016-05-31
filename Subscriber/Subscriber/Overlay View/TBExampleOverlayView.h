//
//  OTOverlayView.h
//  Overlay-Graphics


#import <UIKit/UIKit.h>
#import "TBExampleOverlayButton.h"

#define OVERLAY_NAME_MIN_WIDTH 50
#define OVERLAY_MIN_WIDTH 150
#define OVERLAY_CONTROL_BAR_HEIGHT 43
#define OVERLAY_BUTTON_WIDTH_SM 60 //75
#define OVERLAY_BUTTON_WIDTH_LG 60 //90
#define OVERLAY_HIDE_TIME_MS 5000
#define OVERLAY_LOGO_HIDE_TIME_MS 5000
#define OVERLAY_TOOLTIP_HIDE_TIME_MS 2000

typedef enum {
    TBExampleOverlayViewTypeSubscriber = 0,
    TBExampleOverlayViewTypePublisher  = 1
} TBExampleOverlayViewType;

@protocol TBExampleOverlayViewDelegate;

@interface TBExampleOverlayView : UIView <TBExampleOverlayButtonDelegate>

@property (nonatomic, assign) id<TBExampleOverlayViewDelegate> delegate;

/*! Name of publisher or subscriber */
@property (nonatomic, retain) NSString* displayName;
/*! wheather a stream has video or not*/
@property (nonatomic, setter = setStreamHasVideo:) BOOL streamHasVideo;
/*! wheather a stream has audio or not*/
@property (nonatomic, setter = setStreamHasAudio:) BOOL streamHasAudio;
/*! Button bar */
@property (nonatomic, retain) UIView *toolbarView;


/*!
 @brief video frame
 
 @discussion set the overlay view frame
 
 @param frame - set the frame of overlay view
 @param delegate - self
 @param overlayType -(TBExampleOverlayViewTypeSubscriber) 0 or(TBExampleOverlayViewTypePublisher) 1.
 @param displayname - nil
 
 @return will set the frmae of type of overlay view and will set the delegate.
*/

- (id)initWithFrame:(CGRect)frame 
        overlayType:(TBExampleOverlayViewType)type 
        displayName:(NSString*)displayName
           delegate:(id<TBExampleOverlayViewDelegate>)delegate;

/*!
 @brief toggle camera.
 @discussion method when toggle camera button is pressed.
 @return front camera or back camera.
*/

- (void)toggleCamera;

/*!
 @brief Mute button methhod.
 @discussion mute/unmute the video.
 @param muted:yes/no.
 @return will mute /umute the video.
*/
- (void)muted:(BOOL)mute;

/*!
 @brief shows button bar view.
 @discussion will button bar view based on TBExampleOverlayViewType.
 @return overlayview.
*/
-(void)showoverlayview;

/*!
 @brief start archiving.
 @discussion will start archiving the video recording.
 @return stream is getting recorded  and button image changes.
*/

- (void)startArchiveAnimation;


/*!
 @brief stop archiving.
 @discussion will stop video recording and save to the server side.
 @return stream will be recorded  and button image changes.
*/

- (void)stopArchiveAnimation;


/*!
 @brief video may diabled warning.
 @discussion warns the users that video may gets disabled.
 @return warning button image shown.
*/

- (void)showVideoMayDisableWarning;

/*!
 @brief shows that video is diabled.
 @discussion shows that video recording has been disabled.
 @return video gets disabled and button image changes.
*/
- (void)showVideoDisabled;

/*!
 reset the view.
 */
- (void)resetView;
@end

@protocol TBExampleOverlayViewDelegate <NSObject>

@optional

/*!
 @brief Toggle the camera button.
 
 @discussion will call delegate videoViewDidToggleCamera method.
 
 @param overlayView.
 
 @return will toggle front and back.
 */
- (void)overlayViewDidToggleCamera:(TBExampleOverlayView*)overlayView;

/*!
 @brief Check Mute publisher
 
 @discussion will call delegate publisherWasMuted method.
 
 @param overlayView.
 
 @param publisherWasMuted:publisherMuted or !publisherMuted.
 
 @return
 */

- (void)overlayView:(TBExampleOverlayView*)overlay publisherWasMuted:(BOOL)publisherMuted;

/*!
 @brief Check Mute Subscriber
 
 @discussion will call delegate subscriberVolumeWasMuted method.
 
 @param overlayView.
 
 @param publisherWasMuted:subscriberMuted or !subscriberMuted.
 
 @return
 */

- (void)overlayView:(TBExampleOverlayView*)overlay subscriberVolumeWasMuted:(BOOL)subscriberMuted;

@end