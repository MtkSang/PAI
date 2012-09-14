//
//  SideBarViewController.m
//  PostAdvert11
//
//  Created by Steven Yap on 18/4/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import "SideBarViewController.h"
#import "LeftViewController.h"
#import "DetailViewController.h"
#import "Constants.h"
#import "SignInVwCtrl.h"
#import "NewAccountVwCtrl.h"
#import "UserPAInfo.h"
#import "PostAdvertControllerV2.h"

@interface SideBarViewController ()
    - (BOOL) checkForInternal;
    - (void) updateNavigationBarItem;
- (void) setSideBarForState:(NSNotification*)notifi;
- (void) showDetailFromSubView;
- (UIGestureRecognizer*) addPanGesture:(id)target;
- (void) handlePanGesture:(UIPanGestureRecognizer*) gesture;
@end

@implementation SideBarViewController

@synthesize navLeft, navDetail;
@synthesize sideBarState;
@synthesize overlay;
static  SideBarViewController *instance_SideBar = nil;


static void singleton_remover() {
    instance_SideBar = nil;
}

+ (SideBarViewController*)instanceSideBar {
    @synchronized([SideBarViewController class])
	{
		if (!instance_SideBar)
			instance_SideBar = [[self alloc] init];
        
		return instance_SideBar;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([SideBarViewController class])
	{
		NSAssert(instance_SideBar == nil, @"Attempted to allocate a second instance of a singleton.");
		instance_SideBar = [super alloc];
		return instance_SideBar;
	}
    
	return nil;
}

- (id)init {
    self = [super init];
    if (self) {
        
        atexit(singleton_remover);
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    previousState = 0;
    sideBarState = 0;
    
    self.view.autoresizesSubviews = YES;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    didShowListLogin = 0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        sideBar = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
        mainCtr = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }else
    {
        sideBar = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
        mainCtr = [[DetailViewController alloc] initWithNibName:@"DetailViewController_IPad" bundle:nil];

    }
    
    navLeft = [[UINavigationController alloc] initWithRootViewController:sideBar];
    navDetail = [[UINavigationController alloc] initWithRootViewController:mainCtr];
    
    navLeft.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    navDetail.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [mainCtr.navigationController.navigationBar addGestureRecognizer:[self addPanGesture:self]];
    [sideBar.navigationController.navigationBar addGestureRecognizer:[self addPanGesture:self]];
    [sideBar.view addGestureRecognizer:[self addPanGesture:self]];
    CGRect frame = navDetail.view.frame;
    frame.origin.x = self.view.frame.size.width - cRemainView;
    navDetail.view.frame = frame;
    [self.view addSubview:navLeft.view];
    [self.view addSubview:navDetail.view];
    [self addChildViewController:navDetail];
    [self addChildViewController:navLeft];
    
    navLeft.navigationBar.tintColor = [UIColor colorWithRed:105.0/225 green:92.0/225 blue:75.0/225 alpha:0.8];
    navDetail.navigationBar.tintColor = [UIColor colorWithRed:79.0/255 green:178.0/255 blue:187.0/255 alpha:1];
    sideBar.detailVw = mainCtr;
    
    UIButton *copyRightButton = [[UIButton alloc]init];
    [copyRightButton setBackgroundColor:[UIColor clearColor]];
    [copyRightButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    [copyRightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [copyRightButton setTitle:@"Postadvert © 2012" forState:UIControlStateNormal];
    [copyRightButton sizeToFit];
    NSLog(@"Bot %@", botView);
    copyRightButton.frame = CGRectMake(self.view.frame.size.width - cRemainView - copyRightButton.frame.size.width - 5.0, 0.0, copyRightButton.frame.size.width, cCellHeight - 5);
    botView = [[UIView alloc]initWithFrame:CGRectMake(0.0, navLeft.view.frame.size.height - cCellHeight + 5, navLeft.view.frame.size.width, cCellHeight - 5)];
    [botView addSubview:copyRightButton];
    botView.backgroundColor = [UIColor whiteColor];
    [botView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth];
    copyRightButton = nil;
    
    [navLeft.view addSubview:botView];
    //navDetail.navigationBar.translucent = YES;
    button = [[UIButton alloc]initWithFrame:navDetail.view.frame];
    button.frame = CGRectMake(0, cStatusAndNavBar, navDetail.view.frame.size.width, navDetail.view.frame.size.height);
    button.tintColor = [UIColor redColor];
    [button addTarget:self action:@selector(showHideSideBar) forControlEvents:UIControlEventTouchUpInside];
    [button addGestureRecognizer:[self addPanGesture:self]];
    [navDetail.view addSubview:button];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showHideSideBar) name:@"showhidesidebar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideSideBar) name:@"hideSideBar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navMove) name:@"navMove" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navEndMove) name:@"navEndMove" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(speedForNavigationBar) name:@"speedForNavigationBar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOutListener) name:@"logOutListener" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PauseResumeSidebar) name:@"PauseResumeSidebar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterAddComment) name:@"enterAddComment" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterWebBrowser) name:@"enterWebBrowser" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inOutEnlargeImage) name:@"inOutEnlargeImage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inOutComments:) name:@"inOutComments" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailFromSubView) name:@"showDetailFromSubView_SideBar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSideBarForState:) name:@"setSideBarForState" object:nil];

}
- (void) viewDidUnload{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
    botView = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self performSelector:@selector(resizeViewsForNavigationBar) withObject:nil afterDelay:(0.5f * duration)];
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    [self performSelector:@selector(updateWhenRotate) withObject:nil afterDelay:0.0];
    //[self setState:sideBarState];
    
}
- (void) updateWhenRotate{
    [self setState:sideBarState];
}
- (void)resizeViewsForNavigationBar {
    //[navLeft.navigationBar sizeToFit];
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"Rotated %@", self);
    //[self setState:sideBarState];
}
- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (!didShowListLogin) {
        sideBarState = 4;
        [self sideBarUpdate];
        NSLog(@"User ID %ld", [UserPAInfo sharedUserPAInfo].registrationID);
        if (![UserPAInfo sharedUserPAInfo].registrationID) {
            navDetail.view.hidden = YES;
            navLeft.view.hidden = YES;
            botView.hidden = YES;
            mainCtr.view.backgroundColor = [UIColor colorWithRed:79.0/255 green:178.0/255 blue:187.0/255 alpha:1];
            if (!loginView) {
                loginView = [self createLoginListView];
            }
            [self onTouchSignInBtn:self];
        }else {
            didShowListLogin = 2;
            //set the Main Page as the very first page
            previousState = 1;
            [self viewWillAppear:YES];
        }
    }else {
        if (didShowListLogin == 2) {
            
            //navDetail.navigationBarHidden = NO;
            //sideBarState = 1;
            //CGRect frame = navDetail.view.frame;
            //frame.origin.x = self.view.frame.size.width;
            //navDetail.view.frame = frame;
            //mainCtr.view.backgroundColor = [UIColor whiteColor];
            [sideBar.tableView reloadData];
            //[self.view addSubview:navLeft.view];
            //[self.view addSubview:navDetail.view];
            navDetail.view.hidden = NO;
            navLeft.view.hidden = NO;
            botView.hidden = NO;
            
            
           
        }
        instance_SideBar = self;
    }
}
-(void) viewDidAppear:(BOOL)animated
{
    NSLog(@"Self %@, navdetail %@ detail %@", self.view, navDetail.view, mainCtr.view);
    NSLog(@"Side didAppear");
    [super viewDidAppear:animated];
    NSNumber *num = [NSNumber numberWithInteger:previousState];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:num forKey:@"setSideBarForState"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setSideBarForState" object:nil userInfo:dict];
    //Load activity
//    NSDictionary *dict_act = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:0] forKey:@"itemID"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"showDetailFromLeftView" object:nil userInfo:dict_act];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadActivity" object:nil];
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSLog(@"SideBar viewDidDisappear" );
    [super viewDidDisappear:animated];
    previousState = sideBarState;
}
#pragma mark - SideBar
- (IBAction)buttonClicked:(id)sender{
    UIButton *view = (UIButton*) sender;
    NSLog(@"Buttonlicked %f %@", view.frame.origin.x,view.description);
    
    if (view.frame.origin.x < self.view.frame.size.width - cRemainView) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showhidesidebar" object:nil];  
    } 
}
- (void) sideBarUpdate
{
    
    if(sideBarState == 0) {
        if (button.hidden == NO) {
            [button setHidden:YES];
        }
    }
    else if (sideBarState == 1) 
    {
        if (button.hidden) {
            button.hidden = NO;
        }
    }    
    NSNumber *num = [NSNumber numberWithInteger:sideBarState];
    [[NSUserDefaults standardUserDefaults] setObject:num forKey:@"sideBarUpdate"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sideBarUpdate" object:nil];
    num = nil;
}
- (void) PauseResumeSidebar
{
    if (sideBarState == 4) {
        sideBarState = previousState;
        [self setState:sideBarState];
    }
    else {
        previousState = sideBarState;
        sideBarState = 4;
        [self sideBarUpdate];
    }
}
- (void) showDetailFromSubView
{
    
    //[[NSNotificationCenter defaultCenter]postNotificationName:@"updateLeftBarBtnStateNormal" object:nil];
    //NSLog(@"NAA %@", navDetail.navigationController.viewControllers);
    internalState = SideBarInternalStateNormal;
    sideBarState = 1;
    [self showHideSideBar];
    
}

- (IBAction) showHideSideBar
{
    if (! [self checkForInternal]) {
        return;
    }
    
    CGRect frame = navDetail.view.frame;
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
    [UIView beginAnimations:@"PostAdvert11" context:(__bridge void *)navDetail.view];
    frame.origin.y = 0.0;
    if(sideBarState == 1) {
        frame.origin.x = 0;
        sideBarState = 0;
        if (button.hidden == NO) {
            [button setHidden:YES];
        }
    }
    else if (sideBarState == 0) 
    {
        
        frame.origin.x = self.view.frame.size.width - cRemainView;
        sideBarState = 1;
        if (button.hidden) {
            button.hidden = NO;
        }
    }    
    navDetail.view.frame = frame;
    [UIView commitAnimations];
    [self sideBarUpdate];
}

- (void) navMove
{
    CGRect frame = navDetail.view.frame;
    [UIView setAnimationDuration:0.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
    [UIView beginAnimations:@"PostAdvert11" context:(__bridge void *)navDetail.view];
    frame.origin.y = 0.0;
    NSNumber *x = [[NSUserDefaults standardUserDefaults] objectForKey:@"PointX"];
    frame.origin.x += x.floatValue;
    if (frame.origin.x < 0 || frame.origin.x > self.view.frame.size.width) {
        frame.origin.x -= x.floatValue;
    }
    navDetail.view.frame = frame;
    [UIView commitAnimations];
    [self sideBarUpdate];
}

- (void) navEndMove
{
    CGRect frame = navDetail.view.frame;
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
    [UIView beginAnimations:@"PostAdvert11" context:(__bridge void *)navDetail.view];
    frame.origin.y = 0.0;
    if(frame.origin.x < self.view.frame.size.width - cRemainView) {
        frame.origin.x = 0;
        sideBarState = 0;
        if (button.hidden == NO) {
            [button setHidden:YES];
        }
    }
    else
    {
        frame.origin.x = self.view.frame.size.width - cRemainView;
        sideBarState = 1;
        if (button.hidden) {
            button.hidden = NO;
        }
    }
    
    navDetail.view.frame = frame;
    [UIView commitAnimations];
    [self updateNavigationBarItem];
}

- (void) speedForNavigationBar{
    
    CGRect frame = navDetail.view.frame;
    [UIView setAnimationDuration:0.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
    [UIView beginAnimations:@"PostAdvert11" context:(__bridge void *)navDetail.view];
    frame.origin.y = 0.0;
    NSNumber *x = [[NSUserDefaults standardUserDefaults] objectForKey:@"speedForNavigationBar"];
    if ([x integerValue] > 0) {
        sideBarState = 1;
        frame.origin.x = self.view.frame.size.width - cRemainView;
        if (button.hidden) {
            button.hidden = NO;
        }
    } 
    else if ([x integerValue] < 0) {
        frame.origin.x = 0;
        sideBarState = 0;
        if (button.hidden == NO) {
            [button setHidden:YES];
        }
    }    
    navDetail.view.frame = frame;
    [UIView commitAnimations];
    [self sideBarUpdate];
    [self updateNavigationBarItem];
}
- (void) hideSideBar
{
    if (sideBarState != 3) {
        previousState = sideBarState;
        CGRect frame = navDetail.view.frame;
        [UIView setAnimationDuration:0.0];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
        [UIView beginAnimations:@"PostAdvert11" context:(__bridge void *)navDetail.view];
        frame.origin.y = 0.0;
        sideBarState = 3;
        frame.origin.x = self.view.frame.size.width + 5.0;
        navDetail.view.frame = frame;
        if (botView.superview) {
            //[botView removeFromSuperview];
        }
        [UIView commitAnimations];
    } else {
        sideBarState = previousState;
        //[navLeft.view addSubview:botView];
        [self setState:sideBarState];
        
    }
    [self sideBarUpdate];
}
- (void) setState:(NSInteger) state
{
    NSLog(@"SideBar %@", self.view);
    CGRect frame = navDetail.view.frame;
    [UIView setAnimationDuration:0.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
    [UIView beginAnimations:@"PostAdvert11" context:(__bridge void *)navDetail.view];
    frame.origin.y = 0.0;
    switch (state) {
        case 01:
            frame.origin.x = self.view.frame.size.width - cRemainView;
            break;
        case 03:
            frame.origin.x = self.view.frame.size.width + 5.0;
            break;
            
        default:
            frame.origin.x = 0;
            break;
    }
    navDetail.view.frame = frame;
    [UIView commitAnimations];
    [self sideBarUpdate];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"sdfdsfs");
    return nil;
}
-(void) enterAddComment
{
    if (sideBarState == 100) {
        sideBarState = previousState;
    }else {
        previousState = sideBarState;
        sideBarState = 100;//sideBarStateAddComment;
    }
    [self sideBarUpdate];
}

-(void) enterWebBrowser
{
    if (sideBarState == 101) {
        sideBarState = previousState;
    }else {
        previousState = sideBarState;
        sideBarState = 101;//sideBarStateAddComment;
    }
    [self sideBarUpdate];
}

-(void) inOutEnlargeImage
{
    if (sideBarState == 102) {
        sideBarState = previousState;
    }else {
        previousState = sideBarState;
        sideBarState = 102;//sideBarStateAddComment;
    }
    [self sideBarUpdate];
}
-(void) inOutComments:(NSNotification*) notification
{
    if (notification) {
        NSNumber *num = [notification.userInfo objectForKey:@"inOutComments"];
        if (num.integerValue == 0) {//Out
            internalState = SideBarInternalStateNormal;
            notification = nil;
            num = nil;
            return;
        }   
        if (num.integerValue == 1) {//IN
            internalState = SideBarInternalStateComments;
            notification = nil;
            num = nil;
            return;
        }   
        
    }
}

#pragma mark - Login List

-(IBAction) onTouchSignInBtn: (id) sender
{
    [self hidePopUpDialog:overlay];
    self.overlay = nil;
    SignInVwCtrl *signInVwCtrl = [[SignInVwCtrl alloc] init];
    [self.navigationController pushViewController:signInVwCtrl animated:YES];
    self.navigationController.navigationBarHidden = YES;
}
-(IBAction) onTouchSignInAnonymouslybtn:(id) sender
{
    NSUserDefaults *database = [NSUserDefaults standardUserDefaults];
    [database setInteger:0 forKey:@"UserID"];
    [database setValue:@"Anonymous" forKey:@"userNamePA"];
    
    [self hidePopUpDialog:overlay];
    didShowListLogin = 1;
    database = nil;
    navDetail.navigationBarHidden = NO;
    sideBarState = 0;
    mainCtr.view.backgroundColor = [UIColor whiteColor];
    [self sideBarUpdate];
    [self setState:previousState];
    [self showHideSideBar];
    
}

-(IBAction) onTouchCreateAccountBtn: (id) sender
{
    [self hidePopUpDialog:overlay];
    self.overlay = nil;
    NewAccountVwCtrl *newAccVwCtrl = [[NewAccountVwCtrl alloc] init];
    [self.navigationController pushViewController:newAccVwCtrl animated:YES];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void) showPopUpDialog:(UIView*) view :(CGPoint) point
{
    if (overlay == nil) {
        overlay = [[UIView alloc]init];
    }
	[overlay addSubview:view];
    
    CGRect rc = [[UIScreen mainScreen] bounds];
    overlay.frame = rc;
    
    rc = view.frame;
	rc.origin = CGPointMake(0.0f, -rc.size.height);
	view.frame = rc;
    
	// Show the overlay
	if (!overlay.superview) 
        [self.view.window addSubview:overlay];
    
    //    UIViewController *modalViewController = [[UIViewController alloc] init];
    //    modalViewController.view = overlay;
    //    [self presentModalViewController:modalViewController animated:YES];
    
	overlay.alpha = 1.0;
	
	// Animate the message view into place
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
	rc.origin = point; //CGPointMake(0.0f, 10.0f);
	view.frame = rc;
    [UIView commitAnimations];
    
    //    [modalViewController release];
}

- (void) hidePopUpDialog:(UIView*) view
{
    CGRect rc = view.frame;
    rc.origin = CGPointMake(0.0f, -rc.size.height);
    
    // Animate the message view away
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
	
	view.frame = rc;
    [UIView commitAnimations];
    
	// Hide the overlay
	[overlay performSelector:@selector(setAlpha:) withObject:nil afterDelay:0.3f];
    [[self modalViewController] dismissModalViewControllerAnimated:NO];
    [view removeFromSuperview];
}

- (UIView*) createLoginListView
{
    UIView* loginListView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 460.0)];
    UIImageView *bgVw = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BG_popup_2.png"]]; /*LoginList_bg.png*/
    bgVw.frame = CGRectMake(8.0, 0.0, 304.0, 450.0);
    [loginListView addSubview:bgVw];
    
    CGRect rc = CGRectMake(45, 56.0, 160.0, 33.0);
    //    UILabel *label1 = [[UILabel alloc] initWithFrame:rc];
    //    label1.textColor = [UIColor whiteColor];
    //    label1.opaque = NO;
    //    label1.backgroundColor = [UIColor clearColor];
    //    label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:30.0];
    //    label1.text = @"PostAdvert";
    //    [loginListView addSubview:label1];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    //imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = rc;
    [loginListView addSubview:imageView];
    
    
    
    rc = CGRectMake(39.0, 106.0, 150.0, 45.0);
    UITextView *txtVw = [[UITextView alloc] init];
    txtVw.frame = rc;
    txtVw.font = [UIFont fontWithName:@"Helvetica" size:13.0];
    txtVw.backgroundColor = [UIColor clearColor]; 
    txtVw.opaque = NO;
    txtVw.textColor = [UIColor whiteColor];
    txtVw.userInteractionEnabled = NO;
    txtVw.text = @"Comprehensive\nCome join us now!";
    [loginListView addSubview:txtVw];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(45.0, 168.0, 228.0, 37.0);
    [btn1.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:15.0]];
    [btn1 setTitle:@"Sign In" forState:UIControlStateNormal];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"button_border.png"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(onTouchSignInBtn:) forControlEvents:UIControlEventTouchUpInside];
    [loginListView addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(45.0, 223.0, 228.0, 37.0);
    [btn2.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:15.0]];
    [btn2 setTitle:@"Create Account" forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"button_border.png"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(onTouchCreateAccountBtn:) forControlEvents:UIControlEventTouchUpInside];
    [loginListView addSubview:btn2];
    
    //    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn3.frame = CGRectMake(45.0, 272.0, 228.0, 37.0);
    //    [btn3.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:15.0]];
    //    [btn3 setTitle:@"Create Account" forState:UIControlStateNormal];
    //    [btn3 setBackgroundImage:[UIImage imageNamed:@"button_border.png"] forState:UIControlStateNormal];
    //    [btn3 addTarget:self action:@selector(onTouchCreateAccountBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    [loginListView addSubview:btn3];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(90.0, 357, 160, 37.0);
    [btn5.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13.0]];
    [btn5 setTitle:@"www.PostAdvert.com" forState:UIControlStateNormal];
    //[btn5 setBackgroundImage:[UIImage imageNamed:@"button_border.png"] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(navigatePostAdvertWithBrowser:) forControlEvents:UIControlEventTouchUpInside];
    [loginListView addSubview:btn5];
    return loginListView;
}

- (void)navigatePostAdvertWithBrowser:(id) sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"Localhost"]];
}
-(void) logOutListener
{
    if (navLeft.view.hidden == NO) {
        navLeft.view.hidden = YES;
    }
    if (navDetail.view.hidden == NO) {
        navDetail.view.hidden = YES;
    }
    didShowListLogin = 0;
    [UserPAInfo sharedUserPAInfo].registrationID = 0;
    NSUserDefaults *database = [[NSUserDefaults alloc]init];
    [database setValue:@"" forKey:@"passwordPA"];
    [database synchronize];
    [self setState:0];
    [self viewWillAppear:YES];
}

- (BOOL) checkForInternal
{
    switch (internalState) {
        case SideBarInternalStateNormal:
            return YES;
            break;
        
        case SideBarInternalStateComments:
            return NO;
            break;
            
        case SideBarInternalStateCurrent:
            return YES;
            break;
            

        default:
            break;
    }
    return YES;
}

#pragma mark - NavigationBar
- (void) updateNavigationBarItem
{
    switch (internalState) {
        case SideBarInternalStateNormal:
            
            break;
        case SideBarInternalStateComments:
            if (sideBarState == 1) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"updateLeftBarBtnStateSideBar" object:nil];
            }else if(sideBarState == 0)  {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"updateLeftBarBtnStateNormal" object:nil];           
                NSLog(@"S %d S0 %d", sideBarState, internalState);
            }
            break;
        default:
            break;
    }
    
}

#pragma mark - Listenner

- (void) setSideBarForState:(NSNotification*)notifi
{
    NSNumber *state = [notifi.userInfo objectForKey:@"setSideBarForState"];
    internalState = SideBarInternalStateNormal;
    CGRect frame = navDetail.view.frame;
    [UIView setAnimationDuration:0.01];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
    [UIView beginAnimations:@"PostAdvert11" context:(__bridge void *)navDetail.view];
    frame.origin.y = 0.0;
    switch (state.integerValue) {
        case 01:
            frame.origin.x = self.view.frame.size.width - cRemainView;
            break;
        case 03:
            frame.origin.x = self.view.frame.size.width + 5.0;
            break;
            
        default:
            frame.origin.x = 0;
            break;
    }
    navDetail.view.frame = frame;
    [UIView commitAnimations];
    sideBarState = state.integerValue;
    [self sideBarUpdate];

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
            previousPoint = [gesture translationInView:gesture.view.superview];
            //[lastTimes insertObject:[NSNumber numberWithDouble:[gesture timestamp]] atIndex:0];
            break;
        case UIGestureRecognizerStateChanged:
        {
            NSNumber *num = [NSNumber numberWithFloat:[gesture translationInView:gesture.view.superview].x - previousPoint.x];
            previousPoint = [gesture translationInView:gesture.view.superview];
            [[NSUserDefaults standardUserDefaults] setObject:num forKey:@"PointX"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"navMove" object:nil];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint velocity = [gesture velocityInView:self.view];
            CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
            
            NSLog(@" X:%f, Y%f, magnitue:%f", velocity.x, velocity.y, magnitude);
            if (magnitude > cMinSpeedPermit) {
                NSInteger direction = [(NSNumber*)[[NSUserDefaults standardUserDefaults] objectForKey:@"PointX"] integerValue];
                direction = direction > 0 ? 1 : 0;
                NSNumber *num = [NSNumber numberWithInteger:direction];
                NSDictionary *dict = [NSDictionary dictionaryWithObject:num forKey:@"setSideBarForState"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"setSideBarForState" object:nil userInfo:dict];
                num = nil;
                dict = nil;
            }else {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"navEndMove" object:nil];
            }
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - GestureRecognizer Delegate
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    NSLog(@" %@ %@", NSStringFromClass([gestureRecognizer class]), NSStringFromClass([otherGestureRecognizer class]));
    return NO;
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

@end
