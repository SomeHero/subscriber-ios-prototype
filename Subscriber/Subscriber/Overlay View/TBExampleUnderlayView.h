//
//  OTUnderlayView.h
//  Overlay-Graphics


#import <UIKit/UIKit.h>

typedef enum {
    TBExampleUnderlayViewTypeSubscriber = 0,
    TBExampleUnderlayViewTypePublisher  = 1
} TBExampleUnderlayViewType;

@interface TBExampleUnderlayView : UIView

/*! to set audio active or inactive */
@property (nonatomic) BOOL audioActive;

/*!
 @brief underlayview frame
 
 @discussion set the underlayview frame adding subview of active audio and inactive audio imageview
 
 @param frame - set the frame of underlay view
 
 @return frame
 */
- (id)initWithFrame:(CGRect)frame;

@end
