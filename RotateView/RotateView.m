//
//  RotateView.m
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

#import "RotateView.h"


@interface RotateView ()

@property (nonatomic, assign) UIInterfaceOrientation lastOrientation;

@end


@implementation RotateView

- (UIInterfaceOrientation)currentOrientation
{	
	switch ([UIDevice currentDevice].orientation)
    {
		case UIDeviceOrientationPortrait:
		case UIDeviceOrientationPortraitUpsideDown:
		case UIDeviceOrientationLandscapeLeft:
		case UIDeviceOrientationLandscapeRight:
			return (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
        default:
            return UIInterfaceOrientationPortrait;
	}
}

- (CGFloat)angleForOrientation:(UIInterfaceOrientation)orientation
{	
	switch (orientation)
    {
		case UIDeviceOrientationPortrait:
			return 0;
		case UIDeviceOrientationPortraitUpsideDown:
			return M_PI;
		case UIDeviceOrientationLandscapeLeft:
			return M_PI_2;
		case UIDeviceOrientationLandscapeRight:
			return -M_PI_2;
        default:
        	return 0;
	}
}

- (CGFloat)scaleForOrientation:(UIInterfaceOrientation)orientation
{	
	return UIInterfaceOrientationIsPortrait(orientation)? self.portraitScale: self.landscapeScale;
}

- (void)setOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated
{
    //apply scale and rotation
	CGFloat scale = [self scaleForOrientation:orientation];
	CGFloat angle = [self angleForOrientation:orientation];
	CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformMakeRotation(angle), scale, scale);
	
    //apply offset
    CGPoint offset = (UIInterfaceOrientationIsPortrait(orientation))?
        CGPointMake(self.portraitOffset.x, self.portraitOffset.y):
        CGPointMake(self.landscapeOffset.x, self.landscapeOffset.y);
    if (orientation == UIInterfaceOrientationLandscapeRight ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        offset.x = -offset.x;
        offset.y = -offset.y;
    }
    transform = CGAffineTransformTranslate(transform, offset.x, offset.y);
    
	if (animated)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(redraw)];
	}
	
    //apply transform and offset
	self.transform = transform;
	self.bounds = (UIInterfaceOrientationIsPortrait(orientation))?
		CGRectMake(0, 0, self.portraitSize.width, self.portraitSize.height):
		CGRectMake(0, 0, self.landscapeSize.width, self.landscapeSize.height);
	
	if (animated)
	{
		[UIView commitAnimations];
	}
}

- (void)orientationChange:(NSNotification *)notification
{	
    UIInterfaceOrientation orientation = [self currentOrientation];
    if (!(self.supportedOrientations & (1 << orientation)))
    {
        orientation = self.lastOrientation;
    }
    else if ([self.delegate respondsToSelector:@selector(shouldAutorotateToInterfaceOrientation:)] &&
             ![self.delegate rotateView:self shouldAutorotateToInterfaceOrientation:orientation])
    {
        orientation = self.lastOrientation;
    }
    self.lastOrientation = orientation;
	[self setOrientation:orientation animated:YES];
}

- (void)setUp
{	
	//rotate automatically by default
    _lastOrientation = UIInterfaceOrientationPortrait;
	_supportedOrientations = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?
        UIInterfaceOrientationMaskAll: UIInterfaceOrientationMaskAllButUpsideDown;
	
	//default scaling
	_landscapeScale = 1.0f;
	_portraitScale = 1.0f;
	
	//default sizes
	_portraitSize = self.frame.size;
	_landscapeSize = self.frame.size;
	
	//handle orientation
	[self setOrientation:[self currentOrientation] animated:NO];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(orientationChange:)
												 name:UIDeviceOrientationDidChangeNotification
											   object:nil];
}

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		[self setUp];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{	
	if (self = [super initWithCoder:aDecoder])
	{
		[self setUp];
	}
	return self;
}

- (void)addSubview:(UIView *)view
{
    CGAffineTransform transform = self.transform;
    self.transform = CGAffineTransformIdentity;
    [super addSubview:view];
    self.transform = transform;
}

- (void)dealloc
{	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    
#if !__has_feature(objc_arc)    

	[super dealloc];

#endif
    
}	

@end
