//
//  TSAppDelegate.h
//  VideoPlayer
//
//  Created by Sergey Krotkih on 7/31/13.
//  Copyright (c) 2013 Sergey Krotkih. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSViewController;

@interface TSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TSViewController *viewController;
@property (nonatomic, strong) UINavigationController* navControllwer;

@end
