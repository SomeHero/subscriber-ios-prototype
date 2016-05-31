//
//  TBPublisher.h


#import <OpenTok/OpenTok.h>
#import "TBExampleVideoView.h"

@interface TBExamplePublisher : OTPublisherKit <TBExampleVideoViewDelegate>

 /*!video view class.*/
@property(readonly) TBExampleVideoView *view;

/*! to get the camera postition i.e front camer/back camera. */
@property(nonatomic, assign) AVCaptureDevicePosition cameraPosition;
@end
