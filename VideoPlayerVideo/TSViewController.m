//
//  TSViewController.m
//  VideoPlayer
//
//  Created by Sergey Krotkih on 7/31/13.
//  Copyright (c) 2013 Sergey Krotkih. All rights reserved.
//

#import "TSViewController.h"
#import "TSAppDelegate.h"
#import "TSVideoViewController.h"
#import "TSCurrentOrientation.h"

@interface TSViewController ()
- (void) PlayVideo: (NSURL*) videoUrl;

@property(nonatomic, weak) IBOutlet UIButton* playButton;

@end

@implementation TSViewController
{
    UINavigationController* navController;
    TSVideoViewController* moviePlayerController;
    BOOL isPlayingVideo;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    TSAppDelegate* appDelegate = (TSAppDelegate*)[[UIApplication sharedApplication] delegate];
    navController = appDelegate.navControllwer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) playVideo: (id) sender
{
    NSString* videoPath = [[NSBundle mainBundle] pathForResource: @"video"
                                                          ofType: @"mp4"];
    [self PlayVideo: [NSURL fileURLWithPath: videoPath]];
}

- (void) PlayVideo: (NSURL*) videoUrl
{
    if (isPlayingVideo)
    {
        [moviePlayerController.view removeFromSuperview];
        moviePlayerController = nil;
        
        isPlayingVideo = NO;
    }
    else
    {
        if (!moviePlayerController)
        {
            moviePlayerController = [[TSVideoViewController alloc] initWithDelegate: self];
        }
        
        moviePlayerController.video_url = videoUrl;
        moviePlayerController.isFullScreenMode = NO;
        
        [moviePlayerController.view setFrame:CGRectMake(6, 69, 309, 196)];
        [self.view addSubview: moviePlayerController.view];
        
        [self.view bringSubviewToFront: self.playButton];
    }
}

- (NSUInteger) supportedInterfaceOrientations
{
    if (isPlayingVideo && !moviePlayerController.isFullScreenMode)
    {
        NSArray* vcs = self.navigationController.viewControllers;
        UIViewController* topViewController = [vcs objectAtIndex: [vcs count] - 1];
        
        if (topViewController !=  moviePlayerController)
        {
            UIDeviceOrientation deviceOrientation = getCurrentOrientation();
            
            if (deviceOrientation == UIDeviceOrientationLandscapeLeft || deviceOrientation == UIDeviceOrientationLandscapeRight)
            {
                moviePlayerController.isFullScreenMode = YES;
                [navController pushViewController: moviePlayerController
                                         animated: NO];
                
                return UIInterfaceOrientationMaskAll;
            }
        }
    }
    
    return UIInterfaceOrientationMaskPortrait;
}

- (void) didRotateToPortraitOrientation
{
    if (moviePlayerController.isFullScreenMode)
    {
        [[UIApplication sharedApplication] setStatusBarHidden: NO];
        [navController popViewControllerAnimated: NO];
        moviePlayerController.isFullScreenMode = NO;
    }
}

- (void) HasFinishedToPlay
{
    if (moviePlayerController.isFullScreenMode)
    {
        [[UIApplication sharedApplication] setStatusBarHidden: NO];
        [navController popViewControllerAnimated: NO];
    }

    [moviePlayerController.view removeFromSuperview];
    moviePlayerController = nil;
    
    isPlayingVideo = NO;
}

- (void) hasStartedToPlay
{
    isPlayingVideo = YES;
}

@end
