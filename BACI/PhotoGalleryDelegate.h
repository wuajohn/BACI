//
//  IPhotoGalleryDelegate.h
//  BACI
//
//  Created by Henry Yu on 10-06-19.
//  Copyright 2010 Sevensoft Technology Co., Ltd. All rights reserved.
//

@class PhotoGallery;

@protocol PhotoGalleryDelegate <NSObject>

- (int)photoGalleryPhotosCount:(PhotoGallery *)photoGallery ControllerType:(int)t;
- (void)photoGallery:(PhotoGallery *)photoGallery
    fetchPhotoThumbAtIndex:(int)index Location:(NSString *)location;
- (void)photoGallery:(PhotoGallery *)photoGallery
    fetchPhotoAtIndex:(int)index Location:(NSString *)location Type:(int)t Page:(int)p;

@end

