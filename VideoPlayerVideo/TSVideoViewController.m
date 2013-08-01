//
//  TSVideoViewController.h
//  VideoPlayer
//
//  Created by Sergey Krotkih on 7/31/13.
//  Copyright (c) 2013 Sergey Krotkih. All rights reserved.
//

#import "TSVideoViewController.h"
#import "TSVideoControllerDelegate.h"
#import "TSCurrentOrientation.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TSVideoViewController()
- (void) play;
@end

@implementation TSVideoViewController
{
    MPMoviePlayerController* moviePlayerController;
    id <TSVideoControllerDelegate> delegate;
    BOOL isPlayingVideo;
    BOOL lockRotations;
}

@synthesize video_url;
@synthesize isFullScreenMode;

- (id) initWithDelegate: (id <TSVideoControllerDelegate>) aDelegate
{
    if ((self = [super init]))
    {
        delegate = aDelegate;
        
        moviePlayerController = [[MPMoviePlayerController alloc] init];
        isFullScreenMode = NO;
        
        if ([moviePlayerController respondsToSelector: @selector(loadState)])
        {
            [[NSNotificationCenter defaultCenter] addObserver: self
                                                     selector: @selector(moviePlayerLoadStateChanged:)
                                                         name: MPMoviePlayerLoadStateDidChangeNotification
                                                       object: nil];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] addObserver: self
                                                     selector: @selector(moviePreloadDidFinish:)
                                                         name: MPMoviePlayerContentPreloadDidFinishNotification
                                                       object: nil];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(moviePlayBackDidFinish:)
                                                     name: MPMoviePlayerPlaybackDidFinishNotification
                                                   object: nil];
    }

	return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    UIView* newView = [[UIView alloc] initWithFrame: frame];
    newView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self setView: newView];
    
    UIView* playerView = [moviePlayerController view];
    playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [playerView setFrame: frame];
    [self.view addSubview: playerView];
}

- (void) viewDidAppear: (BOOL) animated
{
    [super viewDidAppear: animated];
    
    if (isPlayingVideo)
    {
        isPlayingVideo = NO;
        [delegate HasFinishedToPlay];        
    }
    else
    {
        isPlayingVideo = YES;
        [self play];
    }
}

- (void) setIsFullScreenMode: (BOOL) anIsFullScreenMode
{
    isFullScreenMode = anIsFullScreenMode;
    
    if (isFullScreenMode)
    {
        [moviePlayerController setControlStyle: MPMovieControlStyleFullscreen];
        [moviePlayerController setFullscreen: YES];
    }
    else
    {
        [moviePlayerController setControlStyle: MPMovieControlStyleNone];
        [moviePlayerController setFullscreen: NO];
    }
}

- (void) play
{
    moviePlayerController.contentURL = video_url;
    
    [moviePlayerController prepareToPlay];
    
    [delegate hasStartedToPlay];
    
    [moviePlayerController play];
}

- (void) moviePlayBackDidFinish: (NSNotification*) notification
{
    [delegate HasFinishedToPlay];
}

- (NSUInteger) supportedInterfaceOrientations
{
    UIDeviceOrientation deviceOrientation = getCurrentOrientation();
    
    if ((deviceOrientation == UIDeviceOrientationPortrait || deviceOrientation == UIDeviceOrientationPortraitUpsideDown))
    {
        if (!lockRotations)
        {
            lockRotations = YES;
            [delegate didRotateToPortraitOrientation];
        }
    }
    else
    {
         lockRotations = NO;
    }
    
    return UIInterfaceOrientationMaskAll;
}

- (void) moviePlayerLoadStateChanged: (NSNotification*) notification
{
}

- (void) moviePreloadDidFinish: (NSNotification*) notification
{
}

@end
