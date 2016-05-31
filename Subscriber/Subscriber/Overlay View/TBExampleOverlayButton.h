//
//  OTOverlayButton.h
//  Overlay-Graphics


#import <UIKit/UIKit.h>

@protocol TBExampleOverlayButtonDelegate;

typedef enum {
    TBExampleOverlayButtonTypeMuteButton,
    TBExampleOverlayButtonTypeVolumeButton,
    TBExampleOverlayButtonTypeRecordButton,
    TBExampleOverlayButtonTypeSwitchCameraButton
} TBExampleOverlayButtonType;

@interface TBExampleOverlayButton : UIButton

/*! type of button */
@property (nonatomic) TBExampleOverlayButtonType type;

@property (nonatomic, assign) id<TBExampleOverlayButtonDelegate> delegate;

/*!
 @brief set the frame of button
 
 @discussion according to the type of button, frame is set.
 
 @param frame - set the frame.
 @param button - type of button.
 @param delegate - self.
 
 @return will return the frame size of button.
 */
- (id)initWithFrame:(CGRect)frame
  buttonType:(TBExampleOverlayButtonType)buttonType
           delegate:(id<TBExampleOverlayButtonDelegate>)delegate;

@end

@protocol TBExampleOverlayButtonDelegate <NSObject>

/*!
 @brief action on button selected.
 
 @discussion checks which button is selected and on that button action is called,for example to mute unmute TBExampleOverlayButtonTypeMuteButton is selected and action is performed accordingly.
 
 @param button.

 @return will for perform the action accordingly based on button selected.
*/
- (void)overlayButtonWasSelected:(TBExampleOverlayButton*)button;

@end
