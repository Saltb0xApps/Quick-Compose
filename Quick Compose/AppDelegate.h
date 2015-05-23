//
//  AppDelegate.h
//  UniKey
//
//  Created by Akhil Tolani on 08/11/14.
//  Copyright (c) 2014 Akhil Tolani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATMainViewController.h"
#import "iRate.h"

@class MainViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ATMainViewController *mainViewController;
@end