//
//  EnlargeImageViewControllerV2.m
//  Postadvert
//
//  Created by Mtk Ray on 6/1/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "EnlargeImageViewControllerV2.h"
#import "MyImageViewController.h"
#import "PostCellContent.h"
#import "KTPhotoBrowserDataSource.h"
@interface EnlargeImageViewControllerV2 ()
- (CGRect) getScreenSize;
@end

@implementation EnlargeImageViewControllerV2
@synthesize imageViews = _imageViews;
//@synthesize content = _content;
@synthesize scrollView = _scrollView;
//@synthesize index = _index;
- (id) initWithDataSource:(id<KTPhotoBrowserDataSource>)datasource andStartWithPhotoAtIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        dataSource_ = datasource;
        NSLog(@"Init with index %d", index);
        _index = index;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.autoresizesSubviews = YES;
    //self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    isShowToolbar = YES;
    self.view.backgroundColor = [UIColor clearColor];
    pageWidth = self.view.frame.size.width + 40;
    // Do any additional setup after loading the view from its nib.
    totalImage =[dataSource_ numberOfPhotos];
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < totalImage; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.imageViews = controllers;
    
    // a page is the width of the scroll view
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(pageWidth * totalImage, _scrollView.frame.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //_scrollView.autoresizesSubviews = YES;
    
    UIBarButtonItem *leftBarButtonItm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStylePlain
                                                                                      target:self
                                                                                      action:@selector(actionDoneButtonPressed:)];
    leftBarButtonItm.tintColor = [UIColor blueColor];
    title = [[UILabel alloc]init];
    //[title setFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE * 1.5]];
    title.text = [NSString stringWithFormat:@"%d of %d", _index + 1, totalImage];
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
    
    //pageControl.numberOfPages = kNumberOfPages;
    //pageControl.currentPage = 0;
    
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    //
    //CGRect frame = _scrollView.frame;
    //frame.origin.x = frame.size.width * (_index);
    //[_scrollView scrollRectToVisible:frame animated:NO];
    [self setScrollViewContentSize];
    //[self loadCurrentPage];
    [self loadScrollViewWithPage:_index];
    [self loadScrollViewWithPage:_index - 1];
    [self loadScrollViewWithPage:_index + 1];
}

- (void)viewDidUnload
{
    NSLog(@"EnlargeImageViewControllerV2: viewDidUnload");
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
//-(void) viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    NSLog(@"viewWillAppear");
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setScrollViewContentSize];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(singleTapImageView) name:@"singleTapImageView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:@"applicationWillResignActive" object:nil];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"inOutEnlargeImage" object:nil];
    NSLog(@"viewDidAppear");
}

- (void) viewDidDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    NSLog(@"viewDidDisappear");
    [super viewDidDisappear:animated];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"inOutEnlargeImage" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait | interfaceOrientation == UIInterfaceOrientationLandscapeLeft | interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    //return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    if ([UIApplication sharedApplication].statusBarHidden) {
        [self singleTapImageView];
        isTempShowToolbar = YES;
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    if (isTempShowToolbar) {
        [self performSelector:@selector(singleTapImageView) withObject:nil afterDelay:0.0];
        isTempShowToolbar = NO;
    }
    
    
}
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //[self setBaseViewFrameWithScreenSize];
//     [self updateMainView];
//    [self updateScrollView];
//    [self updateTopToolBar];
//    [self performSelectorOnMainThread:@selector(loadCurrentPage) withObject:nil waitUntilDone:YES];
//    [self loadScrollViewWithPage:_index ];
    [self performSelector:@selector(updateCurrentPage) withObject:nil afterDelay:0.0 ];
    
}
- (void)loadScrollViewWithPage:(int)page
{
    NSLog(@"Page %d", page);
    if (page < 0)
        return;
    if (page >= totalImage)
        return;
    
    // replace the placeholder if necessary
    MyImageViewController *controller = [_imageViews objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        //controller = [[MyImageViewController alloc] initWithImage:[_content.listImages objectAtIndex:page] ];
        controller = [[MyImageViewController alloc] initWithURL:[dataSource_ imageUrlAtIndex:page] ];
        controller.view.frame = [self frameForPageAtIndex:page];
        controller.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        controller.view.tag = page;
        [_imageViews replaceObjectAtIndex:page withObject:controller];
    }else {
        if (controller.isZooming) {
            if (page != (floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)) {
                [controller normalSize];
            }
           
        }
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        [_scrollView addSubview:controller.view];
    }
    
    //frame
    CGRect bounds = [self frameForPageAtIndex:page];
    //CGRect frame = _scrollView.frame;
    //frame.origin.x = pageWidth * page;
    //frame.origin.y = 0;
    controller.view.frame = bounds;
    
}

- (void)unloadPhoto:(NSInteger)index
{
    if (index < 0 || index >= totalImage) {
        return;
    }
    
    id currentPhotoView = [imageViews objectAtIndex:index];
    if ([currentPhotoView isKindOfClass:[MyImageViewController class]]) {
        [currentPhotoView removeFromSuperview];
        [imageViews replaceObjectAtIndex:index withObject:[NSNull null]];
    }
}


- (IBAction)actionDoneButtonPressed:(id)sender
{
    topToolbar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
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
#pragma mark -
#pragma mark Frame calculations
#define PADDING  20

- (CGRect)frameForPagingScrollView
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.origin.x -= PADDING;
    frame.size.width += (2 * PADDING);
    NSLog(@"frameForPagingScrollView %f %f %f %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    return frame;
}

- (CGRect)frameForPageAtIndex:(NSUInteger)index
{
    // We have to use our paging scroll view's bounds, not frame, to calculate the page placement. When the device is in
    // landscape orientation, the frame will still be in portrait because the pagingScrollView is the root view controller's
    // view, so its frame is in window coordinate space, which is never rotated. Its bounds, however, will be in landscape
    // because it has a rotation transform applied.
    CGRect bounds = [_scrollView bounds];
    CGRect pageFrame = bounds;
    NSLog(@"Index %d %d", _index, index);
    pageFrame.size.width -= (2 * PADDING);
    pageFrame.origin.x = (bounds.size.width * index) + PADDING;
    NSLog(@"frameForPageAtIndex %f %f %f %f", pageFrame.origin.x, pageFrame.origin.y, pageFrame.size.width, pageFrame.size.height);
    return pageFrame;
}
#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    [self loadCurrentPage];
    NSLog(@"scrollViewDidScroll");
}


#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)uias clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // user pressed "Cancel"
    if(buttonIndex == [uias cancelButtonIndex]) return;
    
    // user pressed "Open in Safari"
    if([[uias buttonTitleAtIndex:buttonIndex] compare:@"Save Photo"] == NSOrderedSame)
    {
       int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        MyImageViewController *controller = [_imageViews objectAtIndex:page];
        if ((NSNull *)controller != [NSNull null]) {
            //Save 
            UIImageWriteToSavedPhotosAlbum(controller.imageView.image, nil, nil, nil);
        }else {
            //can not enter here
            NSLog(@"Error No MyImageViewController to save photo");
        }
        
    }
}

#pragma mark - implement

- (void)singleTapImageView{
    if (isShowToolbar) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        [UIView setAnimationDuration:7];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
        [UIView beginAnimations:@"hideToolbar" context:(__bridge void *)topToolbar];
        topToolbar.alpha = 0;
        [UIView commitAnimations];
        isShowToolbar = NO;
        //[self setWantsFullScreenLayout:YES];
        
    }else {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        topToolbar.alpha = 1.0;
        isShowToolbar = YES;
        CGRect frame = self.view.frame;
        self.view.frame = frame;
       
    }
    [self updateTopToolBar];
    [self updateMainView];
     
}

- (void) temporarilyHideStatusBar {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self performSelector:@selector(showStatusBar) withObject:nil afterDelay:0];
}
- (void) showStatusBar {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void) applicationWillResignActive
{
    NSLog(@"applicationWillResignActive");
    [self temporarilyHideStatusBar];
    isShowToolbar = YES;
    topToolbar.alpha = 1.0;
}

- (CGRect) getScreenSize
{
    CGRect mainBounds = [[UIScreen mainScreen]bounds];
//    CGRect statusBarFrame = [[UIApplication sharedApplication]statusBarFrame];
//    if (statusBarFrame.size.width != mainBounds.size.width) {
//        float temp = mainBounds.size.width;
//        mainBounds.size.width = mainBounds.size.height;
//        mainBounds.size.height = temp;
//    }
    return mainBounds;
}

- (void) setBaseViewFrameWithScreenSize
{
    CGRect frame = [self getScreenSize];
    //UIInterfaceOrientation orientation = [[UIApplication sharedApplication]statusBarOrientation];
    
    self.view.frame = frame;
}
- (void) updateTopToolBar
{
    CGRect frame = topToolbar.frame;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication]statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait) {
        frame.origin.x = 0;
        frame.origin.y = 0;
    }else{
        frame.origin.x = 0;
        frame.origin.y = 0;
    }
    topToolbar.frame = frame;
    NSLog(@"Toolbar %@", topToolbar);
}
- (void) updateMainView
{
    CGRect frame = self.view.frame;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication]statusBarOrientation];
    if ([UIApplication sharedApplication].statusBarHidden) {
        if (orientation == UIInterfaceOrientationPortrait) {
            frame.origin.x = 0;
            frame.origin.y = 20;
        }else if(orientation == UIInterfaceOrientationLandscapeLeft){
            frame.origin.x = 20;
            frame.origin.y = 0;
        }
    }else{
        if (orientation == UIInterfaceOrientationPortrait) {
            frame.origin.x = 0;
            frame.origin.y = 20;
        }else if(orientation == UIInterfaceOrientationLandscapeLeft) {
            frame.origin.x = 20;
            frame.origin.y = 0;
        }
    }
    self.view.frame = frame;
    NSLog(@"MainView %@", self.view);
}
- (void) updateScrollView
{
    NSLog(@"Scroller %@", _scrollView);
}

- (void) loadCurrentPage
{
    CGRect controllerFrame = [self frameForPageAtIndex:_index];
    pageWidth = controllerFrame.size.width;
    // Switch the indicator when more than 50% of the previous/next page is visible
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2.0) / pageWidth) + 1;
    //pageControl.currentPage = page;
    //int page = floor(_scrollView.contentOffset.x / pageWidth);
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    if (page >= totalImage) {
        return;
    }
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    [self unloadPhoto:page + 2];
    [self unloadPhoto:page - 2];
    _index = page - 1;
    NSString *formatString = NSLocalizedString(@"%1$i of %2$i", @"Picture X out of Y total.");
    NSString *titleStr = [NSString stringWithFormat:formatString, page + 1, totalImage, nil];
    title.text = titleStr;
    [title sizeToFit];
    formatString = nil;
    titleStr = nil;
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

- (void)setScrollViewContentSize
{
    
    NSInteger pageCount = totalImage;
    if (pageCount == 0) {
        pageCount = 1;
    }
    
    CGRect frame = [self frameForPagingScrollView];
    CGSize size = CGSizeMake(frame.size.width * pageCount,
                             frame.size.height / 2.0);   // Cut in half to prevent horizontal scrolling.
    [_scrollView setContentSize:size];
}
- (void)scrollToIndex:(NSInteger)index
{
    CGRect frame = _scrollView.frame;
    frame.origin.x = frame.size.width * index;
    frame.origin.y = 0;
    [_scrollView scrollRectToVisible:frame animated:NO];
}
- (void)updateCurrentPage
{
    int page = _index;
    [self loadCurrentPage];
    [self setScrollViewContentSize];
    [self unloadPhoto:page - 1];
    [self unloadPhoto:page +1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page+1];
    [self loadScrollViewWithPage:page-1];
    [self unloadPhoto:page - 2];
    [self unloadPhoto:page +2];
    CGRect frame;
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) {
        frame = [self frameForPageAtIndex:page];
    }else{
        frame = [self frameForPageAtIndex:page];
    }

    frame.origin.x -=PADDING;
    frame.size.width +=(PADDING*2);
    [_scrollView scrollRectToVisible:frame animated:NO];
}
@end
