//
//  UIImageView+URL.m
//  Postadvert
//
//  Created by Ray on 8/8/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "UIImageView+URL.h"
#import "SDWebImageManager.h"
@implementation UIImageView (URL)
- (void)setImageWithURL:(NSURL *)url {
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];
    
    UIImage *cachedImage = nil;
    if (url) {
        cachedImage = [manager imageWithURL:url];
    }
    
    if (cachedImage) {
        [self setImage:cachedImage];
    }
    else {
        if (placeholder) {
            [self setImage:placeholder];
        }
        
        if (url) {
            [manager downloadWithURL:url delegate:self];
        }
    }
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image {
    [self setImage:image];
}
@end
