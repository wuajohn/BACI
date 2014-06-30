//  PhotoGallery.m
//  BACI
//
//  Created by Henry Yu on 10-06-19.
//  Copyright 2010 Sevensoft Technology Co., Ltd. All rights reserved.
//

#import "PhotoGallery.h"
#import "PhotoGalleryDelegate.h"
//#import "ThumbsViewController.h"
#import "SlideshowViewController.h"
#import "Constants.h"
#import "BACIAppDelegate.h"

@implementation PhotoGallery

@synthesize firstLoad;
@synthesize savedSeriesId;

- (id)initWithDelegate:(id<PhotoGalleryDelegate>)delegate
{
    
	if (self = [super init])
    {
	    photoGalleryDelegate = [delegate retain];
		videoViewController = nil;
		firstLoad = TRUE;
		savedSeriesId = 0;
		
		//thumbsViewController = [[ThumbsViewController alloc]
		//						   initWithNibName:@"ThumbsViewController" bundle:nil];
		
		//thumbsViewController.view.tag = kTagThumbView;
		//[thumbsViewController setDelegate:self];
		
		
		slideshowVcLINGERIE = [[SlideshowViewController alloc] 
								   initWithNibName:@"SlideshowViewController" bundle:nil];
		slideshowVcEYELASHES = [[SlideshowViewController alloc] 
									initWithNibName:@"SlideshowViewController" bundle:nil];
		slideshowVcCATEGORIES = [[SlideshowViewController alloc] 
									initWithNibName:@"SlideshowViewController" bundle:nil];
        //slideshowVcAboutUs = [[SlideshowViewController alloc] initWithNibName:@"SlideshowViewController" bundle:nil];
				
		[slideshowVcLINGERIE setDelegate:self Type:SLIDESHOW_SERIES];
		[slideshowVcEYELASHES setDelegate:self Type:SLIDESHOW_SERIESDETAILS];
		[slideshowVcCATEGORIES setDelegate:self Type:SLIDESHOW_BIGPICTURE];
        //[slideshowVcAboutUs setDelegate:self Type:SLIDESHOW_ABOUTUS];
        
		slideshowVcLINGERIE.view.tag = kTagSeriesView;
		slideshowVcEYELASHES.view.tag = kTagSeriesDetailView;
		slideshowVcCATEGORIES.view.tag = kTagBigpictureView;		
        //slideshowVcAboutUs.view.tag = kTagAboutUsView;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle
	     = UIStatusBarStyleBlackOpaque;
    self.navigationBar.translucent = YES;
	self.navigationBar.barStyle = UIBarStyleBlack;
    self.toolbar.translucent = NO;
    self.toolbar.barStyle = UIBarStyleBlack;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationBar.translucent = NO;
    self.navigationBar.barStyle = UIBarStyleDefault;
    self.toolbar.translucent = NO;
    self.toolbar.barStyle = UIBarStyleDefault;
}

- (void)dealloc
{
    [slideshowVcLINGERIE release];
	[slideshowVcEYELASHES release];
	[slideshowVcCATEGORIES release];
//    [slideshowVcAboutUs release];
//    [thumbsViewController release];
    [photoGalleryDelegate release];
	if(videoViewController != nil)
		videoViewController = nil;
    [super dealloc];
}


- (BOOL)findViewControllerByTag:(int)tag{
	BOOL found = FALSE;
	
	int i, count = [self.viewControllers count];
	
	for( i = 0; i< count; i++){		
		UIViewController *controller = [self.viewControllers objectAtIndex:i];
		if(controller.view.tag == tag){			
			found = TRUE;
			[controller viewWillAppear:YES];
			[self.view addSubview:controller.view];
			[controller viewDidAppear:NO];
			[self.view bringSubviewToFront:controller.view];
			break;
		}
	}
	return found;
}

#pragma mark public controllers
- (void)showSeries:(int)sId ReLoad:(BOOL)reload{
	int index = sId;
#if	OPTIMAZE_PAGING
	index = index+[slideshowVcLINGERIE getCurrentOffset]*3;
#endif
	
	if(reload){
		NSLog(@"showSeries: reload %d",index);
		index = 0;
	    [self reloadData];
	}		
			
	[slideshowVcLINGERIE showPhotoAtIndex:index];
	BOOL found = [self findViewControllerByTag:kTagSeriesView];//调用要显示的画面
	if(!found){
		[self pushViewController:slideshowVcLINGERIE animated:YES];
	}
	
}

- (void)showSeriesDetailView:(int)index fromType:(int)t{
		
	BACIAppDelegate* appDelegate =
	    (BACIAppDelegate*)[[UIApplication sharedApplication] delegate];
	BOOL showFirst = FALSE;	
	int iIndex = index;
	if(t == kTagThumbView){	
		//
	}else if(t == kTagBigpictureView){	
		iIndex = appDelegate.savedSeriesDetailIndex;
		NSLog(@"showSeriesDetailView,from big back,savedSeriesId:%d",iIndex);
		if(iIndex < 3){
			iIndex = 0;
			showFirst = TRUE;
		}		
	}else if(t == kTagSeriesView){
		iIndex = 0;
		appDelegate.currentSeries = index;
		
		slideshowVcEYELASHES.sereisNameIndex = index;
		
		if(savedSeriesId != index||firstLoad){
			showFirst = TRUE;
			if(firstLoad){			
				firstLoad = FALSE;
			}
			NSLog(@"＊＊＊showSeriesDetailView:%d reloadData",index);
			[slideshowVcEYELASHES reloadData];
			[slideshowVcCATEGORIES reloadData];
//			[thumbsViewController reloadData];
		}
		savedSeriesId = index;
	}	
	
	[slideshowVcEYELASHES showPhotoAtIndex:iIndex];
	BOOL found = [self findViewControllerByTag:kTagSeriesDetailView];
	if(!found){
		
		[self pushViewController:slideshowVcEYELASHES animated:YES];
		[self.view bringSubviewToFront:slideshowVcEYELASHES.view];
	}
	
	[slideshowVcEYELASHES adjustLastPageFromBigView:iIndex];
	
	if(showFirst){
		[slideshowVcEYELASHES showFirstPage];
	}
		
}

- (void)showBigPicture:(int)index fromType:(int)t
{
	slideshowVcCATEGORIES.fromBigType = t;	
	#if	OPTIMAZE_PAGING
		if(t == kTagSeriesDetailView||t == kTagThumbView){
			NSLog(@"PhotoGallery,showBigPicture:%d",index);
			[slideshowVcCATEGORIES reloadData2:index];		
		}
    #else
	   [slideshowVcCATEGORIES showPhotoAtIndex:index];
    #endif	
	BOOL found = [self findViewControllerByTag:kTagBigpictureView];
	if(!found){
      [self pushViewController:slideshowVcCATEGORIES animated:YES];
	}
}

- (void)showThumbView:(int)index{
	
	BOOL found = [self findViewControllerByTag:kTagThumbView];
	if(!found){
//        [self pushViewController:thumbsViewController animated:YES];
//		[self.view bringSubviewToFront:thumbsViewController.view];
	}
}

#pragma mark Public

- (void)reloadData
{
	
	savedSeriesId = 0;
//	[thumbsViewController reloadData];
    [slideshowVcLINGERIE reloadData];
	[slideshowVcEYELASHES reloadData];
	[slideshowVcCATEGORIES reloadData];
//    [slideshowVcAboutUs reloadData];
}

- (void)resetAllViews{
//	[thumbsViewController resetAllViews];
    [slideshowVcLINGERIE resetAllViews];
	[slideshowVcEYELASHES resetAllViews];
	[slideshowVcCATEGORIES resetAllViews];
//    [slideshowVcAboutUs resetAllViews];
}

- (void)fetchedPhotoThumb:(UIImage *)photo atIndex:(int)index
{
//    [thumbsViewController fetchedPhoto:photo atIndex:index];
}

- (void)fetchedBigThumb:(UIImage *)photo atIndex:(int)index atPage:(int)page type:(int)t{
	[slideshowVcCATEGORIES fetchedBigThumb:photo atIndex:index atPage:page type:t];	
}

- (void)fetchedPhotoLINGERIE:(UIImage *)photo atIndex:(int)index atPage:(int)page Location:(NSString *)location
{
    [slideshowVcLINGERIE fetchedPhoto:photo atIndex:index atPage:page Location:location];
}

- (void)fetchedPhotoEYELASHES:(UIImage *)photo atIndex:(int)index atPage:(int)page Location:(NSString *)location
{
 	[slideshowVcEYELASHES fetchedPhoto:photo atIndex:index atPage:page Location:location];
}

- (void)fetchedPhotoCATEGORIES:(UIImage *)photo atIndex:(int)index atPage:(int)page Location:(NSString *)location
{
 	[slideshowVcCATEGORIES fetchedPhoto:photo atIndex:index atPage:page Location:location];
}

#pragma mark ThumbsViewControllerDelegate

//- (int)thumbsViewControllerPhotosCount:(ThumbsViewController *)tvc
//{
//    return [photoGalleryDelegate photoGalleryPhotosCount:self ControllerType:SLIDESHOW_THUMBS];
//}
//
//- (void)thumbsViewController:(ThumbsViewController *)tvc
//    fetchPhotoAtIndex:(int)index Location:(NSString *)location
//{
//    [photoGalleryDelegate photoGallery:self fetchPhotoThumbAtIndex:index Location:location];
//}
//
//- (void)thumbsViewController:(ThumbsViewController *)tvc
//    selectedPhotoAtIndex:(int)index
//{
//	
//#if THUM_TO_DETAIL	
//	[slideshowViewController2 showPhotoAtIndex:index];
//	[self showSeriesDetailView:index fromType:kTagThumbView];
//#endif	
//	
//	[self showBigPicture:index fromType:kTagThumbView];
//	
//}

#pragma mark SlideshowViewControllerDelegate
- (int)slideshowViewControllerPhotosCount:(SlideshowViewController *)svc ControllerType:(int)t
{
    return [photoGalleryDelegate photoGalleryPhotosCount:self ControllerType:t];
	
}

- (void)slideshowViewController:(SlideshowViewController *)svc
    fetchPhotoAtIndex:(int)index Location:(NSString *)location Type:(int)t Page:(int)p
{
    [photoGalleryDelegate photoGallery:self fetchPhotoAtIndex:index Location:location Type:t Page:p];
}

@end
