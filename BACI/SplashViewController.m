//
//  SplashViewController.m
//  BACI
//
//  Created by Henry Yu on 10-06-19.
//  Copyright 2010 Sevensoft Technology Co., Ltd. All rights reserved.
//

#import "SplashViewController.h"
#import "Constants.h"
#import "BACIAppDelegate.h"
#import "PhotoGallery.h"

@implementation SplashViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
        return nil;
    adjustToolbar = 0;
    self.title = @"B.A.C.I";
    
	return self;
}

- (void)viewDidUnload
{
	
}

- (void)dealloc
{
	
	[super dealloc];
}

- (void)loadView {
	[super loadView];
	
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    

	int screenWidth =  1024;
	int screenHeight =  768;
	
	UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1024x768.jpg" ofType:nil]];
	
	self.imageView.image = image;
	CGRect mainframe = CGRectMake(0, 0, screenWidth, screenHeight-64);
	self.imageView.frame = mainframe;
  

}

@end
