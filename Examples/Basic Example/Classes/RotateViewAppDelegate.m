//
//  RotateViewAppDelegate.m
//  RotateView
//
//  Created by Nick Lockwood on 03/02/2011.
//  Copyright 2011 AKQA. All rights reserved.
//

#import "RotateViewAppDelegate.h"
#import "RotateViewViewController.h"

@implementation RotateViewAppDelegate

@synthesize window;
@synthesize viewController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
