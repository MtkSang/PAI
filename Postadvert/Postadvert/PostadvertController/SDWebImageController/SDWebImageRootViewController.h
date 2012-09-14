//
//  SDWebImageRootViewController.h
//  Sample
//
//  Created by Kirby Turner on 3/18/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTThumbsViewController.h"

@class SDWebImageDataSource;

@interface SDWebImageRootViewController : KTThumbsViewController 
{
@private
   SDWebImageDataSource *images_;
   UIActivityIndicatorView *activityIndicatorView_;
   UIWindow *window_;
}
@property (nonatomic, assign) UINavigationController *navigationController;
- (id) initWithFrame:(CGRect) frame;
- (id) initWithFrame:(CGRect) frame andArray:(NSArray*) array;
- (void) setLinkImagesData:(NSArray*) array;
- (void) LoadThumbnail;
@end
