//  PhotoGallery.h
//  BACI
//
//  Created by Henry Yu on 10-06-19.
//  Copyright 2010 Sevensoft Technology Co., Ltd. All rights reserved.
//

//#import "ThumbsViewControllerDelegate.h"
#import "SlideshowViewControllerDelegate.h"
#import "VideoPlayViewController.h"

@protocol PhotoGalleryDelegate;
//@class ThumbsViewController;
@class SlideshowViewController;

@interface PhotoGallery : UINavigationController<SlideshowViewControllerDelegate>
    //<ThumbsViewControllerDelegate, SlideshowViewControllerDelegate>
{
    id<PhotoGalleryDelegate> photoGalleryDelegate;
	VideoPlayViewController* videoViewController;
    //ThumbsViewController *thumbsViewController;
    SlideshowViewController *slideshowVcLINGERIE;
	SlideshowViewController *slideshowVcEYELASHES;
	SlideshowViewController *slideshowVcCATEGORIES;
    //SlideshowViewController *slideshowVcAboutUs;
	int savedSeriesId;
	BOOL firstLoad;
}

@property BOOL firstLoad;
@property int savedSeriesId;

- (id)initWithDelegate:(id<PhotoGalleryDelegate>)delegate;
- (BOOL)findViewControllerByTag:(int)tag;
- (void)reloadData;
- (void)resetAllViews;
- (void)fetchedPhotoThumb:(UIImage *)photo atIndex:(int)index;
- (void)fetchedPhotoLINGERIE:(UIImage *)photo atIndex:(int)index atPage:(int)page Location:(NSString *)location;
- (void)fetchedPhotoEYELASHES:(UIImage *)photo atIndex:(int)index atPage:(int)page Location:(NSString *)location;
- (void)fetchedPhotoCATEGORIES:(UIImage *)photo atIndex:(int)index atPage:(int)page Location:(NSString *)location;
- (void)fetchedBigThumb:(UIImage *)photo atIndex:(int)index atPage:(int)page type:(int)t;

- (void)showSeries:(int)index ReLoad:(BOOL)reload;
- (void)showSeriesDetailView:(int)index fromType:(int)t;
- (void)showBigPicture:(int)index fromType:(int)t;
- (void)showThumbView:(int)index;


@end
