//
//  EnlargeImageViewController.m
//  PostAdvert11
//
//  Created by Mtk Ray on 5/25/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import "EnlargeImageViewController.h"
#import "PostCellContent.h"
#import "Constants.h"
#import "MyUIImageView.h"

#define ZOOM_STEP 1.5

@interface EnlargeImageViewController (UtilityMethods)
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;
@end

@implementation EnlargeImageViewController
@synthesize navigationController;
@synthesize content;
@synthesize index = _index;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
            currentCenter = currentCenterImage_centerImage;
        //self.wantsFullScreenLayout = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    isToolbarHide = NO;
    thumbnailImageView.frame = [[UIScreen mainScreen]bounds];
    
    //self.wantsFullScreenLayout = YES;
    // Do any additional setup after loading the view from its nib.
    contentView.bouncesZoom = YES;
    contentView.delegate = self;
    contentView.clipsToBounds = YES;// add gesture recognizers to the image view
    
    
    
    
    
//    // calculate minimum scale to perfectly fit image width, and begin at that scale
//    float minimumScale = [contentView frame].size.width  / [contentView frame].size.width;
//    //imageScrollView.maximumZoomScale = 1.0;
//    contentView.minimumZoomScale = minimumScale;
//    contentView.zoomScale = minimumScale;
    
    
    current = _index;
    CGRect frame = [[UIScreen mainScreen]bounds];
    defaultFrame = frame;
    
    centerImageView = [[MyUIImageView alloc] initWithFrame:defaultFrame];
    centerImageView.frame = contentView.frame;
    [thumbnailImageView addSubview:centerImageView];
    
    frame = defaultFrame;
    frame.origin.x = - defaultFrame.size.width;
    leftImageView = [[MyUIImageView alloc]initWithFrame:frame];
    [thumbnailImageView addSubview:leftImageView];
    
    frame.origin.x = frame.size.width;
    rightImageView = [[MyUIImageView alloc]initWithFrame:frame];
    [thumbnailImageView addSubview:rightImageView];
    
    //[contentView addSubview:thumbnailImageView];
    //[contentView sendSubviewToBack:thumbnailImageView];
    // Bar button
    UIBarButtonItem *leftBarButtonItm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStylePlain
                                                    target:self
                                                    action:@selector(actionDoneButtonPressed:)];
    leftBarButtonItm.tintColor = [UIColor blueColor];
    title = [[UILabel alloc]init];
    [title setFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE * 1.5]];
    title.text = [NSString stringWithFormat:@"%d of %d", _index + 1, content.listImages.count];
    title.textColor = [UIColor whiteColor];
    [title sizeToFit];
    title.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *titleToolbar = [[UIBarButtonItem alloc] initWithCustomView:title];
    titleToolbar.tintColor = [UIColor clearColor];
    UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                 target:self
                                                                 action:@selector(actionButtonPressed:)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];        
    NSMutableArray *toolbarButtons = [[NSMutableArray alloc] initWithObjects:leftBarButtonItm, flexibleSpace, titleToolbar, flexibleSpace, actionButton, nil];
    [topToolbar setItems:toolbarButtons animated:YES];
    leftBarButtonItm = nil;
    flexibleSpace = nil;
    toolbarButtons = nil;
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    UIPinchGestureRecognizer *twoFingerTap = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    swipeLeft.enabled = YES;
    swipeRight.enabled = YES;
    [tap setNumberOfTapsRequired:1];
    [doubleTap setNumberOfTapsRequired:2];
    [contentView addGestureRecognizer:tap];
    [contentView addGestureRecognizer:twoFingerTap];
    [contentView addGestureRecognizer:doubleTap];
    [contentView addGestureRecognizer:swipeLeft];
    [contentView addGestureRecognizer:swipeRight];
//    [centerImageView addGestureRecognizer:doubleTap];
//    [centerImageView addGestureRecognizer:twoFingerTap];
//    
//    [leftImageView addGestureRecognizer:doubleTap];
//    [leftImageView addGestureRecognizer:twoFingerTap];
//    
//    [rightImageView addGestureRecognizer:doubleTap];
//    [rightImageView addGestureRecognizer:twoFingerTap];
    
    contentView.minimumZoomScale=0.7;
    contentView.maximumZoomScale=2.5;
    contentView.contentSize=CGSizeMake(320, 460);
    contentView.delegate=self;
    contentView.zoomScale =1.0;

    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

}


-(void) viewDidAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnlargeImageListenMoving) name:@"EnlargeImageListenMoving" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnlargeImageListenMoveEnd) name:@"EnlargeImageListenMoveEnd" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SingleTapImageView) name:@"SingleTapImageView" object:nil];
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"inOutEnlargeImage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSwipe) name:@"updateSwipe" object:nil];
    if (content == nil) {
        return;
    }
    [self loadImageForTheFirstTime];
    NSLog(@"contentView %f %f %f %f", contentView.frame.origin.x, contentView.frame.origin.y, contentView.frame.size.width, contentView.frame.size.height);
    NSLog(@"Farm %f %f %f %f", centerImageView.frame.origin.x, centerImageView.frame.origin.y, centerImageView.frame.size.width, centerImageView.frame.size.height);
    //centerImageView.userInteractionEnabled =YES;
    //centerImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    leftImageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth );
    centerImageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth );
    rightImageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth );
    contentView.contentSize = centerImageView.frame.size;
//    UISwipeGestureRecognizer * recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(myRightAction)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
//    [contentView addGestureRecognizer:recognizer];
//    
//    UISwipeGestureRecognizer * recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(myLeftAction)];
//    [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
//    [contentView addGestureRecognizer:recognizer2];
    
    
    // Add tap
    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    //[contentView addGestureRecognizer:tap];
    
    // calculate minimum scale to perfectly fit image width, and begin at that scale
    float minimumScale = [contentView frame].size.width  / [centerImageView frame].size.width;
    //imageScrollView.maximumZoomScale = 1.0;
    contentView.minimumZoomScale = minimumScale;
    contentView.zoomScale = minimumScale;
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"inOutEnlargeImage" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - implement
- (void)EnlargeImageListenMoveEnd
{
    NSLog(@"EnlargeImageListenMoveEnd");
    CGRect frame = contentView.frame;
    NSNumber *x = [[NSUserDefaults standardUserDefaults] objectForKey:@"PointX"];
    // case move right & the first Image
    if ((current == 0) && (x.floatValue > 0.0)) {
        [UIView setAnimationDuration:0.99];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
        UIView *view;
        if (currentCenter == currentCenterImage_centerImage) {
            view = centerImageView;
            frame = defaultFrame;
            frame.origin.x = -defaultFrame.size.width;
            leftImageView.frame = frame;
            frame.origin.x = defaultFrame.size.width;
            rightImageView.frame = frame;
        }else {
            if (currentCenter == currentCenterImage_leftImage) {
                view = leftImageView;
                frame = defaultFrame;
                frame.origin.x = -defaultFrame.size.width;
                rightImageView.frame = frame;
                frame.origin.x = defaultFrame.size.width;
                centerImageView.frame = frame;
            }else {
                view =rightImageView;
                frame = defaultFrame;
                frame.origin.x = -defaultFrame.size.width;
                centerImageView.frame = frame;
                frame.origin.x = defaultFrame.size.width;
                leftImageView.frame = frame;
            }
        }
        [UIView beginAnimations:@"EnlargeImageListenMoveEnd" context:(__bridge void *)view];
        view.frame = defaultFrame;
        
        [UIView commitAnimations];
        return;
    }
    // case move left & the lastet Image
    if ((current == content.listImages.count - 1) && (x.floatValue < 0.0)) {
        [UIView setAnimationDuration:0.99];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
        UIView *view;
        if (currentCenter == currentCenterImage_centerImage) {
            view = centerImageView;
            frame = defaultFrame;
            frame.origin.x = -defaultFrame.size.width;
            leftImageView.frame = frame;
            frame.origin.x = defaultFrame.size.width;
            rightImageView.frame = frame;
        }else {
            if (currentCenter == currentCenterImage_leftImage) {
                view = leftImageView;
                frame = defaultFrame;
                frame.origin.x = -defaultFrame.size.width;
                rightImageView.frame = frame;
                frame.origin.x = defaultFrame.size.width;
                centerImageView.frame = frame;
            }else {
                view =rightImageView;
                frame = defaultFrame;
                frame.origin.x = -defaultFrame.size.width;
                centerImageView.frame = frame;
                frame.origin.x = defaultFrame.size.width;
                leftImageView.frame = frame;
            }
        }
        [UIView beginAnimations:@"EnlargeImageListenMoveEnd" context:(__bridge void *)view];
        view.frame = defaultFrame;
        
        [UIView commitAnimations];
        return;

    }
    // case move but distance less than cMinImageMove
    if ( fabs(x.floatValue) < cMinImageMove) {
        [UIView setAnimationDuration:0.99];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
        UIView *view;
        if (currentCenter == currentCenterImage_centerImage) {
            view = centerImageView;
        }else {
            if (currentCenter == currentCenterImage_leftImage) {
                view = leftImageView;
            }else {
                view =rightImageView;
            }
        }
        [UIView beginAnimations:@"EnlargeImageListenMoveEnd" context:(__bridge void *)view];
        if (currentCenter == currentCenterImage_centerImage) {
            frame = defaultFrame;
            frame.origin.x = -defaultFrame.size.width;
            leftImageView.frame = frame;
            frame.origin.x = defaultFrame.size.width;
            rightImageView.frame = frame;
        }else {
            if (currentCenter == currentCenterImage_leftImage) {
                frame = defaultFrame;
                frame.origin.x = -defaultFrame.size.width;
                rightImageView.frame = frame;
                frame.origin.x = defaultFrame.size.width;
                centerImageView.frame = frame;
            }else {
                frame = defaultFrame;
                frame.origin.x = -defaultFrame.size.width;
                centerImageView.frame = frame;
                frame.origin.x = defaultFrame.size.width;
                leftImageView.frame = frame;
            }
        }

        view.frame = defaultFrame;
        
        [UIView commitAnimations];
        return;

    }
    
    // case move left
    if ( x.floatValue < 0) {
        [UIView setAnimationDuration:0.99];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
        UIView *view;
        if (currentCenter == currentCenterImage_centerImage) {
            view = centerImageView;
        }else {
            if (currentCenter == currentCenterImage_leftImage) {
                view = leftImageView;
            }else {
                view =rightImageView;
            }
        }
        [UIView beginAnimations:@"EnlargeImageListenMoveEnd" context:(__bridge void *)view];
        if (currentCenter == currentCenterImage_centerImage) {
            frame = defaultFrame;
            rightImageView.frame = frame;
            currentCenter = currentCenterImage_rightImage;
            leftImageView.hidden = YES;
        }else {
            if (currentCenter == currentCenterImage_leftImage) {
                rightImageView.hidden = YES;
                frame.origin.x = defaultFrame.size.width;
                centerImageView.frame = defaultFrame;
                currentCenter = currentCenterImage_centerImage;
            }else {
                centerImageView.hidden = YES;
                leftImageView.frame = defaultFrame;
                currentCenter = currentCenterImage_leftImage;
            }
        }
        frame.origin.x = -defaultFrame.size.width;
        view.frame = frame;
        
        [UIView commitAnimations];
        [self loadImageAtIndex:current + 1];
        return;
    }
    // case move right
    if ( x.floatValue > 0) {
        [UIView setAnimationDuration:0.99];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
        UIView *view;
        if (currentCenter == currentCenterImage_centerImage) {
            view = centerImageView;
        }else {
            if (currentCenter == currentCenterImage_leftImage) {
                view = leftImageView;
            }else {
                view =rightImageView;
            }
        }
        [UIView beginAnimations:@"EnlargeImageListenMoveEnd" context:(__bridge void *)view];
        if (currentCenter == currentCenterImage_centerImage) {
            frame = defaultFrame;
            leftImageView.frame = frame;
            currentCenter = currentCenterImage_leftImage;
            rightImageView.hidden = YES;
        }else {
            if (currentCenter == currentCenterImage_leftImage) {
                rightImageView.frame = defaultFrame;
                centerImageView.hidden = YES;
                currentCenter = currentCenterImage_rightImage;
            }else {
                centerImageView.frame = defaultFrame;
                leftImageView.hidden = YES;
                currentCenter = currentCenterImage_centerImage;
            }
        }
        frame.origin.x = defaultFrame.size.width;
        view.frame = frame;
        [UIView commitAnimations];
        [self loadImageAtIndex:current - 1];
        return;
    }
    
}
- (void) updateView
{
     centerImageView.image = [self loadImageWithTag:current];
    CGRect frame = contentView.frame;
    frame.origin.x = -defaultFrame.size.width;
    contentView.frame = frame;
}
- (void) EnlargeImageListenMoving
{
    NSLog(@"EnlargeImageListenMoving");
    CGRect frame = centerImageView.frame;
//    [UIView setAnimationDuration:0.0];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
//    [UIView beginAnimations:@"EnlargeImageListenMoving_animation" context:nil];
    NSNumber *x = [[NSUserDefaults standardUserDefaults] objectForKey:@"PointX"];
    frame.origin.x += x.floatValue;
    centerImageView.frame = frame;
    frame = leftImageView.frame;
    frame.origin.x += x.floatValue;
    leftImageView.frame = frame;
    frame = rightImageView.frame;
    frame.origin.x += x.floatValue;
    rightImageView.frame = frame;
//    [UIView commitAnimations];
}
- (void) loadImageAtIndex:(NSInteger)index
{
    if (index < 0 || index >= content.listImages.count) {
        return;
    }
    BOOL increase = index > current;
    
    current = index;
    title.text = [NSString stringWithFormat:@"%d of %d", current + 1, content.listImages.count];
    [title sizeToFit];
    CGRect frame = defaultFrame;
    switch (currentCenter) {
        case currentCenterImage_rightImage:
            //left
            if (current > 0) {
                centerImageView.image = [content.listImages objectAtIndex:current-1];
            }else {
                centerImageView.image = nil;
            }
            //right
            if (current + 1 < content.listImages.count) {
                leftImageView.image = [content.listImages objectAtIndex:current+1];
            }else {
                leftImageView.image = nil;
            }
            if (increase) {
                frame.origin.x = defaultFrame.size.width;
                leftImageView.frame = frame;
            }else {
                frame.origin.x = - defaultFrame.size.width;
                centerImageView.frame = frame;
            }
            break;
        case currentCenterImage_leftImage:
            //left
            if (current > 0) {
                rightImageView.image = [content.listImages objectAtIndex:current-1];
            }else {
                rightImageView.image = nil;
            }
            //right
            if (current + 1 < content.listImages.count) {
                centerImageView.image = [content.listImages objectAtIndex:current+1];
            }else {
                centerImageView.image = nil;
            }
            if (increase) {
                frame.origin.x = defaultFrame.size.width;
                centerImageView.frame = frame;
            }else {
                frame.origin.x = - defaultFrame.size.width;
                rightImageView.frame = frame;
            }
            break;
        
        default:
            //left
            if (current > 0) {
                leftImageView.image = [content.listImages objectAtIndex:current-1];
            }else {
                leftImageView.image = nil;
            }
            //right
            if (current + 1 < content.listImages.count) {
                rightImageView.image = [content.listImages objectAtIndex:current+1];
            }else {
                rightImageView.image = nil;
            }
            if (increase) {
                frame.origin.x = defaultFrame.size.width;
                rightImageView.frame = frame;
            }else {
                frame.origin.x = - defaultFrame.size.width;
                leftImageView.frame = frame;
            }
            break;
    }
    rightImageView.hidden = NO;
    centerImageView.hidden = NO;
    leftImageView.hidden = NO;
}

- (void) loadImageForTheFirstTime{
    centerImageView.image = [content.listImages objectAtIndex:current];
    currentCenter = currentCenterImage_centerImage;
    //left
    if (current > 0) {
        leftImageView.image = [content.listImages objectAtIndex:current-1];
    }else {
        leftImageView.image = nil;
    }
    //right
    if (current + 1 < content.listImages.count) {
        rightImageView.image = [content.listImages objectAtIndex:current+1];
    }else {
        rightImageView.image = nil;
    }
}
- (UIImage*) loadImageWithTag:(NSInteger) tag
{
    if (current < content.listImages.count) {
        rightImageView.image = (UIImage*) [content.listImages objectAtIndex:tag];
    }
    else {
        rightImageView.image = nil;
    }
    if (current > 1) {
        leftImageView.image = (UIImage*) [content.listImages objectAtIndex:tag - 2];
    }else {
        leftImageView.image = nil;
    }
    
    //add to view
        return nil;
    return (UIImage*) [content.listImages objectAtIndex:tag - 1];
}

- (void) myRightAction
{
    NSLog(@"Right");
    return;
    CGRect frame = self.view.frame;
    frame.origin.x += (3 * cImageWidth) + CELL_CONTENT_MARGIN_LEFT;
    if ( current == 0) {
        return;
    }
    current -= 1;
    [UIView setAnimationDuration:0.99];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
    [UIView beginAnimations:@"imageSwipe" context:(__bridge void *)self.view];
    self.view.frame = frame;
    [UIView commitAnimations];
}
- (void) myLeftAction
{
    NSLog(@"Left");
    return;
    CGRect frame = self.view.frame;
    frame.origin.x -= (3 * cImageWidth) + CELL_CONTENT_MARGIN_LEFT;
    
   
    current += 1;
    [UIView setAnimationDuration:0.99];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
    [UIView beginAnimations:@"imageSwipe" context:(__bridge void *)self.view];
    self.view.frame = frame;
    [UIView commitAnimations];
    
}
- (void) SingleTapImageView{
    if (numberOfTap == 2) {
        return;
    }
    NSLog(@"SingleTapImageView");
    CGRect frame = topToolbar.frame;
    [UIView setAnimationDuration:2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
    [UIView beginAnimations:@"hideToolbar" context:(__bridge void *)topToolbar];
    if (isToolbarHide) {
        frame.origin.y = cStatusBarHeight;
    }else {
        frame.origin.y = - cNavigationBarHeight;
    }
    topToolbar.frame = frame;
    [[UIApplication sharedApplication] setStatusBarHidden:!isToolbarHide withAnimation:UIStatusBarAnimationFade];
    [UIView commitAnimations];
    isToolbarHide = ! isToolbarHide;
}

- (void)tapAction:(id)sender {
    numberOfTap = 1;
    [self performSelector:@selector(SingleTapImageView) withObject:nil afterDelay:0.35];

}
- (IBAction)actionDoneButtonPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)actionButtonPressed:(id)sender
{    
    UIActionSheet *uias = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self 
                                             cancelButtonTitle:@"Cancel" 
                                        destructiveButtonTitle:nil 
                                             otherButtonTitles:@"Save Photo", nil];
    
    [uias showInView:self.view];
    uias = nil;
}



#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)uias clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // user pressed "Cancel"
    if(buttonIndex == [uias cancelButtonIndex]) return;
    
    // user pressed "Open in Safari"
    if([[uias buttonTitleAtIndex:buttonIndex] compare:@"Save Photo"] == NSOrderedSame)
    {
        switch (currentCenter) {
            case currentCenterImage_leftImage:
                UIImageWriteToSavedPhotosAlbum(leftImageView.image, nil, nil, nil);
                break;
            
            case currentCenterImage_rightImage:
                UIImageWriteToSavedPhotosAlbum(rightImageView.image, nil, nil, nil);
                break;
            default:
                UIImageWriteToSavedPhotosAlbum(centerImageView.image, nil, nil, nil);
                break;
        }
        //UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

    }
}

/*
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale{
    
	if (scrollView.zoomScale > 1.0f) {		
		
		
		CGFloat height, width, originX, originY;
		height = MIN(CGRectGetHeight(self.imageView.frame) + self.imageView.frame.origin.x, CGRectGetHeight(self.bounds));
		width = MIN(CGRectGetWidth(self.imageView.frame) + self.imageView.frame.origin.y, CGRectGetWidth(self.bounds));
        
		
		if (CGRectGetMaxX(self.imageView.frame) > self.bounds.size.width) {
			width = CGRectGetWidth(self.bounds);
			originX = 0.0f;
		} else {
			width = CGRectGetMaxX(self.imageView.frame);
			
			if (self.imageView.frame.origin.x < 0.0f) {
				originX = 0.0f;
			} else {
				originX = self.imageView.frame.origin.x;
			}	
		}
		
		if (CGRectGetMaxY(self.imageView.frame) > self.bounds.size.height) {
			height = CGRectGetHeight(self.bounds);
			originY = 0.0f;
		} else {
			height = CGRectGetMaxY(self.imageView.frame);
			
			if (self.imageView.frame.origin.y < 0.0f) {
				originY = 0.0f;
			} else {
				originY = self.imageView.frame.origin.y;
			}
		}
        
		CGRect frame = self.scrollView.frame;
		self.scrollView.frame = CGRectMake((self.bounds.size.width / 2) - (width / 2), (self.bounds.size.height / 2) - (height / 2), width, height);
		self.scrollView.layer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
		if (!CGRectEqualToRect(frame, self.scrollView.frame)) {		
			
			CGFloat offsetY, offsetX;
            
			if (frame.origin.y < self.scrollView.frame.origin.y) {
				offsetY = self.scrollView.contentOffset.y - (self.scrollView.frame.origin.y - frame.origin.y);
			} else {				
				offsetY = self.scrollView.contentOffset.y - (frame.origin.y - self.scrollView.frame.origin.y);
			}
			
			if (frame.origin.x < self.scrollView.frame.origin.x) {
				offsetX = self.scrollView.contentOffset.x - (self.scrollView.frame.origin.x - frame.origin.x);
			} else {				
				offsetX = self.scrollView.contentOffset.x - (frame.origin.x - self.scrollView.frame.origin.x);
			}
            
			if (offsetY < 0) offsetY = 0;
			if (offsetX < 0) offsetX = 0;
			
			self.scrollView.contentOffset = CGPointMake(offsetX, offsetY);
		}
        
	} else {
		[self layoutScrollViewAnimated:YES];
	}
}	
*/

#pragma mark UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return thumbnailImageView;
    if (currentCenter == currentCenterImage_centerImage) {
        return centerImageView;
    }else {
        if (currentCenter == currentCenterImage_leftImage) {
            return leftImageView;
        }else {
            return rightImageView;
        }
    }
    return centerImageView;
}

- (void) scrollViewDidZoom:(UIScrollView *)scrollView 
{
    NSLog(@"Changed contentSize=(%f,%f), ratio=%f", contentView.contentSize.width, contentView.contentSize.height, contentView.contentSize.height/contentView.contentSize.width);
}

#pragma mark TapDetectingImageViewDelegate methods

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    // single tap does nothing for now
    NSLog(@"single tap does nothing for now");
    [UIView setAnimationDuration:2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
    [UIView beginAnimations:@"hideToolbar" context:(__bridge void *)self.view];
    topToolbar.hidden = ! topToolbar.hidden;
    [[UIApplication sharedApplication] setStatusBarHidden:topToolbar.hidden withAnimation:UIStatusBarAnimationFade];
    [UIView commitAnimations];
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    // zoom in
    numberOfTap = 2;
    if (!isZooming) {
        float newScale = [contentView zoomScale] * ZOOM_STEP;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        [contentView zoomToRect:zoomRect animated:YES];
        NSLog(@"Frame zoomed %f %f %f %f", contentView.frame.origin.x, contentView.frame.origin.y, contentView.frame.size.width, contentView.frame.size.height );
        isZooming = YES;
    }else {
        float newScale = 1.0;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        [contentView zoomToRect:zoomRect animated:YES];
        NSLog(@"Frame zoomed %f %f %f %f", contentView.frame.origin.x, contentView.frame.origin.y, contentView.frame.size.width, contentView.frame.size.height );
        isZooming = NO;
    }
    
}

- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
    // two-finger tap zooms out
    float newScale = [contentView zoomScale] / ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    if (newScale == 1.0) {
        isZooming = NO;
    }
    else {
            isZooming = YES;
    }
    [contentView zoomToRect:zoomRect animated:YES];
}

- (void) handleSwipeLeft:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"Swipe Left");
    if(current == content.listImages.count - 1)
    {
        return;
    }
    CGRect frame;
    [UIView setAnimationDuration:2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
    UIView *view;
    if (currentCenter == currentCenterImage_centerImage) {
        view = centerImageView;
    }else {
        if (currentCenter == currentCenterImage_leftImage) {
            view = leftImageView;
        }else {
            view =rightImageView;
        }
    }
    [UIView beginAnimations:@"EnlargeImageListenMoveEnd" context:(__bridge void *)view];
    if (currentCenter == currentCenterImage_centerImage) {
        frame = defaultFrame;
        rightImageView.frame = frame;
        currentCenter = currentCenterImage_rightImage;
        leftImageView.hidden = YES;
    }else {
        if (currentCenter == currentCenterImage_leftImage) {
            rightImageView.hidden = YES;
            frame.origin.x = defaultFrame.size.width;
            centerImageView.frame = defaultFrame;
            currentCenter = currentCenterImage_centerImage;
        }else {
            centerImageView.hidden = YES;
            leftImageView.frame = defaultFrame;
            currentCenter = currentCenterImage_leftImage;
        }
    }
    frame.origin.x = -defaultFrame.size.width;
    view.frame = frame;
    
    [UIView commitAnimations];
    [self loadImageAtIndex:current + 1];
}
- (void) handleSwipeRight:(UIGestureRecognizer *)gestureRecognizer
{
      NSLog(@"Swipe Right");
    if (current == 0) {
        return;
    }
    CGRect frame;
    [UIView setAnimationDuration:2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
    UIView *view;
    if (currentCenter == currentCenterImage_centerImage) {
        view = centerImageView;
    }else {
        if (currentCenter == currentCenterImage_leftImage) {
            view = leftImageView;
        }else {
            view =rightImageView;
        }
    }
    [UIView beginAnimations:@"EnlargeImageListenMoveEnd" context:(__bridge void *)view];
    if (currentCenter == currentCenterImage_centerImage) {
        frame = defaultFrame;
        leftImageView.frame = frame;
        currentCenter = currentCenterImage_leftImage;
        rightImageView.hidden = YES;
    }else {
        if (currentCenter == currentCenterImage_leftImage) {
            rightImageView.frame = defaultFrame;
            centerImageView.hidden = YES;
            currentCenter = currentCenterImage_rightImage;
        }else {
            centerImageView.frame = defaultFrame;
            leftImageView.hidden = YES;
            currentCenter = currentCenterImage_centerImage;
        }
    }
    frame.origin.x = defaultFrame.size.width;
    view.frame = frame;
    [UIView commitAnimations];
    [self loadImageAtIndex:current - 1];
}
#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates. 
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [contentView frame].size.height / scale;
    zoomRect.size.width  = [contentView frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}


#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ( [gestureRecognizer isMemberOfClass:[UITapGestureRecognizer class]] ) {
        // Return NO for views that don't support Taps
        return YES;
    } else if ( [gestureRecognizer isMemberOfClass:[UISwipeGestureRecognizer class]] ) {
        // Return NO for views that don't support Swipes
        return NO;
    }
    
    return YES;
}

- (void) updateSwipe{
    swipeLeft.enabled = !swipeLeft.enabled;
    swipeRight.enabled = !swipeRight.enabled;
}

@end
