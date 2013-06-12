//
//  RotateView.h
//
//  Version 1.0
//
//  Created by Nick Lockwood on 28/07/2010.
//  Copyright 2010 Charcoal Design
//
//  Distributed under the permissive zlib license
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/RotateView
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//


#import <Availability.h>
#undef weak_delegate
#if __has_feature(objc_arc_weak)
#define weak_delegate weak
#else
#define weak_delegate unsafe_unretained
#endif


#import <UIKit/UIKit.h>


@class RotateView;


@protocol RotateViewDelegate <NSObject>
@optional

- (BOOL)rotateView:(RotateView *)rotateView shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end


@interface RotateView : UIView

@property (nonatomic, readonly) UIInterfaceOrientation currentOrientation;
@property (nonatomic, assign) UIInterfaceOrientationMask supportedOrientations;
@property (nonatomic, weak_delegate) IBOutlet id<RotateViewDelegate> delegate;

@property (nonatomic, assign) CGFloat landscapeScale;
@property (nonatomic, assign) CGFloat portraitScale;
@property (nonatomic, assign) CGSize landscapeSize;
@property (nonatomic, assign) CGSize portraitSize;
@property (nonatomic, assign) CGPoint landscapeOffset;
@property (nonatomic, assign) CGPoint portraitOffset;

@end
