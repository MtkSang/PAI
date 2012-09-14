//
//  DetailViewController.m
//  PostAdvert11
//
//  Created by Ray Mtk on 18/4/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import "DetailViewController.h"
#import "SignInVwCtrl.h"
#import "NewAccountVwCtrl.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>
#import "UIPostCell.h"
#import "PostCellContent.h"
#import "BrowserViewController.h"
#import "UserPAInfo.h"
#import "CommentsCellContent.h"
#import "SBJson.h"
#import "GobalMessageViewController.h"
#import "FlagViewController.h"
#import "ChatViewController.h"
#import "MessageCellContent.h"
#import "GlobalNotificationsViewController.h"
//#import "NotificationsCellContent.h"
#import "DetailNotificationViewController.h"
#import "CommentsViewController.h"
#import "GlobalAlertViewController.h"
#import "ActivityViewController.h"
#import "PostadvertControllerV2.h"
#import "UITablePostViewController.h"
#import "SupportFunction.h"
#import "Userprofile/UserProfileViewController.h"
@interface DetailViewController ()
- (void) showDetailFromSubView:(NSNotification*)notifi;
- (IBAction)showHideSidebar:(id)sender;
- (IBAction)buttonPostClicked:(id)sender;
- (void) newPostAddListenner;
- (void) newPostWithOutData;
- (void) newPostWithData;
- (void) onTouchGolbalMessage:(id) sender;
- (void) onTouchGlobalNotifications:(id) sender;
- (void) reloadTableView;
- (void) loadCells;
- (void) showUserProfile;
- (void) showFavoriteWithInfo:(NSNotification*)notifi;

@end

@implementation DetailViewController

@synthesize leftViewController;
@synthesize overlay;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize myTableView;
@synthesize lbTitle;
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
    isEnterAddComment = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailFromSubView:) name:@"showDetailFromSubView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailFromLeftView:) name:@"showDetailFromLeftView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterAddComment) name:@"enterAddComment" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openURL) name:@"openURL" object:nil];
    //Left Button Bar Item to sidebar
    UIButton *abutton = [[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0, 30, 30)];
    [abutton setImage:[UIImage imageNamed:@"list_btn.png"] forState:UIControlStateNormal];
    [abutton addTarget:self action:@selector(showHideSidebar:) forControlEvents:UIControlEventTouchUpInside];
    [abutton setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:abutton];
    //self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftBarItem, nil];
    abutton = nil;

//    //TableView
//    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, cCellHeight , self.view.frame.size.width, self.view.frame.size.height  - cCellHeight) style:UITableViewStyleGrouped];
//   if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
//       myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, cCellHeight , self.view.frame.size.width, self.view.frame.size.height  - cCellHeight) style:UITableViewStyleGrouped];
//   }else
//   {
//       myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, cCellHeight , self.view.frame.size.width, self.view.frame.size.height  - cCellHeight) style:UITableViewStylePlain];
//   }
//    myTableView.delegate = self;
//    myTableView.dataSource = self;
//    myTableView.allowsSelection = NO;
//    myTableView.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:235.0/255.0 blue:245.0/255.0 alpha:1];
//    [myTableView setAutoresizesSubviews:YES];
//    [myTableView setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
//    [myTableView setAutoresizesSubviews:YES];
//    //myTableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg_sub.png"]];
//    
//    [topView addSubview:myTableView];
    
    
    
    
    //Setting for Subview
    [self.view setAutoresizesSubviews:YES];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    if (customViewCtr == nil) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            customViewCtr = [[ActivityViewController alloc] initWithStyle:UITableViewStyleGrouped];
        }else
        {
            customViewCtr = [[ActivityViewController alloc] init];
        }
    }
    else {
        if (![customViewCtr isKindOfClass:[ActivityViewController class]]) {
            customViewCtr = nil;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
                customViewCtr = [[ActivityViewController alloc] initWithStyle:UITableViewStyleGrouped];
            }else
            {
                customViewCtr = [[ActivityViewController alloc] init];
            }
        }
    }
    
    //[self.overlay addSubview: customViewCtr.view];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showDetailFromSubView_SideBar" object:nil];

}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
//    myTableView = nil;
//    lbTitle = nil;
//    button = nil;
//    overlay = nil;
//    listCells = nil;
//    HUD = nil;
//    btnPost = nil;
//    topView = nil;
    
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemoryWarning");
}
//- (void)sendImage {
//    NSData *postData = UIImagePNGRepresentation([UIImage imageNamed:@"bg_1.png"]);
//    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//    
//    // Init and set fields of the URLRequest
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setHTTPMethod:@"POST"];
//    [request setURL:[NSURL URLWithString:[NSString stringWithString:@"http://yoururl.domain"]]];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    [request setHTTPBody:postData];
//    
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    if (connection) {
//        // Return data of the request
//        // NSData *receivedData = [NSMutableData data];
//    }
//    request = nil;
//}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGRect navFrame = self.navigationController.navigationBar.frame;
    if (topMenu == nil) {
        topMenu = [self drawPostAdvertTopMenu];
        [self.navigationController.navigationBar addSubview:topMenu];
    }
    
    //TopView
    if (topView == nil) {
        topView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0,self.view.frame.size.width , self.view.frame.size.height)];
    }else
        topView.frame = CGRectMake(0.0, 0.0,self.view.frame.size.width , self.view.frame.size.height);
    
    topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg_right.png"]];
    [topView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
    [topView setAutoresizesSubviews:YES];
    //post button
    if (btnPost) {
         btnPost.frame = CGRectMake(self.view.frame.size.width - 100, 0.0, 100 , cCellHeight);
    }else
        btnPost = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 0.0, 100 , cCellHeight)];
    [btnPost setTitle:@"New Post" forState:UIControlStateNormal];
    [btnPost.titleLabel setFont:[UIFont fontWithName:FONT_NAME size:FONT_TITLE_SIZE]];
    [btnPost addTarget:self action:@selector(buttonPostClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnPost.backgroundColor = topView.backgroundColor;
    [btnPost setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    //Title
    if (lbTitle) {
        lbTitle.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width - btnPost.frame.size.width, cCellHeight);
    }else
        lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width - btnPost.frame.size.width, cCellHeight)];
    
    lbTitle.textColor = [UIColor whiteColor];
    [lbTitle setFont:[UIFont fontWithName:FONT_NAME size:FONT_TITLE_SIZE]];
    lbTitle.backgroundColor = [UIColor clearColor];
    [topView addSubview:lbTitle];
    [topView addSubview:btnPost];
    //[self embedYouTubeWithURLString:@""];
    if (topMenu.superview == nil) {
        //[topMenu removeFromSuperview];
        [self.navigationController.navigationBar addSubview:topMenu];
    }
    //Setting for Overlay
    if (self.overlay == nil) {
        self.overlay = [[UIView alloc] init];
    }
    self.overlay.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height - navFrame.size.height);
    //[self.view addSubview:self.overlay];
    
    [self.overlay setFrame:self.view.frame];
    if (overlay.superview == nil) {
        [self.view addSubview:overlay];
    }
    NSLog(@"%@", lbTitle.text);
    if ([lbTitle.text isEqualToString: @""] || lbTitle.text == nil) {
        
        if ([customViewCtr isKindOfClass:[ActivityViewController class]]) {
            CGRect frame = self.overlay.frame;
            frame.origin.y = cCellHeight;
            frame.size.height = frame.size.height - cCellHeight;
            customViewCtr.view.frame = frame;
            [topView addSubview:customViewCtr.view];
            
            [self.overlay addSubview: topView];
            lbTitle.text = @"  Status Updates";
        }
        
    }
    self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.overlay.autoresizesSubviews = YES;
    
    HUD = [[MBProgressHUD alloc]initWithView:self.overlay];
    [HUD setMinSize:CGSizeMake(150, 100) ];
    HUD.backgroundColor = [UIColor clearColor];
    HUD.delegate = self;
    NSLog(@"Overlay %@ \n Self %@", overlay, self.view);
}

//#if EXPERIEMENTAL_ORIENTATION_SUPPORT

// Doesn't support rotating to other orientation at this moment
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    _containerOrigin = self.navigationController.view.frame.origin;
//}
//
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (myTableView.superview) {
        [myTableView reloadData];
    }
}
//
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    NSLog(@"%@ Frame: %f %f %f %f", self , self.overlay.frame.size.width, self.overlay.frame.size.height, customViewCtr.view.frame.size.width, customViewCtr.view.frame.size.height);
    if (popoverController) {
        CGRect frame = viewUseToGetRectPopover.frame;
        CGRect bounds = viewUseToGetRectPopover.bounds;
        CGRect rect = [viewUseToGetRectPopover convertRect:viewUseToGetRectPopover.frame toView:nil];
        CGRect supperBounds = [viewUseToGetRectPopover.superview bounds];
         CGRect rect1 = [viewUseToGetRectPopover convertRect:viewUseToGetRectPopover.frame toView:self.navigationController.navigationBar];
        CGPoint center ;
        
        center.x = frame.origin.x + bounds.size.width / 2.0 + supperBounds.size.width / 2.0;
        center.y = frame.origin.y + bounds.size.height / 2.0 + supperBounds.size.height / 2.0;
        rect1.size.width = 1;
        rect.size = (CGSize){1,1};
        rect.origin = center;
        [popoverController repositionPopoverFromRect:rect inView:self.navigationController.view permittedArrowDirections:UIPopoverArrowDirectionUp];
        
        
        
        NSLog(@"%@ Frame: %f %f %f %f", self , self.overlay.frame.size.width, self.overlay.frame.size.height, customViewCtr.view.frame.size.width, customViewCtr.view.frame.size.height);

    }
}
//
//- (NSString *)description {
//    NSString *logMessage = [NSString stringWithFormat:@"MainViewController {"];
//    logMessage = [logMessage stringByAppendingFormat:@"\n\t%@", self.view];
//    logMessage = [logMessage stringByAppendingFormat:@"\n\t%@", self.navigationController.view];
//    logMessage = [logMessage stringByAppendingFormat:@"\n\t%@", self.leftSidebarViewController.view];
//    logMessage = [logMessage stringByAppendingFormat:@"\n\t%@", self.rightSidebarView];
//    logMessage = [logMessage stringByAppendingFormat:@"\n\t%@", self.navigationController.navigationBar];
//    logMessage = [logMessage stringByAppendingFormat:@"\n\t <statusBarFrame> %@", NSStringFromCGRect([[UIApplication sharedApplication] statusBarFrame])];
//    logMessage = [logMessage stringByAppendingFormat:@"\n\t <applicationFrame> %@", NSStringFromCGRect([[UIScreen mainScreen] applicationFrame])];
//    logMessage = [logMessage stringByAppendingFormat:@"\n\t <preferredViewFrame> %@", NSStringFromCGRect(self.navigationController.applicationViewFrame)];
//    logMessage = [logMessage stringByAppendingFormat:@"\n}"];
//    return logMessage;
//}
//
//#endif

#pragma mark -Implement ACTION
- (void) onTouchGolbalMessage:(id) sender
{
    if (popoverController) {
		[popoverController dismissPopoverAnimated:YES];
		popoverController = nil;
        viewUseToGetRectPopover = nil;
        [self removeDetailMessageListenner:self];
	} else {
        //Add listenner to get data when user choice from Global Message
        [self addDetailMessageListenner:self];
        viewUseToGetRectPopover = (UIView*)sender;
        GobalMessageViewController *contentViewController = [[GobalMessageViewController alloc] init];
        contentViewController.navigationController = self.navigationController;
		//CGRect rect = CGRectMake((self.view.frame.size.width / 2.0) , -014.0,((UIView*)sender).frame.size.width + 11,1);
        CGRect rect = CGRectMake((self.view.frame.size.width / 2.0) , -01.0,((UIView*)sender).frame.size.width + 5,40);
        contentViewController.view.layer.cornerRadius = 3.0;
        //contentViewController.contentSizeForViewInPopover = CGSizeMake(280, 460);
        contentViewController.tableView.layer.cornerRadius = 3.0;
        //contentViewController.contentSizeForViewInPopover = CGSizeMake(260, 390);
		popoverController = [[WEPopoverController alloc] initWithContentViewController:(UIViewController*)contentViewController];
		
		if ([popoverController respondsToSelector:@selector(setContainerViewProperties:)]) {
			[popoverController setContainerViewProperties:[self defaultContainerViewProperties]];
		}
		
		popoverController.delegate = self;
		popoverController.passthroughViews = [NSArray arrayWithObject:self.view];
		[popoverController presentPopoverFromRect:rect  
                                           inView:self.navigationController.view
                         permittedArrowDirections:(UIPopoverArrowDirectionUp)
                                         animated:YES];
    }
    
}

- (void) onTouchGlobalNotifications:(id)sender
{
    if (popoverController) {
		[popoverController dismissPopoverAnimated:YES];
		popoverController = nil;
        viewUseToGetRectPopover = nil;
        //[self removeDetailMessageListenner];
	} else {
        //Add listenner to get data when user choice from Global Message
        //[self addDetailMessageListenner];
        viewUseToGetRectPopover = (UIView*)sender;
        GlobalNotificationsViewController *contentViewController = [[GlobalNotificationsViewController alloc] init];
        contentViewController.delegate = self;
		//CGRect rect = CGRectMake((self.view.frame.size.width / 2.0) , -014.0,((UIView*)sender).frame.size.width + 11,1);
        CGRect rect = CGRectMake((self.view.frame.size.width / 2.0) , -01.0,01,40);
        contentViewController.view.layer.cornerRadius = 3.0;
        //contentViewController.contentSizeForViewInPopover = CGSizeMake(280, 460);
        contentViewController.tableView.layer.cornerRadius = 3.0;
        //contentViewController.contentSizeForViewInPopover = CGSizeMake(260, 390);
		popoverController = [[WEPopoverController alloc] initWithContentViewController:(UIViewController*)contentViewController];
		
		if ([popoverController respondsToSelector:@selector(setContainerViewProperties:)]) {
			[popoverController setContainerViewProperties:[self defaultContainerViewProperties]];
		}
		
		popoverController.delegate = self;
		popoverController.passthroughViews = [NSArray arrayWithObject:self.view];
		[popoverController presentPopoverFromRect:rect  
												inView:self.navigationController.view
							  permittedArrowDirections:(UIPopoverArrowDirectionUp)
											  animated:YES];
    }

}

- (void) onTouchGlobalAlert:(id)sender
{
    if (popoverController) {
		[popoverController dismissPopoverAnimated:YES];
		popoverController = nil;
        viewUseToGetRectPopover = nil;
        //[self removeDetailMessageListenner];
	} else {
        //Add listenner to get data when user choice from Global Message
        //[self addDetailMessageListenner];
        viewUseToGetRectPopover = (UIView*)sender;
        GlobalAlertViewController *contentViewController = [[GlobalAlertViewController alloc] init];
        contentViewController.delegate = self;
        CGRect rect = CGRectMake((self.view.frame.size.width / 2.0) - (2*((UIView*)sender).frame.size.width), -01.0,((UIView*)sender).frame.size.width,40);
        contentViewController.view.layer.cornerRadius = 3.0;
        contentViewController.tableView.layer.cornerRadius = 3.0;
		popoverController = [[WEPopoverController alloc] initWithContentViewController:(UIViewController*)contentViewController];
		
		if ([popoverController respondsToSelector:@selector(setContainerViewProperties:)]) {
			[popoverController setContainerViewProperties:[self defaultContainerViewProperties]];
		}
		
		popoverController.delegate = self;
		popoverController.passthroughViews = [NSArray arrayWithObject:self.view];
		[popoverController presentPopoverFromRect:rect  
                                           inView:self.navigationController.view
                         permittedArrowDirections:(UIPopoverArrowDirectionUp)
                                         animated:YES];
    }
    
}


-(BOOL) isYoutubeVideoLink:(NSURL*)url
{
    NSURL *newURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://www.youtube.com/oembed?url=%@&format=json",[url absoluteString]]];
    
    NSLog(@"youtubeInfoLink %@",[newURL absoluteString]);
    NSString *youtubeInfo = [NSString stringWithContentsOfURL:newURL encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"youtubeInfo %@",youtubeInfo);
    NSDictionary *dic = [youtubeInfo JSONValue];
    NSLog(@"Dic %@", dic);
    if ( [((NSString*)[dic valueForKey:@"type"])isEqualToString:@"video"]) {
        newURL = nil;
        return YES;
    }
    newURL =nil;
    return NO;
}
- (void)embedYouTubeWithURLString:(NSString *)urlStr {
    urlStr = @"http://www.youtube.com/watch?v=DpwdwC6RKYY&feature=g-vrec";
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    CGFloat w = webView.frame.size.width;
    CGFloat h = webView.frame.size.height;
    NSString *embed = [NSString stringWithFormat:@"<html><head><meta name=\"viewport\""\
                       " content=\"initial-scale=1.0, user-scalable=no, width=%0.0f\"/></head><body "\
                       "style=\"background-color:transparent;margin-top:0px;margin-left:0px\"><div><object "\
                       "width=\"%0.0f\" height=\"%0.0f\"><param name=\"movie\" value=\"%@\" /><param name=\"wmode"\
                       "\"value=\"transparent\" /><param name=\"allowFullScreen\" value=\"true\" /><param"\
                       " name=\"quality\" value=\"high\" /><embed src=\"%@\" type=\"application/x-shockwave-flash"\
                       "\" allowfullscreen=\"true\" wmode=\"transparent\" width=\"%0.0f\" height=\"%0.0f\" />"\
                       "</object></div></body></html>", w, w, h, urlStr, urlStr, w, h];
    [webView loadHTMLString:embed baseURL:nil];
    [self.view addSubview:webView];
    
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
    //[bgVw release];
    
    CGRect rc = CGRectMake(45.0, 82.0, 200.0, 35.0);
    UILabel *label1 = [[UILabel alloc] initWithFrame:rc];
    label1.textColor = [UIColor whiteColor];
    label1.opaque = NO;
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:30.0];
    label1.text = @"PostAdvert";
    [loginListView addSubview:label1];
    //[label1 release];
    
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
    //[txtVw release];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(45.0, 165.0, 228.0, 37.0);
    [btn1.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:15.0]];
    [btn1 setTitle:@"Sign In" forState:UIControlStateNormal];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"button_border.png"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(onTouchSignInBtn:) forControlEvents:UIControlEventTouchUpInside];
    [loginListView addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(45.0, 220.0, 228.0, 37.0);
    [btn2.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:15.0]];
    [btn2 setTitle:@"Create Account" forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"button_border.png"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(onTouchCreateAccountBtn:) forControlEvents:UIControlEventTouchUpInside];
    [loginListView addSubview:btn2];
    
    //    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn3.frame = CGRectMake(45.0, 255.0, 228.0, 37.0);
    //    [btn3.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:15.0]];
    //    [btn3 setTitle:@"Use ET Account" forState:UIControlStateNormal];
    //    [btn3 setBackgroundImage:[UIImage imageNamed:@"button_border.png"] forState:UIControlStateNormal];
    //    [btn3 addTarget:self action:@selector(onTouchLogOnETBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    [loginListView addSubview:btn3];
    //    
    //    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn4.frame = CGRectMake(45.0, 300, 228.0, 37.0);
    //    [btn4.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:15.0]];
    //    [btn4 setTitle:@"Use Facebook Account" forState:UIControlStateNormal];
    //    [btn4 setBackgroundImage:[UIImage imageNamed:@"button_border.png"] forState:UIControlStateNormal];
    //    [btn4 addTarget:self action:@selector(onTouchLogOnFBBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    [loginListView addSubview:btn4];
    //    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(90.0, 357, 160, 37.0);
    [btn5.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13.0]];
    [btn5 setTitle:@"www.PostAdvert.com" forState:UIControlStateNormal];
    //[btn5 setBackgroundImage:[UIImage imageNamed:@"button_border.png"] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(navigatePostAdvertWithBrowser:) forControlEvents:UIControlEventTouchUpInside];
    [loginListView addSubview:btn5];
    
    return loginListView;
}

-(IBAction) onTouchSignInBtn: (id) sender
{
    //PalUpController   *palUpCtrl = (PalUpController *)cAppiPhoneDelegate.palUpController; 
    //Mtk Hide 
    [self hidePopUpDialog:overlay];
    //self.listLogInView = nil;
    self.overlay = nil;
    //SignInVwCtrl *signInVwCtrl = [[SignInVwCtrl alloc] initWithPostAdvertController:nil];
    SignInVwCtrl *signInVwCtrl = [[SignInVwCtrl alloc] init];
    
    [self.navigationController pushViewController:signInVwCtrl animated:YES];
}

-(IBAction) onTouchCreateAccountBtn: (id) sender
{
    [self hidePopUpDialog:overlay];
    //self.listLogInView = nil;
    self.overlay = nil;
    //NewAccountVwCtrl *newAccVwCtrl = [[NewAccountVwCtrl alloc] initWithPostAdvertController:nil];
    NewAccountVwCtrl *newAccVwCtrl = [[NewAccountVwCtrl alloc] init];
    [self.navigationController pushViewController:newAccVwCtrl animated:YES];
    
}
-(IBAction)onTouchCountry:(id)sender{
    [self hidePopUpDialog:overlay];
    //self.listLogInView = nil;
    self.overlay = nil;
    //NewAccountVwCtrl *newAccVwCtrl = [[NewAccountVwCtrl alloc] initWithPostAdvertController:nil];
    NewAccountVwCtrl *newAccVwCtrl = [[NewAccountVwCtrl alloc] init];
    [self.navigationController pushViewController:newAccVwCtrl animated:YES];
}

- (void)navigatePostAdvertWithBrowser:(id) sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", @"www.postAdvert.com"]]];
}

- (IBAction)showHideSidebar:(id)sender {
     [[NSNotificationCenter defaultCenter] postNotificationName:@"showhidesidebar" object:nil];
}



-(IBAction)buttonClinked:(id)sender{
    UIViewController *nextSideController = [[UIViewController alloc] init];
    nextSideController.view.frame = self.view.frame;
    nextSideController.view.backgroundColor =[UIColor grayColor];
    [self.navigationController pushViewController:nextSideController animated:YES];
    nextSideController.navigationController.navigationBarHidden = NO;
    
    
}

- (IBAction)buttonPostClicked:(id)sender// Show POST View
{
    //[self performSelector:@selector(showNewPost) withObject:nil afterDelay:0.0];
    [self showNewPost];
    
}

- (void) showNewPost
{
    {
        PostViewController *postViewCtr = [[PostViewController alloc] init];
        [self newPostAddListenner];
        [self.navigationController presentModalViewController:postViewCtr animated:YES];
        postViewCtr = nil;
    }
}

- (UIView*) drawPostAdvertTopMenu {
    UIView *menu = [[UIView alloc]init];
    [menu setBackgroundColor:[UIColor clearColor]];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:[UIImage imageNamed:@"notification_1.png"] forState:UIControlStateNormal];
    [btn1 sizeToFit];
    [btn1 addTarget:self action:@selector(onTouchGlobalAlert:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];;
    [btn2 setImage:[UIImage imageNamed:@"notification_2.png"] forState:UIControlStateNormal];
    [btn2 sizeToFit];
    [btn2 addTarget:self action:@selector(onTouchGlobalNotifications:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];;
    [btn3 setImage:[UIImage imageNamed:@"notification_3.png"] forState:UIControlStateNormal];
    [btn3 sizeToFit];
    [btn3 addTarget:self action:@selector(onTouchGolbalMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    float x = 0.0;
    btn1.frame = CGRectMake(0.0, self.navigationController.navigationBar.frame.size.height/4, self.navigationController.navigationBar.frame.size.height/2, self.navigationController.navigationBar.frame.size.height /2);
    x += btn1.frame.size.width + 10;
    btn2.frame = CGRectMake(x , self.navigationController.navigationBar.frame.size.height/4, self.navigationController.navigationBar.frame.size.height/2, self.navigationController.navigationBar.frame.size.height/2);
    x +=  btn2.frame.size.width + 10; 
    btn3.frame = CGRectMake( x , self.navigationController.navigationBar.frame.size.height/4, self.navigationController.navigationBar.frame.size.height/2, self.navigationController.navigationBar.frame.size.height/2);
    x +=  btn3.frame.size.width;
    menu.frame= CGRectMake((self.view.frame.size.width - x) / 2.0, 0.0, x, self.navigationController.navigationBar.frame.size.height);
    [menu addSubview:btn1];
    [menu addSubview:btn2];
    [menu addSubview:btn3];
    
    btn1 = nil;
    btn2 = nil;
    btn3 = nil;
    //Set autoresize MAzk
    menu.autoresizesSubviews = YES;
    [menu setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
    for (UIView *view in menu.subviews) {
        [view setAutoresizingMask:menu.autoresizingMask];
    }
    menu.autoresizingMask = menu.autoresizingMask | UIViewAutoresizingFlexibleLeftMargin;
    
    return menu;
}
- (void) loadCells
{
//    NSString* wallId = @"1";
//    NSString* start = @"0";
//    NSString* count =@"4";
    //listContent = [[PostadvertControllerV2 sharedPostadvertController] getPostsWithWall:wallId from:start andCount: count] ;
//    NSLog(@"User %@", [UserPAInfo sharedUserPAInfo].usernamePU);
//    [self.myTableView addSubview:HUD];
//    if (!listCells) {
//        listCells = [[NSMutableArray alloc] init];
//        listContent = [[NSMutableArray alloc]init ];
//    }
//    
//    [listCells removeAllObjects];
//    UIPostCell * aCell = [[UIPostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UIPostCell_Landscape"];
//    aCell.navigationController = self.navigationController;
//    PostCellContent *cellContent = [[PostCellContent alloc] init];
//    cellContent.userAvatar = [[UserPAInfo sharedUserPAInfo]imgAvatar];
//    cellContent.userPostName = [[UserPAInfo sharedUserPAInfo]usernamePU];
//    cellContent.text = @"This is a normal text \n However, in view that the new iPhone \"5\" to be launched later this year will be using a bigger screen size, we should therefore not split the horizontal display layout into 2 equal halves, but give much more space to the Main Menu (and a little space to the Full Posts Listing Screen whereby only the \"Button with the lines in it\" is shown as a vertical column). \nhttp://www.w3schools.com/\nhttp://www.youtube.com/watch?v=53Sr4Ori-AI";
//    [cellContent.listVideos addObject:@"http://www.youtube.com/watch?v=53Sr4Ori-AI"];
//    
//    [cellContent.listLinks addObject:@"http://www.w3schools.com"];
//    if (!cellContent.listImages) {
//        cellContent.listImages = [[NSMutableArray alloc] init];
//    }
//    
//    
//    for (int i =1; i<06; i++) {
//        
//        [cellContent.listImages addObject:[UIImage imageNamed:@"temp1.jpg"]];
//        [cellContent.listImages addObject:[UIImage imageNamed:@"temp2.jpg"]];
//        [cellContent.listImages addObject:[UIImage imageNamed:@"temp3.jpg"]];
//        [cellContent.listImages addObject:[UIImage imageNamed:@"temp4.jpg"]];
//        [cellContent.listImages addObject:[UIImage imageNamed:@"temp5.jpg"]];   
//        [cellContent.listImages addObject:[UIImage imageNamed:@"temp6.jpg"]];
//        
//    }
//    cellContent.totalClap = 2;
//    CommentsCellContent *commnet = [[CommentsCellContent alloc] init];
//    commnet.userPostName = @"Friend";
//    commnet.text = @"Hi Wender, They are beautiful. Could I get them?";
//    [cellContent.listComments addObject:commnet];
//    commnet = nil;
//    CommentsCellContent *commnet2 = [[CommentsCellContent alloc] init];
//    commnet2.userPostName = @"Wender";
//    commnet2.text = @"Of couse, my friend.\nFeel free to copy";
//    [cellContent.listComments addObject:commnet2];
//    commnet2 = nil;
//    CommentsCellContent *commnet3 = [[CommentsCellContent alloc] init];
//    commnet3.userPostName = @"David";
//    commnet3.text = @"This is my testing. It is processing. Percentage is 75%. It needs to add bottom view and top view. User can comment by using bot view. This view includes: text view and send button.";
//    [cellContent.listComments addObject:commnet3];
//    commnet3 = nil;
//
//    cellContent.totalComment += 3;
//    aCell.content = cellContent;
//    //[aCell drawContent];
//    [listCells addObject:aCell];
//    [listContent addObject:cellContent];
//    
//    UIPostCell * bCell = [[UIPostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UIPostCell_Landscape"];
//    bCell.navigationController = self.navigationController;
//    PostCellContent *bcellContent = [[PostCellContent alloc] init];
//    bcellContent.userAvatar = [UIImage imageNamed:@"use01.png"];
//    bcellContent.userPostName = @"NewUserName";
//    bcellContent.text = @"This is a testing";
//    if (!bcellContent.listImages) {
//        bcellContent.listImages = [[NSMutableArray alloc] init];
//    }
//    [bcellContent.listImages addObject:[UIImage imageNamed:@"icon_fb.png"]];
//    //[cellContent.listImages addObject:[UIImage imageNamed:@"icon_find.png"]];
//    [bcellContent.listImages addObject:[UIImage imageNamed:@"button_up_talk_1.png"]];
//    [bcellContent.listImages addObject:[UIImage imageNamed:@"temp1.jpg"]];
//    [bcellContent.listImages addObject:[UIImage imageNamed:@"temp2.jpg"]];
//    [bcellContent.listImages addObject:[UIImage imageNamed:@"temp3.jpg"]];
//    [bcellContent.listImages addObject:[UIImage imageNamed:@"temp4.jpg"]];
//    [bcellContent.listImages addObject:[UIImage imageNamed:@"temp5.jpg"]];   
//    [bcellContent.listImages addObject:[UIImage imageNamed:@"temp6.jpg"]];
//    
//    //[cellContent.listImages addObject:[UIImage imageNamed:@"TEMP.png"]];
//    for (int i =1; i<9; i++) {
//        
//        //[bcellContent.listImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"temp$d.jpg",i]]];
//        
//    }
//    bCell.content = bcellContent;
//    //[bCell drawContent];
//    
//    [listCells addObject:bCell];
//    [listContent addObject:bcellContent];
//    NSLog(@"List %@", listCells);
//    
//    //aCell = nil;
//    cellContent =nil;
//    bcellContent =nil;
    [HUD hide:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"reloadTableView" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:nil];
    //[self.myTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    //[self.myTableView reloadData];
    //[self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (BOOL) openURL
{
    NSURL *url = [[NSUserDefaults standardUserDefaults] URLForKey:@"openURL"];
    NSLog(@"URL2 %@", url);
    BrowserViewController *bvc = [[BrowserViewController alloc] initWithUrls:url];
    //self.navController.navigationBarHidden = NO;
    //[_mainViewController.navigationController pushViewController:bvc animated:YES];
    //[[SideBarViewController instanceSideBar].navLeft.navigationController pushViewController:bvc animated:YES];
    //[[SideBarViewController instanceSideBar].navDetail.navigationController pushViewController:bvc animated:YES];
    
    [self.navigationController pushViewController:bvc animated:YES];
    bvc = nil;
    return YES;
}

- (void) enterAddComment
{
    //Replace Remove/AddSubview by setHide
    if (!isEnterAddComment) {
        if (topMenu.superview) {
            
            [topMenu removeFromSuperview];
        }else {
            
            [self.navigationController.navigationBar addSubview:topMenu];
        }
    }
    isEnterAddComment = !isEnterAddComment;
    
}

- (void) animationView: (UIView*) view
{
    CGRect frame = view.frame;
    CGFloat x = frame.origin.x;
    int a = 6;
    for (int i =0; i < 1; i++) {
        [UIView setAnimationDuration:10.91];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
        [UIView beginAnimations:@"PostAdvert11" context:(__bridge void *)view];
        frame.origin.x = x - a;
        view.frame = frame;
        [UIView commitAnimations];
        
        [UIView setAnimationDuration:10.91];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
        [UIView beginAnimations:@"PostAdvert11" context:(__bridge void *)view];
        frame.origin.x = x + a;
        view.frame = frame;
        [UIView commitAnimations];
        
    }
    frame.origin.x = x;
    view.frame = frame;
}
- (void) reloadTableView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadTableView" object:nil];
    [self.myTableView reloadData];
    if (listContent.count) {
        [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark - Listenner
- (void) addDetailMessageListenner:(id)listenner
{
    [[NSNotificationCenter defaultCenter] addObserver:listenner selector:@selector(showDetailMessageListenner:) name:@"DetailMessageListenner" object:nil];
}

- (void) showDetailMessageListenner:(NSNotification *) notification
{
    //close Global Message
    BOOL didShow = NO;
    [popoverController dismissPopoverAnimated:YES];
    popoverController = nil;
    [self removeDetailMessageListenner:self];
    //Get Info
    MessageCellContent *info = [notification.userInfo objectForKey:@"MessageCellContent"];
    
    //Push Detail convervation
    ChatViewController *chatViewCtr = nil;
    //Store infor which compare if has new Convervation
    BOOL hasChatView = NO;
    UIViewController *topViewCtr = self.navigationController.topViewController;
    if ([topViewCtr isKindOfClass:[ChatViewController class]]) {
        hasChatView = YES;
        chatViewCtr = (ChatViewController*)topViewCtr;
        if ([info.userPostName isEqualToString:chatViewCtr.infoChatting.userPostName]) {
            // amination
            
            didShow = YES;
            [self performSelector:@selector(animationView:) withObject:chatViewCtr.view afterDelay:0.01];
        }else {
            [self.navigationController popViewControllerAnimated:NO];
            chatViewCtr = nil;
        }
    }
    if (hasChatView == NO) {
        NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        NSArray *popViews = nil;
        for (UIViewController *viewCtr in viewControllers) {
            if ([viewCtr isKindOfClass:[ChatViewController class]]) {
                popViews = [[NSArray alloc] initWithArray: [self.navigationController popToViewController:viewCtr animated:NO]];
                [self.navigationController popViewControllerAnimated:NO];
                hasChatView = YES;
                break;
            }
        }
        if (hasChatView) {
            if (popViews) {
                for (UIViewController *viewCtr in popViews) {
                    [self.navigationController pushViewController:viewCtr animated:NO];
                }
            }
        }
    }
    
    
            
    if (didShow == NO) {
        chatViewCtr = [[ChatViewController alloc]init];
        //chatViewCtr.infoChatting = nil;
        [chatViewCtr setInfoChatting:info];
        NSLog(@"info %@  %@",info.userPostName, chatViewCtr.infoChatting.userPostName);
        //[chatViewCtr loadListMessageCellContent];
        [self.navigationController pushViewController:chatViewCtr animated:YES];
    }
    chatViewCtr = nil;
    notification = nil;
    info = nil;
}

- (void) removeDetailMessageListenner:(id) listenner
{
    [[NSNotificationCenter defaultCenter] removeObserver:listenner name:@"DetailMessageListenner" object:nil];
}
- (void) showDetailFromSubView:(NSNotification*)notifi
{
    [self.navigationController popToViewController:self animated:NO];
    //Add to overlay to Show
    if (overlay == nil) {
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0.0, cStatusAndNavBar, self.view.frame.size.width, self.view.frame.size.height - cStatusAndNavBar)];
        [self.view addSubview:self.overlay];
    }
    if (self.overlay.superview == nil) {
        [self.view addSubview:overlay];
    }
    for (UIView *view in overlay.subviews) {
        [view removeFromSuperview];
    }
    if (customViewCtr == nil) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            customViewCtr = [[UITablePostViewController alloc] initWithStyle:UITableViewStyleGrouped];
        }else
        {
            customViewCtr = [[UITablePostViewController alloc] initWithNibName:@"UITablePostViewController_IPad" bundle:nil];
        }
    }
    else {
        if (![customViewCtr isKindOfClass:[UITablePostViewController class]]) {
            customViewCtr = nil;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
                customViewCtr = [[UITablePostViewController alloc] initWithStyle:UITableViewStyleGrouped];
            }else
            {
                customViewCtr = [[UITablePostViewController alloc] initWithNibName:@"UITablePostViewController_IPad" bundle:nil];
            }
            
        }
    }
    [self addChildViewController:customViewCtr];
    [(UITablePostViewController*)customViewCtr setNavigationController:self.navigationController];
    [[(UITablePostViewController*)customViewCtr tableView] setScrollEnabled:NO];
    
    CGRect frame = self.overlay.frame;
    frame.origin.y = cCellHeight;
    frame.size.height = frame.size.height - cCellHeight;
    customViewCtr.view.frame = frame;
    [topView addSubview:customViewCtr.view];
    
    [self.overlay addSubview: topView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showDetailFromSubView_SideBar" object:nil];
    
    NSString *itemName = [notifi.userInfo objectForKey:@"itemName"];
    NSInteger  wallID = 1;
    NSInteger countryID = 190;
    countryID = [SupportFunction GetCountryIdFromConutryName:[UserPAInfo sharedUserPAInfo].userCountryPA];
    wallID = [SupportFunction getWallIdFromCountryID:countryID andItemName:itemName];
    [(UITablePostViewController*)customViewCtr loadCellsWithWallID:wallID From:0 Count:5];
    [customViewCtr.view setAutoresizingMask:self.overlay.autoresizingMask];
    [customViewCtr.view setAutoresizesSubviews:YES];
}
- (void) showUserProfile
{
    for (UIView *view in overlay.subviews) {
        [view removeFromSuperview];
    }
    if (customViewCtr == nil) {
        customViewCtr = [[UserProfileViewController alloc]initWithNibName:@"UserProfileViewController" bundle:nil];
    }
    else {
        if (![customViewCtr isKindOfClass:[UserProfileViewController class]]) {
            customViewCtr = [[UserProfileViewController alloc]initWithNibName:@"UserProfileViewController" bundle:nil];
        }
    }
    
    CGRect frame = self.overlay.frame;
    customViewCtr.view.frame = frame;
    [self.overlay addSubview:customViewCtr.view];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showDetailFromSubView_SideBar" object:nil];

}

- (void) showFavoriteWithInfo:(NSNotification *)notifi
{
    NSNumber *num = [notifi.userInfo objectForKey:@"itemID"];
    switch ([num integerValue]) {
        case 0://status update
        {
            if (overlay == nil) {
                self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0.0, cStatusAndNavBar, self.view.frame.size.width, self.view.frame.size.height - cStatusAndNavBar)];
                [self.view addSubview:self.overlay];
            }
            if (overlay.superview == nil) {
                [self.view addSubview:overlay];
            }
            for (UIView *view in overlay.subviews) {
                [view removeFromSuperview];
            }
            [self.navigationController popToViewController:self animated:NO];
            if (customViewCtr == nil) {
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
                    customViewCtr = [[ActivityViewController alloc] initWithStyle:UITableViewStyleGrouped];
                }else
                {
                    customViewCtr = [[ActivityViewController alloc] init];
                }
            }
            else {
                if (![customViewCtr isKindOfClass:[ActivityViewController class]]) {
                    customViewCtr = nil;
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
                        customViewCtr = [[ActivityViewController alloc] initWithStyle:UITableViewStyleGrouped];
                    }else
                    {
                        customViewCtr = [[ActivityViewController alloc] init];
                    }
                }
            }
            
            CGRect frame = self.overlay.frame;
            frame.origin.y = cCellHeight;
            frame.size.height = frame.size.height - cCellHeight;
            customViewCtr.view.frame = frame;
            [topView addSubview:customViewCtr.view];
            
            [self.overlay addSubview: topView];
            lbTitle.text = @"  Status Updates";
            //Load activity
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loadActivity" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showDetailFromSubView_SideBar" object:nil];
            
        }
            break;
        case 1://messages
        {
            
            if (overlay == nil) {
                self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0.0, cStatusAndNavBar, self.view.frame.size.width, self.view.frame.size.height - cStatusAndNavBar)];
                [self.view addSubview:self.overlay];
            }
            if (overlay.superview == nil) {
                [self.view addSubview:overlay];
            }
            for (UIView *view in overlay.subviews) {
                [view removeFromSuperview];
            }
            [self.navigationController popToViewController:self animated:NO];
            if (customViewCtr == nil) {
                customViewCtr = [[MessageViewController alloc] init];
            }
            else {
                if (![customViewCtr isKindOfClass:[MessageViewController class]]) {
                    customViewCtr = nil;
                    customViewCtr = [[MessageViewController alloc] init];
                }
            }
            ((MessageViewController*)customViewCtr).delegate = self;
            //messageCtr.view.frame = CGRectMake(0.0, cStatusAndNavBar, self.view.frame.size.width, self.view.frame.size.height - cStatusAndNavBar);
            //set navigationViewCtr if want to full screen
            //messageCtr.navigationController =self.navigationController;
            
            [self.overlay addSubview: customViewCtr.view];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showDetailFromSubView_SideBar" object:nil];
            
        }
            break;
        case 2://Events
            break;
        case 3://Friends
        {
            if (overlay == nil) {
                self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0.0, cStatusAndNavBar, self.view.frame.size.width, self.view.frame.size.height - cStatusAndNavBar)];
                [self.view addSubview:self.overlay];
            }
            if (overlay.superview == nil) {
                [self.view addSubview:overlay];
            }
            for (UIView *view in overlay.subviews) {
                [view removeFromSuperview];
            }
            [self.navigationController popToViewController:self animated:NO];
            if (customViewCtr == nil) {
                customViewCtr = [[FriendsViewController alloc] init];
            }
            else {
                if (![customViewCtr isKindOfClass:[FriendsViewController class]]) {
                    customViewCtr = nil;
                    customViewCtr = [[FriendsViewController alloc] init];
                }
            }
            ((FriendsViewController*)customViewCtr).delegate = self;
            NSLog(@"Custome View %@", customViewCtr.view);
            customViewCtr.view.frame = overlay.frame;
            [self.overlay addSubview: customViewCtr.view];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showDetailFromSubView_SideBar" object:nil];
            
        }
            
            break;
        default:
            break;
    }
    [customViewCtr.view setAutoresizingMask:self.overlay.autoresizingMask];
    [customViewCtr.view setAutoresizesSubviews:YES];
    num = nil;
}
- (void) showDetailFromLeftView:(NSNotification*)notifi
{
    //[self.navigationController popToViewController:self animated:NO];
    NSNumber *section = [notifi.userInfo objectForKey:@"section"];
    if ([section integerValue] == 0) {
        [self showUserProfile];
    }else if ([section integerValue] == 1)
    {
        [self showFavoriteWithInfo:notifi];
    }
}

- (void) newPostAddListenner
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newPostWithData) name:@"newPostWithData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newPostWithOutData) name:@"newPostWithOutData" object:nil];
}
     
- (void) newPostWithData
{
    //listCells = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:@"ListCell_SaveData"];
    //NSLog(@"ListCell %@", listCells);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"newPostWithData" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"newPostWithOutData" object:nil];
    
    NSString *text = [[NSUserDefaults standardUserDefaults] objectForKey:@"_text_NewPost"];
    NSInteger totalImage = [[NSUserDefaults standardUserDefaults] integerForKey:@"_totalImage_NewPost"];
    NSDataDetector *detect = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *matches = [detect matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    PostCellContent *_content =[[PostCellContent alloc] init];
    for (NSTextCheckingResult *match in matches) {
        //NSRange matchRange = [match range];
        if ([match resultType] == NSTextCheckingTypeLink) {
            NSURL *url = [match URL];
            if ([self isYoutubeVideoLink:url]) {
                [_content.listVideos addObject:[url absoluteString]];
            }else {
                // Add URL
                //[_content.listLinks addObject:[url absoluteString]];
            }
            
            NSLog(@"%@", [url absoluteString]);
        }    }
    _content.text = text;
    _content.userAvatar = [UserPAInfo sharedUserPAInfo].imgAvatar;
    _content.userPostName = [UserPAInfo sharedUserPAInfo].usernamePU;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathToDocuments=[paths objectAtIndex:0];
    for (int i =1; i <= totalImage; i++) {
        [_content.listImages addObject:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/newPost%d.jpg", pathToDocuments, i]]];
        //[[NSFileManager defaultManager]removeItemAtPath:[NSString stringWithFormat:@"%@/newPost%d.jpg", pathToDocuments, i] error:nil];
    }
    
    UIPostCell *aCell = [[UIPostCell alloc] init];
    aCell.navigationController = self.navigationController;
    aCell.content = _content;
    //[aCell drawContent];
    [listContent addObject:_content];
    //[listCells insertObject:aCell atIndex:0];
    aCell = nil;
    paths = nil;
    pathToDocuments =nil;
    [self.myTableView reloadData];
}

- (void) newPostWithOutData
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"newPostWithData" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"newPostWithOutData" object:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (listContent.count == 0) {
        return 1;
    }
    return listContent.count;
    //return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
//    if (listCells.count == 0) {
//        return 1;
//    }
//    return listCells.count;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (listContent.count == 0) {
        return tableView.frame.size.height;
    }

    Float32 height = [UIPostCell getCellHeightWithContent:[listContent objectAtIndex:indexPath.section]];
    return height;
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    cell.detailTextLabel.frame = CGRectMake(cMaxLeftView - 100, 0.0, 70, cCellHeight);
//    
//}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == listContent.count) {
        return 10.0;
    }
    return 1.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (listContent.count == 0) {
        CGRect frame = tableView.frame;
        frame.size.height += cCellHeight;//make "No data" below Loading
        UILabel *labelCell = [[UILabel alloc]initWithFrame:frame];
        labelCell.text = @"No Data";
        [labelCell setFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE * 2.5]];
        [labelCell setTextAlignment:UITextAlignmentCenter];
        labelCell.backgroundColor = [UIColor clearColor];
        labelCell.textColor = [UIColor darkGrayColor];
        labelCell.alpha = 0.6;
        UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:tableView.frame];
        [cell.contentView addSubview:labelCell];
        tableView.scrollEnabled = NO;
        labelCell = nil;
        cell.backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        return  cell;
    }
    static NSString *CellIdentifier = @"UIPostCell_Landscape";
    UIPostCell *cell = (UIPostCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (UIPostCell *)[nib objectAtIndex:0];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        cell.navigationController = self.navigationController;
        [cell updateCellWithContent:[listContent objectAtIndex:indexPath.section]];
    });
    
//    NSLog(@"%@", cell.description);
    
    
    tableView.scrollEnabled = YES;
    cell.backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.backgroundView.backgroundColor = [UIColor whiteColor];
    [cell setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ];
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - DetailViewControllerDelegate


#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
}

#pragma mark WEPopoverControllerDelegate implementation

- (void)popoverControllerDidDismissPopover:(WEPopoverController *)thePopoverController {
	//Safe to release the popover here
    popoverController = nil;
}

- (BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)thePopoverController {
	//The popover is automatically dismissed if you click outside it, unless you return NO here
	return YES;
}
- (WEPopoverContainerViewProperties *)defaultContainerViewProperties {
	WEPopoverContainerViewProperties *ret = [[WEPopoverContainerViewProperties alloc] init];
	
	CGSize imageSize = CGSizeMake(30.0f, 30.0f);
	NSString *bgImageName = @"popoverBgSimple.png";
	CGFloat bgMargin = 6.0;
	CGFloat contentMargin = 4.0;
	
	ret.leftBgMargin = bgMargin;
	ret.rightBgMargin = bgMargin;
	ret.topBgMargin = bgMargin;
	ret.bottomBgMargin = bgMargin;
	ret.leftBgCapSize = imageSize.width/2;
	ret.topBgCapSize = imageSize.height/2;
	ret.bgImageName = bgImageName;
	ret.leftContentMargin = contentMargin;
	ret.rightContentMargin = contentMargin;
	ret.topContentMargin = contentMargin;
	ret.bottomContentMargin = contentMargin;
	ret.arrowMargin = 1.0;
	
	ret.upArrowImageName = @"popoverArrowUpSimple.png";
	ret.downArrowImageName = @"popoverArrowDownSimple.png";
	ret.leftArrowImageName = @"popoverArrowLeftSimple.png";
	ret.rightArrowImageName = @"popoverArrowRightSimple.png";
	return ret;
}


- (WEPopoverContainerViewProperties *)improvedContainerViewProperties {
	
	WEPopoverContainerViewProperties *props = [[WEPopoverContainerViewProperties alloc] init];
	NSString *bgImageName = nil;
	CGFloat bgMargin = 0.0;
	CGFloat bgCapSize = 0.0;
	CGFloat contentMargin = 4.0;
	
	bgImageName = @"popoverBg.png";
	
	// These constants are determined by the popoverBg.png image file and are image dependent
	bgMargin = 13; // margin width of 13 pixels on all sides popoverBg.png (62 pixels wide - 36 pixel background) / 2 == 26 / 2 == 13 
	bgCapSize = 31; // ImageSize/2  == 62 / 2 == 31 pixels
	
	props.leftBgMargin = bgMargin;
	props.rightBgMargin = bgMargin;
	props.topBgMargin = bgMargin;
	props.bottomBgMargin = bgMargin;
	props.leftBgCapSize = bgCapSize;
	props.topBgCapSize = bgCapSize;
	props.bgImageName = bgImageName;
	props.leftContentMargin = contentMargin;
	props.rightContentMargin = contentMargin - 1; // Need to shift one pixel for border to look correct
	props.topContentMargin = contentMargin; 
	props.bottomContentMargin = contentMargin;
	
	props.arrowMargin = 4.0;
	
	props.upArrowImageName = @"popoverArrowUp.png";
	props.downArrowImageName = @"popoverArrowDown.png";
	props.leftArrowImageName = @"popoverArrowLeft.png";
	props.rightArrowImageName = @"popoverArrowRight.png";
	return props;	
}
#pragma mark - GlobalNotificationsViewControllerDelegate

- (void) didSelectedRowWithInfo:(NSDictionary *)_info
{
    //close Global Message
    if (popoverController) {
		[popoverController dismissPopoverAnimated:YES];
		popoverController = nil;
	}
    //Get Info
    //NotificationsCellContent *info = [_info objectForKey:@"NotificationsCellContent"];
    
//    //Push Detail convervation
//    DetailNotificationViewController *notiCtr = nil;
//    //Store infor which compare if has new Convervation
//    BOOL hasGlobalView = NO;
//    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
//    for (UIViewController *viewCtr in viewControllers) {
//        if ([viewCtr isKindOfClass:[ChatViewController class]]) {
//            [viewControllers removeObject:viewCtr];
//            hasGlobalView = YES;
//        }
//        if ([viewCtr isKindOfClass:[NotificationsCellContent class]]) {
//            [viewControllers removeObject:viewCtr];
//            hasGlobalView = YES;
//        }
//    }
//    if (hasGlobalView) {
//        [self.navigationController setViewControllers:viewControllers];
//    }
//    
//    notiCtr = [[DetailNotificationViewController alloc]init];
//    
//    [self.navigationController pushViewController:notiCtr animated:YES];
//    
//    notiCtr = nil;
//    info = nil;
//    _info = nil;
    BOOL hasView = NO;
    if ([self.navigationController.topViewController isKindOfClass:[CommentsViewController class]]) {
        hasView = YES;
        [self performSelector:@selector(animationView:) withObject:self.navigationController.topViewController.view afterDelay:0.01];
        return;
    }
    
    if (hasView == NO) {
        NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        NSArray *popViews = nil;
        for (UIViewController *viewCtr in viewControllers) {
            if ([viewCtr isKindOfClass:[CommentsViewController class]]) {
                popViews = [[NSArray alloc] initWithArray: [self.navigationController popToViewController:viewCtr animated:NO]];
                [self.navigationController popViewControllerAnimated:NO];
                hasView = YES;
                break;
            }
        }
        if (hasView) {
            if (popViews) {
                for (UIViewController *viewCtr in popViews) {
                    [self.navigationController pushViewController:viewCtr animated:NO];
                }
            }
        }
    }
    
    if (listContent.count == 0) {
        [self loadCells];
    }
    CommentsViewController *commentViewCtr = [[CommentsViewController alloc]init];
    commentViewCtr.content = (PostCellContent*)[listContent objectAtIndex:0];
    [self.navigationController pushViewController: commentViewCtr animated:YES];
    // = nil;
    commentViewCtr = nil;

}
#pragma mark - GlobalAlertViewControllerDelegate

- (void) alertDidSelectedRowWithInfo:(NSDictionary *)info
{
    //close Global Message
    if (popoverController) {
		[popoverController dismissPopoverAnimated:YES];
		popoverController = nil;
	}
}

#pragma mark - MessageDetailDelegate
- (void) searchDisplayControllerDidEnterSearch
{
    //self.navigationController.navigationBarHidden = YES;
    //topMenu.hidden = YES;
}

- (void) searchDisplayControllerDidGoAwaySearch
{
    //topMenu.hidden = NO;
}

- (void) messageViewControllerDidSelectedRowWithInfo:(NSDictionary*)info
{
    NSNotification *noti = [NSNotification notificationWithName:@"DetailMessageListenner" object:nil userInfo:info];
    [self showDetailMessageListenner:noti];
}

#pragma mark - FriendsViewControllerDelegate
-(void) friendsViewControllerDidSelectedRowWithInfo:(NSDictionary *)info
{
    NSLog(@"Selected a friend. Go to Friend's Profile");
}
@end
