//
//  TSCurrentOrientation.m
//  VideoPlayer
//
//  Created by Sergey Krotkih on 8/1/13.
//  Copyright (c) 2013 Sergey Krotkih. All rights reserved.
//

#import "TSCurrentOrientation.h"

UIDeviceOrientation getCurrentOrientation()
{
    UIDevice *device = [UIDevice currentDevice];
    [device beginGeneratingDeviceOrientationNotifications];
    UIDeviceOrientation currentOrientation = device.orientation;
    [device endGeneratingDeviceOrientationNotifications];
    
    return currentOrientation;
}
