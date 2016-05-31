//
//  TBExampleVideoRender.h


#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import <OpenTok/OpenTok.h>

@protocol TBRendererDelegate;

@interface TBExampleVideoRender : UIView <GLKViewDelegate, OTVideoRender>

@property (nonatomic, assign) BOOL mirroring;

/*!To set rendering enabled or not. */
@property (nonatomic, assign) BOOL renderingEnabled;

@property (nonatomic, assign) id<TBRendererDelegate> delegate;

/*! OpenGL ES-aware view to get the image of that view as well as to display the view while subscribing. */
@property (strong, nonatomic) GLKView *_glkView;

/*! Clears the render buffer to a black frame. */
- (void)clearRenderBuffer;

@end


@protocol TBRendererDelegate <NSObject>
/*!
 * Used to notify the owner of this renderer that frames are being received.
 * For our example, we'll use this to wire a notification to the subscriber's
 * delegate that video has arrived.
 */
- (void)renderer:(TBExampleVideoRender*)renderer
 didReceiveFrame:(OTVideoFrame*)frame;

@end
