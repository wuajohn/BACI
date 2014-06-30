//
//  AppDelegate.h
//  BACI
//
//  Created by wuajohn on 14-5-18.
//  Copyright (c) 2014年 wuajohn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PhotoGallery.h"
#import "PhotoGalleryDelegate.h"

#import "LanguageViewController.h"
#import "SplashViewController.h"
#import "AboutUsViewController.h"

#import "SDImageCache.h"
#import "SDWebImageManager.h"

@interface BACIAppDelegate : UIResponder <UIApplicationDelegate,PhotoGalleryDelegate>
{    
    NSDictionary *defaultsDict;
	NSDictionary *localStringDict;
    
    NSString *baseDirectory;
	NSString *baseURLDirectory;
    NSString *fixPath;
    
    PhotoGallery *photoGallery;//导航控制器
    
    LanguageViewController *languageViewController;    
    SplashViewController *splashViewController;
//    AboutUsViewController *aboutUsViewController;

	//BOOL adjustToolBar;
	BOOL adjustToolBar2;
	BOOL firstSeriesDetail;
	BOOL firstThumbsView;
	BOOL firstSearch;
    SDWebImageManager *sDWebImageManager;
    SDImageCache *sDImageCache;
}

@property (strong, nonatomic) UIWindow *window;

@property int mainMenu;
@property int currentSeries;
@property int savedSeriesDetailIndex;
@property int savedCurrentSeriesId;
@property (strong, nonatomic) NSString *currentLanguage;

@property BOOL adjustToolBar;
@property BOOL isInitToolBar;
@property (strong, nonatomic) NSString *baseDirectory;

- (PhotoGallery *)getPhotoGallery;
- (void)showLanguageView;
- (void)showMainmenuView;
- (void)showThumbs:(int)index;
- (void)showSeriesView:(int)index;
- (void)showSeriesDetailView:(int)index fromType:(int)t;
- (NSString *)getInfoTextbyIndex:(int)index;
- (void)showBigPictureView:(int)index fromType:(int)t;
- (NSArray *)getCurrentSeriesIds;
- (int)getCurrentSeriesStartId:(int)s;
- (NSString*)getCurrentSeriesDirectory;
- (NSString *)getSeriesName:(int)menu;
- (UIColor *)getColorByIndex:(int)index;
- (NSString *)getSeriesNameByIndex:(int)index;
- (NSString *)getBigPictureNamebyIndex:(int)index Selection:(BOOL)back;
- (NSString *)getMovieNamebyIndex:(int)index;
- (UIImage *)getMovieThumbImage:(int)index;
- (void)asyncPhotoRequestSucceeded:(NSData *)data
						  userInfo:(NSDictionary *)userInfo;
- (void)asyncPhotoRequestFailed:(NSError *)error
					   userInfo:(NSDictionary *)userInfo;
- (void)doSearch:(NSString*)text;
- (BOOL)doSearchHelper:(int)mainMenuId itemId:(int)item;

- (void)parseConfiguration;
- (BOOL)checkLimit:(NSString *)str;
- (UIImage *)getLocalImageAtIndex:(int)index Location:(NSString *)location;
- (void)getMovieThumbImage2:(int)index Page:(int)p;
- (UIImage *)getRemoteImageAtIndex:(int)index Location:(NSString *)location Type:(NSString *)t Page:(int)p;
- (void)fetchLocalPhotoAtIndex:(int)index Location:(NSString *)location Type:(int)t Page:(int)p;
- (void)messageBox:(NSString*)msg;
- (NSString *)getLocalTextString:(NSString *)text;
- (CGFloat)textWidthByFontSize:(NSString *)text FontSize:(int)fontSize;
- (NSString *)getBaseUrlIPAddress;
@end
