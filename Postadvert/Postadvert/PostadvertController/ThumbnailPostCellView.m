//
//  ThumbnailPostCellView.m
//  Postadvert
//
//  Created by Mtk Ray on 7/18/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "ThumbnailPostCellView.h"
#import "PostCellContent.h"
#import "Constants.h"
#import "EnlargeImageViewControllerV2.h"
#import "UIImage+Resize.h"
@implementation ThumbnailPostCellView

@synthesize navigationController = _navigationController;
@synthesize content = _content;
- (id)init
{
    self = [super init];
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - implement

- (UIView*) CreateImagesViewWithFrame:(CGRect)mainFrame
{
    mainFrame.size.width = (cImageWidth + CELL_MARGIN_BETWEEN_IMAGE) * _content.listImages.count;
    self.frame = mainFrame;
    self.userInteractionEnabled = YES;
    CGRect frame = CGRectMake(0.0, CELL_MARGIN_BETWEEN_IMAGE, cImageWidth, cImageHeight);
    NSInteger tag = 0;
    for (UIImage *image in self.content.listImages) {
        tag += 1;// = index -1;
        [self addSubview:[self imageViewFromImage:image withFrame:frame tag:tag]];
        frame.origin.x += cImageWidth + CELL_MARGIN_BETWEEN_IMAGE;
    }
    [self addGestureRecognizer: [self addPanGesture:self]];
    return self;
}
-(UIImageView*) imageViewFromImage:(UIImage*)image withFrame:(CGRect)frame tag:(NSInteger) tag
{
    image = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(cImageWidth, cImageHeight) interpolationQuality:4];

    UIImageView *myImageView = [[UIImageView alloc]initWithImage:image];
    myImageView.frame = frame;
    myImageView.userInteractionEnabled =YES;
    myImageView.contentMode = UIViewContentModeScaleAspectFit;
    // Add tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findOutTheTag:)];
    myImageView.tag = tag;
    NSLog(@"UIImage Tag %d", tag);
    [myImageView addGestureRecognizer:tap];
    return myImageView;
}
- (UIImage *)normalizedImage:(UIImage*)image {
    if (image == nil) {
        return nil;
    }
    if (image.imageOrientation == UIImageOrientationUp) return image; 
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    image = nil;
    return normalizedImage;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIView *view = [gestureRecognizer view];
        CGPoint translation = [(UIPanGestureRecognizer*)gestureRecognizer translationInView:[view superview]];
        // Check for horizontal gesture
        if (fabsf(translation.x) > fabsf(translation.y))
        {
            return YES;
        }
        return NO;
    }
    return NO;
}

- (UIPanGestureRecognizer*) addPanGesture:(id) target
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]init];
    panGesture.delegate = self;
    [panGesture addTarget:target action:@selector(handlePanGesture:)];
    return panGesture;
}

- (void) handlePanGesture:(UIPanGestureRecognizer *)gesture
{
    if (![gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
        return;
    }
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            startPointOfView = gesture.view.frame.origin;
            previousPoint = [gesture translationInView:gesture.view.superview];
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentPoint = [gesture translationInView:gesture.view.superview];
            float moveX = currentPoint.x - previousPoint.x;
            //Update Point
            previousPoint = currentPoint;
            NSNumber *num = [NSNumber numberWithFloat:moveX];
            [[NSUserDefaults standardUserDefaults] setObject:num forKey:@"PointX"];
            //Move view
            CGRect frame = gesture.view.frame;
            [UIView setAnimationDuration:0.0];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
            [UIView beginAnimations:@"ThumbnailPostCellView" context:(__bridge void *)self];
            frame.origin.x += moveX;
            gesture.view.frame = frame;
            [UIView commitAnimations];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint velocity = [gesture velocityInView:self];
            CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
            
           
                      
            CGRect frame = gesture.view.frame;
            float width = 320;
            if (gesture.view.superview) {
                width = gesture.view.superview.frame.size.width;
            }
             NSLog(@" X:%f,frame W :%f, W%f, magnitue:%f", frame.origin.x, frame.size.width ,width, magnitude);
            if (magnitude > cMinSpeedPermitThumbnail) {
                float direction = [(NSNumber*)[[NSUserDefaults standardUserDefaults] objectForKey:@"PointX"] floatValue];
                if (direction > 0) {
                    frame.origin.x = startPointOfView.x + width + 10;
                                         NSLog(@" Swipe Right" );
                }else {
                    frame.origin.x = startPointOfView.x - width - 10;
                     NSLog(@" Swipe Left" );
                }
            }  
            
            [UIView setAnimationDuration:0.8];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
            [UIView beginAnimations:@"ThumbnailPostCellView" context:(__bridge void *)self];
            if (frame.origin.x >= CELL_CONTENT_MARGIN_LEFT) {
                frame.origin.x = CELL_CONTENT_MARGIN_LEFT;
            }else {
                
                if (frame.size.width < width) {
                    frame.origin.x = 0;
                }else {
                    if (frame.origin.x + frame.size.width  < width) {
                        frame.origin.x = width - frame.size.width;
                    }
                }
            }
            gesture.view.frame = frame;
            [UIView commitAnimations];
           
        }
            break;
            
        default:
            break;
    }
}

- (UIGestureRecognizer*) addSwipeGesture:(id)target
{
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]init];
    swipeGesture.delegate = self;
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight];
    [swipeGesture addTarget:target action:@selector(handleSwipeGesture:)];
    return swipeGesture;
}

- (void) handleSwipeGesture:(UISwipeGestureRecognizer *)gesture
{
    if (!gesture.state == UIGestureRecognizerStateEnded) {
        return;
    }
    if (![gesture isKindOfClass:[UISwipeGestureRecognizer class]]) {
        return;
    }

    NSLog(@" %f %f ", gesture.view.frame.origin.x, gesture.view.frame.size.width );
}


- (void)findOutTheTag:(id)sender {
    NSInteger tag = ((UIGestureRecognizer *)sender).view.tag;    
    NSLog(@"Tap %d", tag);
    EnlargeImageViewControllerV2 *enlargelView = [[EnlargeImageViewControllerV2 alloc]init];
    //enlargelView.content = _content;
    //[enlargelView CreateImagesView];
    //enlargelView.index = tag - 1;
    [self.navigationController presentViewController:enlargelView animated:YES completion:NULL];
    enlargelView = nil;
}
@end
