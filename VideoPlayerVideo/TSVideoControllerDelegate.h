//
//  TSVideoControllerDelegate.h
//  VideoPlayer
//
//  Created by Sergey Krotkih on 7/31/13.
//  Copyright (c) 2013 Sergey Krotkih. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TSVideoControllerDelegate <NSObject>
- (void) HasFinishedToPlay;
- (void) hasStartedToPlay;
- (void) didRotateToPortraitOrientation;
@end
