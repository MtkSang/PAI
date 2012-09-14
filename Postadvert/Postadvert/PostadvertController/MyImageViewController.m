//
//  MyImageViewController.m
//  Postadvert
//
//  Created by Mtk Ray on 6/1/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "MyImageViewController.h"
#import "UIImage+Resize.h"
#import "UIImageView+URL.h"
#define ZOOM_STEP 1.9


@interface MyImageViewController ()
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;
@end

@implementation MyImageViewController
@synthesize imageView = _imageView;
@synthesize imageScrollView;
@synthesize isZooming = _isZooming;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        sourceType = MyImageViewControllerSourceTypeNormal;
    }
    return self;
}

- (id)initWithImage:(UIImage*)_image{
    self = [self initWithNibName:@"MyImageViewController" bundle:nil];
    image = [_image resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:[[UIScreen mainScreen]bounds].size interpolationQuality:0];
    sourceType = MyImageViewControllerSourceTypeImage;
    return self;
}

- (id)initWithURL:(NSString *)_url
{
    self = [self initWithNibName:@"MyImageViewController" bundle:nil];
    url = _url;
    sourceType = MyImageViewControllerSourceTypeUrl;
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    //[self.view setAutoresizesSubviews:YES];
    // Do any additional setup after loading the view from its nib.
    switch (sourceType) {
        case MyImageViewControllerSourceTypeImage:
            
            break;
        case MyImageViewControllerSourceTypeUrl:
        {
            [_imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"photoDefault.png"]];
            
        }
            break;
            
        default:
            break;
    }
    _imageView.multipleTouchEnabled = YES;
    _imageView.userInteractionEnabled = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;

    
    imageScrollView.bouncesZoom = YES;
    imageScrollView.delegate = self;
    imageScrollView.clipsToBounds = YES;
    imageScrollView.contentSize = [_imageView frame].size;
    imageScrollView.minimumZoomScale = 1.0;
    imageScrollView.maximumZoomScale = 2.2;
    
        
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    
    [doubleTap setNumberOfTapsRequired:2];
    [twoFingerTap setNumberOfTouchesRequired:2];
    
    [_imageView addGestureRecognizer:singleTap];
    [_imageView addGestureRecognizer:doubleTap];
    [_imageView addGestureRecognizer:twoFingerTap];
    
    singleTap = nil;
    doubleTap = nil;
    twoFingerTap = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    return YES;
}

#pragma mark UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void) scrollViewDidZoom:(UIScrollView *)scrollView 
{
    float newScale = [imageScrollView zoomScale] / ZOOM_STEP;
    if (newScale == 1.0) {
        _isZooming = NO;
    }
    else {
        _isZooming = YES;
    }

}


#pragma mark TapDetectingImageViewDelegate methods

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    // single tap does nothing for now
    NSLog(@"Single Tap");
    isDoubleTap = NO;
    [self performSelector:@selector(singleTapImageView) withObject:nil afterDelay:0.35];
    
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    // zoom in
    isDoubleTap = YES;
        NSLog(@"Double Tap");
    if (! _isZooming) {
        float newScale = [imageScrollView zoomScale] * ZOOM_STEP;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        [imageScrollView zoomToRect:zoomRect animated:YES];
        _isZooming = YES;
    }else {
        float newScale = 1.0;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        [imageScrollView zoomToRect:zoomRect animated:YES];
        _isZooming = NO;
}
}

- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
    // two-finger tap zooms out
        NSLog(@"Pinch Tap");
    float newScale = [imageScrollView zoomScale] / ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    if (newScale == 1.0) {
        _isZooming = NO;
    }
    else {
        _isZooming = YES;
    }
    [imageScrollView zoomToRect:zoomRect animated:YES];
}

#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates. 
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [imageScrollView frame].size.height / scale;
    zoomRect.size.width  = [imageScrollView frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

#pragma mark - Implement

- (void) singleTapImageView
{
    if (isDoubleTap) {
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"singleTapImageView" object:nil];
}

- (void) normalSize
{
    CGRect zoomRect = [self zoomRectForScale:1.0 withCenter:self.view.center];
    [imageScrollView zoomToRect:zoomRect animated:YES];
    _isZooming = NO;
}
@end
