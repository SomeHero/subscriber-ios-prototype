//
//  TBExampleVideoCapture.h
//  OpenTok iOS SDK


#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <OpenTok/OpenTok.h>
#import <ImageIO/ImageIO.h>

@protocol OTVideoCapture;

@interface TBExampleVideoCapture : NSObject
    <AVCaptureVideoDataOutputSampleBufferDelegate, OTVideoCapture>
{
    @protected
    /*! queue is created for capturing images, so as not to affect the UI queue. */
    dispatch_queue_t _capture_queue;
}

/*! coordinates the data flow from the input to the output. */
@property (nonatomic, retain) AVCaptureSession *captureSession;

/*! To get the video output. */
@property (nonatomic, retain) AVCaptureVideoDataOutput *videoOutput;

/*! To get the video input. */
@property (nonatomic, retain) AVCaptureDeviceInput *videoInput;

@property (nonatomic, assign) NSString *captureSessionPreset;

@property (readonly) NSArray *availableCaptureSessionPresets;

/*! get the minimum frames per second. */
@property (nonatomic, assign) double activeFrameRate;

/*! method returns the best frame rate for the capturing device. */
- (BOOL)isAvailableActiveFrameRate:(double)frameRate;

/*! Current Camera Position. */
@property (nonatomic, assign) AVCaptureDevicePosition cameraPosition;


/*! Available camera Positions. */
@property (readonly) NSArray *availableCameraPositions;

/*! To change camera postion. */
- (BOOL)toggleCameraPosition;

@end
