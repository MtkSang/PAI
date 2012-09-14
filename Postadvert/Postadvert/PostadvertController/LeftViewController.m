//
//  LeftViewController.m
//  PostAdvert11
//
//  Created by Steven Yap on 16/4/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import "LeftViewController.h"
#import "SignInVwCtrl.h"
#import "NewAccountVwCtrl.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"
#import "SubLeftViewController.h"
#import "FlagViewController.h"
#import "UIBarButtonItem+WEPopover.h"

#import "LeftViewController.h"
#import "SignInVwCtrl.h"
#import "NewAccountVwCtrl.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"
#import "SubLeftViewController.h"
#import "FlagViewController.h"
#import "UIBarButtonItem+WEPopover.h"
#import "UserPAInfo.h"
#import "Userprofile/UserProfileViewController.h"

@interface LeftViewController ()
- (NSMutableArray*) getSubItem:(NSInteger) index;
- (NSMutableArray*) getSubImage:(NSInteger) index;
- (NSMutableArray*) getSubNum:(NSInteger) index;
- (void) setHideSideBar;
- (void) getList;
- (UIPanGestureRecognizer*) addGesture:(id)target;
- (void) handlePanGesture:(UIPanGestureRecognizer*) gesture;
- (UIGestureRecognizer*) addSwipeGesture:(id)target;
- (void) handleSwipeGesture:(UISwipeGestureRecognizer*) gesture;
@end

@implementation LeftViewController
@synthesize overlay;
@synthesize listItems;
@synthesize listImages;
@synthesize popoverController;
@synthesize detailVw;
@synthesize tableView = _tableView;
@synthesize botView = _botView;
@synthesize listItemsFavorites;
@synthesize listIamgesFavorites;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //[self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_1.png"]]];
        //self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"div.png"]];
        //UIView *footerView = [[UIView alloc]init];
        //self.tableView.tableFooterView = footerView;
        //footerView = nil;
        //Set up for footerview
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, cCellHeight)];
//        [footerView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth];
//        footerView.autoresizesSubviews = YES;
        self.tableView.tableFooterView = footerView;
        footerView = nil;
    }
    return self;
}

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_1.png"]]];
//        self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"div.png"]];
//        CGRect frame = self.tableView.frame;
//        frame.size.height = frame.size.height - cCellHeight -5;
//        self.tableView.frame = frame;
//        UIView *footerView = [[UIView alloc]init];
//        self.tableView.tableFooterView = footerView;
//        footerView = nil;
//    }
//    return self;
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setAutoresizesSubviews:YES];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disableScrollTable) name:@"disableScrollTable" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableScrollTable) name:@"enableScrollTable" object:nil];
    // Do any additional setup after loading the view from its nib.
    //[self.view addSubview:[self drawPostAdvertTopMenu]];
    menuView = [self drawPostAdvertTopMenu];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:79.0/255 green:178.0/255 blue:187.0/255 alpha:1];
    self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"div.png"]];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //self.tableView.separatorColor = [UIColor colorWithRed:225.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    
    self.navigationController.navigationBarHidden = NO;
    [self getList];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
//    UIButton *copyRightButton = [[UIButton alloc]init];
//    [copyRightButton setBackgroundColor:[UIColor clearColor]];
//    [copyRightButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
//    [copyRightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [copyRightButton setTitle:@"Postadvert © 2012" forState:UIControlStateNormal];
//    [copyRightButton sizeToFit];
//    NSLog(@"Bot %@", _botView);
//    copyRightButton.frame = CGRectMake(cMaxLeftView - copyRightButton.frame.size.width - 5.0, 0.0, copyRightButton.frame.size.width, cCellHeight - 5);
//    [_botView addSubview:copyRightButton];
//    _botView.backgroundColor = [UIColor whiteColor];
//    copyRightButton = nil;
    
    //botView = [[UIView alloc]initWithFrame:CGRectMake(0.0, self.view.frame.size.height - cCellHeight, self.view.frame.size.width, cCellHeight)];
    //botButton = [[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, cCellHeight)];
    //[botButton setBackgroundColor:[UIColor whiteColor]];
    //[self.view addSubview:botButton];
    
    //Add gesture
    //[self.tableView addGestureRecognizer:[self addGesture:self]];
    //[self.navigationController.navigationBar addGestureRecognizer:[self addGesture:self]];
    
    //[self.tableView addGestureRecognizer:[self addSwipeGesture:self]];
}
- (void)viewWillAppear:(BOOL)animated{
    if( self.navigationController.viewControllers.count < 02)
    {
        if (menuView.superview) {
            [menuView removeFromSuperview];
        } 
        menuView = nil;
        menuView = [self drawPostAdvertTopMenu];
        [self.tableView reloadData];
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController.navigationBar addSubview:menuView];
    }
    if (isHideSideBar) {
        isHideSideBar = NO;
        self.navigationController.navigationBarHidden = NO;
        [self setHideSideBar];
    }
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //self.navigationController.navigationBarHidden = NO;
    //[self showPopUpDialog:[LeftViewController  createLoginListView ] :CGPointMake(0.0, 20.0)];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
    NSLog(@"Rotated %@", self);

    if (self.popoverController) 
    {
        CGRect frame = self.popoverController.view.frame;
        NSLog(@"%f %f", frame.origin.x, frame.origin.y);
        frame.origin.y = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height - 2 + cStatusBarHeight; ;
        
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             self.popoverController.view.frame = frame;
                         } 
                         completion:nil
                         ];
        
    }
    
}

#pragma mark - tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 01:
            return listItemsFavorites.count;
            break;
        case 02:
            return listItems.count;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell ;
    if (indexPath.section != 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"UserIdentifier"];
    }
    if (cell == nil) {
        if (indexPath.section !=0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserIdentifier"];
        }
        
        //cell.backgroundColor = [UIColor clearColor]; 
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        UIImageView *imageBGSelected = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0.0, self.view.frame.size.width, cCellHeight)] ;
        imageBGSelected.opaque = NO;
        //imageBGSelected.layer.cornerRadius = 10;
        //imageBGSelected.layer.masksToBounds = YES;
        imageBGSelected.image = [UIImage imageNamed:@"selected_state.png"];
        [cell setSelectedBackgroundView:imageBGSelected];
        imageBGSelected = nil;
        
        UIImageView *imageBG = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0.0, self.view.frame.size.width, cCellHeight)] ;
        imageBG.opaque = NO;
        //    imageBG.layer.cornerRadius = 10;
        //    imageBG.layer.masksToBounds = YES;
        imageBG.image = [UIImage imageNamed:@"normal_state.png"];
        [cell setBackgroundView:imageBG];
        imageBG = nil;
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    }
    
    
    if (indexPath.section == 0) {//User area
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (cCellHeight - cAvartaHeight)/2.0, cAvartaHeight, cAvartaHeight)];
        imageView.image = [UIImage imageNamed:@"avatar.png"];
        [cell.contentView addSubview:imageView];
        //imageView.contentMode = UIViewContentModeScaleAspectFill;
        //int iAutoFill =  [database integerForKey:cAutoFillInfor];
        if ([UserPAInfo sharedUserPAInfo].registrationID) {//Login OK
                cell.textLabel.text = [NSString stringWithFormat:@"           %@", [UserPAInfo sharedUserPAInfo].fullName];
            if ([UserPAInfo sharedUserPAInfo].imgAvatar) {
                imageView.image = [UserPAInfo sharedUserPAInfo].imgAvatar;
            }
        }else {
            imageView.image = [UIImage imageNamed:@"icon_Avatar_QM.png"];
            cell.textLabel.text = [NSString stringWithFormat:@"         %@",@"Anonymous"];
        }
        //cell.imageView.image = [UIImage imageNamed:@"avatar.png"];
        imageView = nil;
        return cell;
        
    }
    if (indexPath.section == 1) {
        cell.imageView.image = [listIamgesFavorites objectAtIndex:indexPath.row];
        cell.textLabel.text = [listItemsFavorites objectAtIndex:indexPath.row];
        return cell;
    }
    //default
    cell.imageView.image = [listImages objectAtIndex:indexPath.row];
    cell.textLabel.text = [listItems objectAtIndex:indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	// create the parent view that will hold header Label
	UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.0, tableView.frame.size.width, cHeaderHeight)];
	customView.backgroundColor = [UIColor grayColor];
    customView.userInteractionEnabled = NO;
	// create the button object
	UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	headerLabel.backgroundColor = [UIColor clearColor];
	headerLabel.opaque = NO;
	headerLabel.textColor = [UIColor whiteColor];
	headerLabel.highlightedTextColor = [UIColor whiteColor];
	headerLabel.font = [UIFont boldSystemFontOfSize:11];
	headerLabel.frame = CGRectMake(10.0, 0.0, tableView.frame.size.width, cHeaderHeight);
    
	// want to align the header text as centered
	// headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);
    headerLabel.text = nil;
    if (section == 1) {
        headerLabel.text = @"FAVORITES";
    }
    if (section == 2) {
        headerLabel.text = @"E-COMMERCE & DISCUSSIONS";
    }
	[customView addSubview:headerLabel];
    
	return customView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1)
        return cHeaderHeight;
    if(section == 2)
        return cHeaderHeight;
    if (section == 3) {
        return self.view.frame.size.height;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cCellHeight;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (section == 1) {
//        return @"E-COMMERCE & DISCUSSIONS";
//    }
//    return nil;
//}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    if (tableView.scrollEnabled == NO) {
        [self enableScrollTable];
        return;
    }
    if (popoverController) {
        [self.popoverController dismissPopoverAnimated:YES];
		self.popoverController = nil;
        return;
    }
    
    if (indexPath.section == 0) {
        //int iAutoFill =  [database integerForKey:cAutoFillInfor];
        if ( [UserPAInfo sharedUserPAInfo].registrationID) {
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:indexPath.row],@"itemID", [NSNumber numberWithInteger:indexPath.section], @"section",nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showDetailFromLeftView" object:nil userInfo:dict];
            return;
        }
        else {
            [self onTouchSignInBtn:self];
        }
        return;
    }
    //Show from fovorites
    if (indexPath.section == 1) {
//        if (menuView.superview) {
//            [menuView removeFromSuperview];
//        }
         NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:indexPath.row],@"itemID", [NSNumber numberWithInteger:indexPath.section], @"section",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showDetailFromLeftView" object:nil userInfo:dict];
        return;
    }
    //Show subView
    if (indexPath.section == 2) {
        if (menuView.superview) {
            [menuView removeFromSuperview];
        }
        
        SubLeftViewController *nextSideController = [[SubLeftViewController alloc] init];
        //nextSideController.view.frame = self.view.frame;
        //set title
        //[nextSideController setTitle:[listItems objectAtIndex:indexPath.row]];
        [nextSideController setItemName:[listItems objectAtIndex:indexPath.row]];
        nextSideController.view.backgroundColor =[UIColor grayColor];
        nextSideController.detailVw = detailVw;
        nextSideController.listItems = [self getSubItem:indexPath.row];
        nextSideController.listImages = [self getSubImage:indexPath.row];
        //[nextSideController getSubNums];
        [self.navigationController pushViewController:nextSideController animated:YES];
        nextSideController.navigationController.navigationBarHidden = NO;
    }
    
}

#pragma mark - implement
- (UIPanGestureRecognizer*) addGesture:(id) target
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
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
        {
            NSNumber *num = [NSNumber numberWithInteger:0];
            NSDictionary *dict = [NSDictionary dictionaryWithObject:num forKey:@"setSideBarForState"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"setSideBarForState" object:nil userInfo:dict];
            num = nil;
            dict = nil;
        }
            break;
            
        default:
        {
            NSNumber *num = [NSNumber numberWithInteger:1];
            NSDictionary *dict = [NSDictionary dictionaryWithObject:num forKey:@"setSideBarForState"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"setSideBarForState" object:nil userInfo:dict];
            num = nil;
            dict = nil;
        }
            break;
    }
}
-(IBAction)buttonClinked:(id)sender{
    UIViewController *nextSideController = [[UIViewController alloc] init];
    nextSideController.view.frame = self.view.frame;
    nextSideController.view.backgroundColor =[UIColor grayColor];
    [self.navigationController pushViewController:nextSideController animated:YES];
    nextSideController.navigationController.navigationBarHidden = NO;
    
    
    
    
}

- (UIView*) drawPostAdvertTopMenu {
    UIView *menu = [[UIView alloc]initWithFrame:CGRectMake(0, 0.0, self.view.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
    [menu setBackgroundColor:[UIColor whiteColor]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = CGRectMake(5, 0.0, 110, self.navigationController.navigationBar.frame.size.height);
    [menu addSubview:imageView];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btnDiv = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([UserPAInfo sharedUserPAInfo].registrationID) {//Login OK
        btn2.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"normal_state.png"]].CGColor ;
        [btn2.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
        [btn2 setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"normal_state.png"]] forState:UIControlStateNormal];
        [btn2 setTitle:@"My Account" forState:UIControlStateNormal];
        [btn2 sizeToFit];
        [btn2.titleLabel setTextAlignment:UITextAlignmentRight];
        btn2.frame = CGRectMake(self.view.frame.size.width - cRemainView - btn2.frame.size.width - 10.0, 0, btn2.frame.size.width, self.navigationController.navigationBar.frame.size.height / 2.0);
        //[btn2 addTarget:self action:@selector(onTouchCreateAccountBtn:) forControlEvents:UIControlEventTouchUpInside];
        [menu addSubview:btn2];
        
        [btnDiv.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
        [btnDiv setTitle:@"|" forState:UIControlStateNormal];
        btnDiv.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"normal_state.png"]].CGColor;
        [btnDiv setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"normal_state.png"]] forState:UIControlStateNormal];
        [btnDiv sizeToFit];
        [btnDiv.titleLabel setTextAlignment:UITextAlignmentRight];
        btnDiv.frame = CGRectMake(btn2.frame.origin.x - btnDiv.frame.size.width - 05.0, 0, btnDiv.frame.size.width, self.navigationController.navigationBar.frame.size.height / 2.0);
        //[btn1 addTarget:self action:@selector(onTouchLogOutBtn:) forControlEvents:UIControlEventTouchUpInside];
        [menu addSubview:btnDiv];
        
        
        [btn1.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
        [btn1 setTitle:@"Log out" forState:UIControlStateNormal];
        btn1.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"normal_state.png"]].CGColor;
        [btn1 setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"normal_state.png"]] forState:UIControlStateNormal];
        [btn1 sizeToFit];
        [btn1.titleLabel setTextAlignment:UITextAlignmentRight];
        btn1.frame = CGRectMake(btnDiv.frame.origin.x - btn1.frame.size.width - 05.0, 0, btn1.frame.size.width, 20);
        [btn1 addTarget:self action:@selector(onTouchLogOutBtn:) forControlEvents:UIControlEventTouchUpInside];
        [menu addSubview:btn1];
        
    }else {
        //cMaxLeftView =
        btn2.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"normal_state.png"]].CGColor ;
        [btn2.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
        [btn2 setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"normal_state.png"]] forState:UIControlStateNormal];
        [btn2 setTitle:@"Free Sign Up" forState:UIControlStateNormal];
        [btn2 sizeToFit];
        [btn2.titleLabel setTextAlignment:UITextAlignmentRight];
        btn2.frame = CGRectMake(self.view.frame.size.width - cRemainView - btn2.frame.size.width - 10.0, 0, btn2.frame.size.width, 20);
        [btn2 addTarget:self action:@selector(onTouchCreateAccountBtn:) forControlEvents:UIControlEventTouchUpInside];
        [menu addSubview:btn2];
        
        [btn1.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
        [btn1 setTitle:@"Login" forState:UIControlStateNormal];
        btn1.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"normal_state.png"]].CGColor;
        [btn1 setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"normal_state.png"]] forState:UIControlStateNormal];
        [btn1 sizeToFit];
        [btn1.titleLabel setTextAlignment:UITextAlignmentRight];
        btn1.frame = CGRectMake(btn2.frame.origin.x - btn1.frame.size.width - 10.0, 0, btn1.frame.size.width, 20);
        [btn1 addTarget:self action:@selector(onTouchSignInBtn:) forControlEvents:UIControlEventTouchUpInside];
        [menu addSubview:btn1];
        
    }
    NSString *country = [UserPAInfo sharedUserPAInfo].userCountryPA;
    if ([country isEqualToString:@""] || country == nil) {
        country = @"Singapore";
    }
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"normal_state.png"]].CGColor;
    [btn3.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
    [btn3 setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"normal_state.png"]] forState:UIControlStateNormal];
    [btn3 setTitle:country forState:UIControlStateNormal];
    [btn3 sizeToFit];
    [btn3.titleLabel setTextAlignment:UITextAlignmentRight];
    btn3.frame = CGRectMake(self.view.frame.size.width - cRemainView - btn3.frame.size.width - 10.0, self.navigationController.navigationBar.frame.size.height/2.0, btn3.frame.size.width, self.navigationController.navigationBar.frame.size.height/2.0);
    [btn3 addTarget:self action:@selector(onTouchCountry:) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:btn3];
    
    
    UIButton *btnFlag = [UIButton buttonWithType:UIButtonTypeCustom];
    //btnFlag.layer.borderColor = [UIColor colorWithPatternImage:[self getFlagWithName:country]].CGColor;
    [btnFlag setBackgroundImage:[LeftViewController getFlagWithName:country] forState:UIControlStateNormal];
    [btnFlag setBackgroundImage:[LeftViewController getFlagWithName:country] forState:UIControlStateHighlighted];
    [btnFlag sizeToFit];
    btnFlag.frame = CGRectMake(btn3.frame.origin.x - 22 - 5.0 , self.navigationController.navigationBar.frame.size.height/2.0,  22, self.navigationController.navigationBar.frame.size.height/2.0);
    [btnFlag addTarget:self action:@selector(onTouchCountry:) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:btnFlag];
    menu.autoresizesSubviews = YES;
    UIViewAutoresizing autoResize = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    for (UIView *view in menu.subviews) {
        [view setAutoresizingMask:autoResize];
    }
    [menu setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
    country = nil;
    btn1 = nil;
    btnDiv = nil;
    btn2 = nil;
    btn3 = nil;
    btnFlag = nil;
    imageView = nil;
    return menu;
}

- (NSMutableArray*) getSubItem:(NSInteger)index
{
    NSMutableArray *subItem = [[NSMutableArray alloc] init];
    switch (index) {
        case 0:
            [subItem addObject:@"Blogshop Xpress"];
            break;
        case 1:
            [subItem addObject:@"Co-Broke Xpress"];
            [subItem addObject:@"Property Xchange"];
            break;
        case 2:
            [subItem addObject:@"Mobile Xpress"];
            [subItem addObject:@"Tech Xchange"];
            break;
        case 3:
            [subItem addObject:@"Cars Xpress"];
            [subItem addObject:@"Cars Xchange"];
            break;
        case 4:
            [subItem addObject:@"Pets Xpress"];
            [subItem addObject:@"Pets Xchange"];
            break;
        case 5:
            [subItem addObject:@"Jobs Xpress"];
            [subItem addObject:@"Jobs Xchange"];
            break;
        case 6:
            [subItem addObject:@"Business Xchange"];
            break;
        case 7:
            [subItem addObject:@"Travel Xchange"];
            break;
        case 8:
            [subItem addObject:@"Sports Xchange"];
            break;
            
        default:
            break;
    }
    
    return subItem;
}

- (NSMutableArray*) getSubImage:(NSInteger)index
{
    NSMutableArray *subItem = [[NSMutableArray alloc] init];
    switch (index) {
        case 0:
            [subItem addObject:[UIImage imageNamed:@"sub_icon_1.png"]];
            break;
        case 1:
            [subItem addObject:[UIImage imageNamed:@"sub_icon_1.png"]];
            [subItem addObject:[UIImage imageNamed:@"sub_icon_2.png"]];
            break;
        case 2:
            [subItem addObject:[UIImage imageNamed:@"sub_icon_1.png"]];
            [subItem addObject:[UIImage imageNamed:@"sub_icon_2.png"]];
            break;
        case 3:
            [subItem addObject:[UIImage imageNamed:@"sub_icon_1.png"]];
            [subItem addObject:[UIImage imageNamed:@"sub_icon_2.png"]];
            break;
        case 4:
            [subItem addObject:[UIImage imageNamed:@"sub_icon_1.png"]];
            [subItem addObject:[UIImage imageNamed:@"sub_icon_2.png"]];
            break;
        case 5:
            [subItem addObject:[UIImage imageNamed:@"sub_icon_1.png"]];
            [subItem addObject:[UIImage imageNamed:@"sub_icon_2.png"]];
            break;
        case 6:
            [subItem addObject:[UIImage imageNamed:@"sub_icon_1.png"]];
            break;
        case 7:
            [subItem addObject:[UIImage imageNamed:@"sub_icon_1.png"]];
            break;
        case 8:
            [subItem addObject:[UIImage imageNamed:@"sub_icon_1.png"]];
            break;
            
        default:
            break;
    }
    
    return subItem;
}


- (NSMutableArray*) getSubNum:(NSInteger)index
{
    NSMutableArray *subItem = [[NSMutableArray alloc] init];
    switch (index) {
        case 0:
            [subItem addObject:[NSNumber numberWithInt:rand()%1000]];
            break;
        case 1:
            [subItem addObject:[NSNumber numberWithInt:rand()%1000]];
            [subItem addObject:[NSNumber numberWithInt:rand()%1000]];
            break;
        case 2:
            [subItem addObject:[NSNumber numberWithInt:rand()%1000]];
            [subItem addObject:[NSNumber numberWithInt:rand()%1000]];
            break;
        case 3:
            [subItem addObject:[NSNumber numberWithInt:rand()%1000]];
            [subItem addObject:[NSNumber numberWithInt:rand()%1000]];
            break;
        case 4:
            [subItem addObject:[NSNumber numberWithInt:rand()%1000]];
            [subItem addObject:[NSNumber numberWithInt:rand()%1000]];
            break;
        case 5:
            [subItem addObject:[NSNumber numberWithInt:rand()%1000]];
            [subItem addObject:[NSNumber numberWithInt:rand()%1000]];
            break;
        case 6:
            [subItem addObject:[NSNumber numberWithInt:rand()%1000]];
            break;
        case 7:
            [subItem addObject:[NSNumber numberWithInt:rand()%1000]];
            break;
        case 8:
            [subItem addObject:[NSNumber numberWithInt:rand()%1000]];
            break;
            
        default:
            break;
    }
    
    return subItem;
}

- (void) getList
{
    
    listItems = [[NSMutableArray alloc]initWithObjects:@"SHOPPING",@"PROPERTY", @"TECHNOLOGY", @"VEHICLES", @"PETS", @"JOBS", @"BUSINESS", @"TRAVEL", @"SPORTS", nil];
    listImages = [[NSMutableArray alloc]init];
    [listImages addObject:[UIImage imageNamed:@"shopping.png"]];
    [listImages addObject:[UIImage imageNamed:@"property.png"]];
    [listImages addObject:[UIImage imageNamed:@"technology.png"]];
    [listImages addObject:[UIImage imageNamed:@"vehicle.png"]];
    [listImages addObject:[UIImage imageNamed:@"pet.png"]];
    [listImages addObject:[UIImage imageNamed:@"job.png"]];
    [listImages addObject:[UIImage imageNamed:@"business.png"]];
    [listImages addObject:[UIImage imageNamed:@"travel.png"]];
    [listImages addObject:[UIImage imageNamed:@"sport.png"]];
    
    listItemsFavorites = [[NSMutableArray alloc]initWithObjects:@"STATUS UPDATES",@"MESSAGES", @"EVENTS", @"FRIENDS", nil];
    listIamgesFavorites = [[NSMutableArray alloc] init];
    [listIamgesFavorites addObject:[UIImage imageNamed:@"status_update.png"]];
    [listIamgesFavorites addObject:[UIImage imageNamed:@"messages.png"]];
    [listIamgesFavorites addObject:[UIImage imageNamed:@"events.png"]];
    [listIamgesFavorites addObject:[UIImage imageNamed:@"friends.png"]];
}


+ (UIImage*)        getFlagWithName:(NSString*) countryName{
    if ([countryName isEqualToString:@"Australia"]) {
        return [UIImage imageNamed:@"australia_flag.png"];
    }
    if ([countryName isEqualToString:@"Canada"]) {
        return [UIImage imageNamed:@"canada_flag.png"];
    }
    if ([countryName isEqualToString:@"United Kingdom"]||[countryName isEqualToString:@"UK"]) {
        return [UIImage imageNamed:@"uk_flag.png"];
    }
    if ([countryName isEqualToString:@"Malaysia"]) {
        return [UIImage imageNamed:@"malaysia_flag.png"];
    }
    if ([countryName isEqualToString:@"United States"]||[countryName isEqualToString:@"US"]) {
        return [UIImage imageNamed:@"us_flag.png"];
    }
    return [UIImage imageNamed:@"singapore_flag.png"];
}


-(IBAction) onTouchSignInBtn: (id) sender
{
    [self hidePopUpDialog:overlay];
    if (menuView.superview) {
        [menuView removeFromSuperview];
    }
    self.overlay = nil;
    isHideSideBar = YES;
    [self setHideSideBar];
    SignInVwCtrl *signInVwCtrl = [[SignInVwCtrl alloc] init];
    [self.navigationController pushViewController:signInVwCtrl animated:YES];
    self.navigationController.navigationBarHidden = YES;
}

-(IBAction) onTouchLogOutBtn: (id) sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"logOutListener" object:nil];
    
}

-(IBAction) onTouchCreateAccountBtn: (id) sender
{
    [self hidePopUpDialog:overlay];
    if (menuView.superview) {
        [menuView removeFromSuperview];
    }
    self.overlay = nil;
    isHideSideBar = YES;
    [self setHideSideBar];
    NewAccountVwCtrl *newAccVwCtrl = [[NewAccountVwCtrl alloc] init];
    [self.navigationController pushViewController:newAccVwCtrl animated:YES];
    self.navigationController.navigationBar.hidden = YES;
    
}
-(IBAction)onTouchCountry:(id)sender{
    if (self.popoverController) {
		[self.popoverController dismissPopoverAnimated:YES];
		self.popoverController = nil;
        self.tableView.userInteractionEnabled = YES;
	} else {
        self.tableView.userInteractionEnabled = NO;
        UIViewController *contentViewController = [[FlagViewController alloc] initWithStyle:UITableViewStylePlain];
		CGRect rect = ((UIButton*)sender).frame;
        rect.origin.y -= 2;
		
		self.popoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
		
		if ([self.popoverController respondsToSelector:@selector(setContainerViewProperties:)]) {
			[self.popoverController setContainerViewProperties:[self improvedContainerViewProperties]];
		}
		self.popoverController.delegate = self;
		self.popoverController.passthroughViews = [NSArray arrayWithObject:self.tableView];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedCountry) name:@"selectedCountry" object:nil];
		[self.popoverController presentPopoverFromRect:rect  
												inView:self.navigationController.navigationBar 
							  permittedArrowDirections:(UIPopoverArrowDirectionUp)
											  animated:YES];
        [self.popoverController.view setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin];
    }
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

- (void) selectedCountry
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectedCountry" object:nil];
    if (self.popoverController) {
		[self.popoverController dismissPopoverAnimated:YES];
		self.popoverController = nil;
	}
    if (menuView.superview) {
        [menuView removeFromSuperview];
        menuView = nil;
        menuView = [self drawPostAdvertTopMenu];
        [self.navigationController.navigationBar addSubview:menuView];
    }
    self.tableView.userInteractionEnabled = YES;
    [self.tableView reloadData];
}

- (void) setHideSideBar{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideSideBar" object:nil];
    
}

- (void) disableScrollTable{
    self.tableView.scrollEnabled = NO;
}
- (void) enableScrollTable{
    self.tableView.scrollEnabled = YES;
    NSLog(@"EnableScroll");
}

- (UIView*) createLoginListView
{
    UIView* loginListView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 460.0)];
    UIImageView *bgVw = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BG_popup_2.png"]]; /*LoginList_bg.png*/
    bgVw.frame = CGRectMake(8.0, 0.0, 304.0, 450.0);
    [loginListView addSubview:bgVw];
    
    CGRect rc = CGRectMake(45.0, 82.0, 200.0, 35.0);
    UILabel *label1 = [[UILabel alloc] initWithFrame:rc];
    label1.textColor = [UIColor whiteColor];
    label1.opaque = NO;
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:30.0];
    label1.text = @"PostAdvert";
    [loginListView addSubview:label1];
    
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
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", @"www.postAdvert.com"]]];
}

#pragma mark - Touch

- (WEPopoverContainerViewProperties *)improvedContainerViewProperties {
	
	WEPopoverContainerViewProperties *props = [WEPopoverContainerViewProperties alloc];
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


#pragma mark -
#pragma mark WEPopoverControllerDelegate implementation

- (void)popoverControllerDidDismissPopover:(WEPopoverController *)thePopoverController {
	//Safe to release the popover here
    self.tableView.userInteractionEnabled = YES;
	self.popoverController = nil;
}

- (BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)thePopoverController {
	//The popover is automatically dismissed if you click outside it, unless you return NO here
	return YES;
}

#pragma mark - GestureRecognizer Delegate
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
    //NSLog(@" %@ %@", NSStringFromClass([gestureRecognizer class]), NSStringFromClass([otherGestureRecognizer class]));
    // Prevent Scroll with other gesture
    
    NSString *gestureName = NSStringFromClass([otherGestureRecognizer class]);
    if([gestureName rangeOfString:@"UIScrollView" options:(NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch)].location != NSNotFound)
    {
        return NO;
    }
    return YES;
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
    if ([gestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]]) {
//        if ((UISwipeGestureRecognizer*)gestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft || (UISwipeGestureRecognizer*)gestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
//            return YES;
//        }
        return YES;
    }
    return NO;
}

@end