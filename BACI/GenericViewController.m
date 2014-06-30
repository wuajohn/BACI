//
//  SplashViewController.m
//  BACI
//
//  Created by Henry Yu on 10-06-19.
//  Copyright 2010 Sevensoft Technology Co., Ltd. All rights reserved.
//

#import "GenericViewController.h"
#import "Constants.h"
#import "BACIAppDelegate.h"
#import "PhotoGallery.h"
#import "AboutUsViewController.h"

@implementation GenericViewController

@synthesize imageView = _imageView;
@synthesize adjustToolbar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
        return nil;
    adjustToolbar = 0;
    self.title = @"B.A.C.I";
    
	return self;
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
  
	[self createBottomBar];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewDidLoad
{	
	BACIAppDelegate* appDelegate =
    (BACIAppDelegate*)[[UIApplication sharedApplication] delegate];
	PhotoGallery* appNavgitor = [appDelegate getPhotoGallery];
    [appNavgitor setNavigationBarHidden:YES animated:YES];
}

- (void)createBottomBar{
	int fontSize = 16;
	int screenWidth = 1024;
	
	int positionY = 768-64;
	if(adjustToolbar){
		CGRect mainframe = CGRectMake(0, 20, 1024, 768);
		self.view.frame = mainframe;
		
	}
	toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, positionY, screenWidth, 44)];
	BACIAppDelegate* appDelegate =(BACIAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    //LINGERIE
	NSString *langLINGERIE = [appDelegate getLocalTextString:@"LINGERIE"];
    
	CGRect buttonFrame = CGRectMake( 0, 0, [appDelegate textWidthByFontSize:langLINGERIE FontSize:fontSize], 30 );
	UIButton *langLabel1 = [[UIButton alloc] initWithFrame: buttonFrame];
	
	[langLabel1 setTitle: langLINGERIE forState: UIControlStateNormal];
	[langLabel1 setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
	
	[langLabel1 setTitleColor: RGB(96, 189, 242) forState:UIControlStateSelected];
    
	langLabel1.titleLabel.adjustsFontSizeToFitWidth = TRUE;
	[langLabel1 setShowsTouchWhenHighlighted:YES];
	langLabel1.titleLabel.font = [UIFont fontWithName:@"Arial" size: fontSize];
	[langLabel1 addTarget:self action:@selector(goLINGERIE:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *buttonItem1 = [[UIBarButtonItem alloc] initWithCustomView:langLabel1];
    
    //EYELASHES
	NSString *langEYELASHES = [appDelegate getLocalTextString:@"EYELASHES"];
	
	buttonFrame = CGRectMake( 0, 0, [appDelegate textWidthByFontSize:langEYELASHES FontSize:fontSize], 30 );
	UIButton *langLabel2 = [[UIButton alloc] initWithFrame: buttonFrame];
	[langLabel2 setTitle: langEYELASHES forState: UIControlStateNormal];
	[langLabel2 setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
	[langLabel2 setTitleColor: RGB(96, 189, 242) forState:UIControlStateSelected];
	
	langLabel2.titleLabel.adjustsFontSizeToFitWidth = YES;
	[langLabel2 setShowsTouchWhenHighlighted:YES];
	langLabel2.titleLabel.font = [UIFont fontWithName:@"Arial" size: fontSize];
	[langLabel2 addTarget:self action:@selector(goEYELASHES:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *buttonItem2 = [[UIBarButtonItem alloc] initWithCustomView:langLabel2];
    
    //CATEGORIES
	NSString *langCATEGORIES = [appDelegate getLocalTextString:@"CATEGORIES"];
	buttonFrame = CGRectMake( 0, 0, [appDelegate textWidthByFontSize:langCATEGORIES FontSize:fontSize], 30 );
	UIButton *langLabel3 = [[UIButton alloc] initWithFrame: buttonFrame];
	[langLabel3 setTitle: langCATEGORIES forState: UIControlStateNormal];
	[langLabel3 setShowsTouchWhenHighlighted:YES];
	langLabel3.titleLabel.adjustsFontSizeToFitWidth = YES;
	[langLabel3 setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
	[langLabel3 setTitleColor: RGB(96, 189, 242) forState:UIControlStateSelected];
	
	langLabel3.titleLabel.font = [UIFont fontWithName:@"Arial" size: fontSize];
	[langLabel3 addTarget:self action:@selector(goCATEGORIES:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *buttonItem3 = [[UIBarButtonItem alloc] initWithCustomView:langLabel3];

	
    //ABout us
	NSString *langABOUTUS = [appDelegate getLocalTextString:@"ABOUT US"];
	buttonFrame = CGRectMake( 0, 0, [appDelegate textWidthByFontSize:langABOUTUS FontSize:fontSize], 30 );
	UIButton *langLabel4 = [[UIButton alloc] initWithFrame: buttonFrame];
	[langLabel4 setTitle: langABOUTUS forState: UIControlStateNormal];
	[langLabel4 setShowsTouchWhenHighlighted:YES];
	langLabel4.titleLabel.adjustsFontSizeToFitWidth = YES;
	[langLabel4 setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
	[langLabel4 setTitleColor: RGB(96, 189, 242) forState:UIControlStateSelected];
	
	langLabel4.titleLabel.font = [UIFont fontWithName:@"Arial" size: fontSize];
	[langLabel4 addTarget:self action:@selector(goABOUTUS:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *buttonItem4 = [[UIBarButtonItem alloc] initWithCustomView:langLabel4];
    
    
    //LANGUAGE
	NSString *langLANGUAGE = [appDelegate getLocalTextString:@"LANGUAGE"];
	buttonFrame = CGRectMake( 0, 0, [appDelegate textWidthByFontSize:langLANGUAGE FontSize:fontSize], 30 );
	UIButton *langLabel5 = [[UIButton alloc] initWithFrame: buttonFrame];
	
	[langLabel5 setTitle: langLANGUAGE forState: UIControlStateNormal];
	[langLabel5 setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
	
	[langLabel5 setTitleColor: RGB(96, 189, 242) forState:UIControlStateSelected];
	[langLabel5 setShowsTouchWhenHighlighted:YES];
	langLabel5.titleLabel.adjustsFontSizeToFitWidth = YES;
	langLabel5.titleLabel.font = [UIFont fontWithName:@"Arial" size: fontSize];
	[langLabel5 addTarget:self action:@selector(goLanguage:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *buttonItem5 = [[UIBarButtonItem alloc] initWithCustomView:langLabel5];
	
    
    
	UIBarButtonItem *leftSpace = [[[UIBarButtonItem alloc]
								  initWithBarButtonSystemItem:
								  UIBarButtonSystemItemFlexibleSpace
								  target:nil action:nil]autorelease];
	UIBarButtonItem *rightSpace = [[[UIBarButtonItem alloc]
								   initWithBarButtonSystemItem:
								   UIBarButtonSystemItemFlexibleSpace
								   target:nil action:nil]autorelease];
	
	NSArray *newItems = [NSArray arrayWithObjects:leftSpace,
						 buttonItem1,buttonItem2,buttonItem3,buttonItem4,buttonItem5,
                         rightSpace,nil];
	[toolbar setItems:newItems];
	[langLabel1 release];
	[langLabel2 release];
	[langLabel3 release];
	[langLabel4 release];
	[langLabel5 release];
    
	[buttonItem1 release];
	[buttonItem2 release];
	[buttonItem3 release];
	[buttonItem4 release];
	[buttonItem5 release];
    
	toolbar.translucent = NO;
    toolbar.barStyle = UIBarStyleBlack;
    [self.view addSubview:toolbar];
	[self.view bringSubviewToFront:toolbar];
    
}


-(void)resetAllViews{
	BACIAppDelegate* appDelegate = (BACIAppDelegate*)[[UIApplication sharedApplication] delegate];
    
	PhotoGallery* appNavgitor = [appDelegate getPhotoGallery];
	int i, count = [appNavgitor.viewControllers count];
	for( i = 0; i< count; i++){
		UIViewController* controller = [appNavgitor.viewControllers objectAtIndex:i];
		
		if(controller.view.tag == kTagSeriesView ||
		   controller.view.tag == kTagSeriesDetailView||
		   controller.view.tag == kTagBigpictureView||
		   controller.view.tag == kTagThumbView||
           controller.view.tag == kTagAboutUsView
           ){
			
			[controller viewWillDisappear:NO];
			[controller.view removeFromSuperview];
			[controller viewDidDisappear:NO];
		}
	}
}


-(IBAction)goLINGERIE:(id)sender{
	NSLog(@"goLINGERIE");
	
	UIButton *langLabel = (UIButton *)[[toolbar.items objectAtIndex:1] customView];
	[langLabel setSelected:YES];
    
    
	BACIAppDelegate* appDelegate = (BACIAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[self resetAllViews];
	[appDelegate showSeriesView:LINGERIE];
	
}

-(IBAction)goEYELASHES:(id)sender{
    
	UIButton *langLabel = (UIButton *)[[toolbar.items objectAtIndex:2] customView];
	[langLabel setSelected:YES];
	
	BACIAppDelegate* appDelegate = (BACIAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[self resetAllViews];
	[appDelegate showSeriesView:EYELASHES];	
}

-(IBAction)goCATEGORIES:(id)sender{	
	UIButton *langLabel = (UIButton *)[[toolbar.items objectAtIndex:3] customView];
	[langLabel setSelected:YES];
    
	BACIAppDelegate* appDelegate = (BACIAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	[self resetAllViews];
	[appDelegate showSeriesView:CATEGORIES];	
}

-(IBAction)goABOUTUS:(id)sender{
	
    for (int i=0; i<5; ++i) {
        UIButton *btn = (UIButton *)[[toolbar.items objectAtIndex:i] customView];
        [btn setSelected:NO];
    }
    
    UIButton *langLabel = (UIButton *)[[toolbar.items objectAtIndex:4] customView];    
	[langLabel setSelected:YES];
    
//
//	BACIAppDelegate* appDelegate = (BACIAppDelegate*)[[UIApplication sharedApplication] delegate];
//	
//	[self resetAllViews];
//    [appDelegate showSeriesView:ABOUTUS];
//    [appDelegate showAboutUsView];
    
    //进入关于界面
    AboutUsViewController *aboutUsViewController = [[[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil]autorelease];
    aboutUsViewController.title = @"公司简介";
    
    UINavigationController *navigation = [[[UINavigationController alloc] initWithRootViewController:aboutUsViewController]autorelease];
    UIPopoverController* popoverController = [[UIPopoverController alloc] initWithContentViewController:navigation];
    
    popoverController.popoverContentSize = CGSizeMake(320,420);
    CGRect rect = CGRectMake(645, 685, 0 , 0);//langLabel.bounds;
    
    //弹出关于界面
    //中心点是用来画箭头的，如果中心点如果出了屏幕，系统会优化到窗口边缘
    [popoverController presentPopoverFromRect:rect         
                                             inView:self.view
                           permittedArrowDirections:UIPopoverArrowDirectionDown   //箭头方向
                                           animated:YES];
}

-(IBAction)goLanguage:(id)sender{
	
	UIButton *langLabel = (UIButton *)[[toolbar.items objectAtIndex:5] customView];
	[langLabel setSelected:YES];
	
	BOOL popViews = FALSE;
	BACIAppDelegate* appDelegate =
	(BACIAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	
	popViews = TRUE;
	if(popViews){
        
		PhotoGallery* appNavgitor = [appDelegate getPhotoGallery];
		int i, count = [appNavgitor.viewControllers count];
		for( i = 0; i< count; i++){
			UIViewController* controller = [appNavgitor.viewControllers objectAtIndex:i];
            
			if(controller.view.tag == kTagSeriesView ||
			   controller.view.tag == kTagSeriesDetailView||
			   controller.view.tag == kTagBigpictureView||
			   controller.view.tag == kTagThumbView||
			   controller.view.tag == kTagMainmenuView||
			   controller.view.tag == kTagLanguageView||
               controller.view.tag == kTagAboutUsView){
				
			    [controller viewWillDisappear:NO];
			    [controller.view removeFromSuperview];
			    [controller viewDidDisappear:NO];
			}
		}
		
		[appDelegate showLanguageView];
	}
}



#pragma mark -
#pragma mark Orientation
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval) duration
{
	//only handle the interface orientation of portrait mode
	if(interfaceOrientation == UIInterfaceOrientationPortrait ||
	   interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		//adjust master view
		
		[self setupPortraitMode];
	}else {
		//re-adjust detail view
		//call super method
		[super willAnimateRotationToInterfaceOrientation:interfaceOrientation
												duration:duration];
		
	}
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
	
}


- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
	[self adjustViewsForOrientation:toInterfaceOrientation];
}

- (void) adjustViewsForOrientation:(UIInterfaceOrientation)orientation {
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        
        //Do Your Landscape Changes here
		[self setupPortraitMode];
    }
    else if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        //Do Your Portrait Changes here
    }
}

// Thanks to http://intensedebate.com/profiles/fgrios for this code snippet
- (void)setupPortraitMode
{
	//adjust master view
	CGRect mainframe = CGRectMake(0, 0, 1024, 768);
	self.view.frame = mainframe;
	
}

@end
