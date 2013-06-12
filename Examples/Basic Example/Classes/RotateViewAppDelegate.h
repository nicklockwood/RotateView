//
//  RotateViewAppDelegate.h
//  RotateView
//
//  Created by Nick Lockwood on 03/02/2011.
//  Copyright 2011 AKQA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RotateViewViewController;

@interface RotateViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RotateViewViewController *viewController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet RotateViewViewController *viewController;

@end

