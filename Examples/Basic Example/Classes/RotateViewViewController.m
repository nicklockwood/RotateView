//
//  RotateViewViewController.m
//  RotateView
//
//  Created by Nick Lockwood on 03/02/2011.
//  Copyright 2011 AKQA. All rights reserved.
//

#import "RotateViewViewController.h"

@implementation RotateViewViewController

@synthesize scalingView;

- (void)viewDidLoad
{
	//set scaling factor for scaling view
	scalingView.landscapeScale = 1.5;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	//don't allow view to rotate at the root level
	return NO;
}


@end
