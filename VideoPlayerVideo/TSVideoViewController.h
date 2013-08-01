//
//  TSVideoViewController.h
//  VideoPlayer
//
//  Created by Sergey Krotkih on 7/31/13.
//  Copyright (c) 2013 Sergey Krotkih. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TSVideoControllerDelegate;

@interface TSVideoViewController : UIViewController
{
    NSURL* video_url;
    BOOL isFullScreenMode;
}

@property (nonatomic, copy) NSURL* video_url;
@property (nonatomic, assign) BOOL isFullScreenMode;

- (id) initWithDelegate: (id <TSVideoControllerDelegate>) aDelegate;

@end
