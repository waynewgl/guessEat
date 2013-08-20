//
//  GZAppDelegate.h
//  guessEat
//
//  Created by Guiwei LIN on 8/8/13.
//  Copyright (c) 2013 net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZHomeViewController.h"


@class GZViewController;

@interface GZAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GZViewController *viewController;

@property (strong, nonatomic)  UINavigationController *navigationController;


@end
