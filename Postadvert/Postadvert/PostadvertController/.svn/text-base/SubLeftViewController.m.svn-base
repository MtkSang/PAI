//
//  SubLeftViewController.m
//  PostAdvert11
//
//  Created by Ray Mtk on 24/4/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import "SubLeftViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"
#import "DetailViewController.h"
#import "UserPAInfo.h"
#import "SupportFunction.h"
#import "PostadvertControllerV2.h"
@interface SubLeftViewController ()
- (UIGestureRecognizer*) addPanGesture:(id)target;
- (void) handlePanGesture:(UIPanGestureRecognizer*) gesture;
- (void) addTitle;

@end

@implementation SubLeftViewController
@synthesize detailVw;
@synthesize listItems, listImages;
@synthesize listNums;
@synthesize itemName = _itemName;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        //view.backgroundColor =[UIColor colorWithRed:79 green:178 blue:187 alpha:1.0];
        listItems = [[NSMutableArray alloc] init];
        listNums = [[NSMutableArray alloc]init];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"bg_1.png"]];
        self.tableView.backgroundView = imageView;
        imageView = nil;
        self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"div.png"]];
        UIView *footerView = [[UIView alloc]init];
        self.tableView.tableFooterView = footerView;
        footerView = nil;
        
//        [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_1.png"]]];
//        [self.tableView setBackgroundColor:[UIColor colorWithRed:79 green:178 blue:187 alpha:1.0]];
//        UIView *footerView = [[UIView alloc]init];
//        self.tableView.tableFooterView = footerView;
//        footerView = nil;
//        self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"div.png"]];
    }
    return self;
}


- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden = NO;
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disableScrollTable) name:@"disableScrollTable" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableScrollTable) name:@"enableScrollTable" object:nil];
    
    [self.view addGestureRecognizer:[self addPanGesture:self]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (!listNums) {
        listNums = [[NSMutableArray alloc]init];
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // e.g. self.myOutlet = nil;
    self.listItems = nil;
    self.listImages = nil;
}
- (void) viewWillAppear:(BOOL)animated
{
    [self addTitle];
    [super viewWillAppear:animated];
    isload = YES;
    [self performSelectorInBackground:@selector(getSubNums) withObject:nil];
    //Set up title
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (lbTitle.superview) {
        [lbTitle removeFromSuperview];
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;

}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //[self.navigationController.navigationBar setTitleVerticalPositionAdjustment: -10 forBarMetrics:UIBarMetricsDefault];
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.0];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return listItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cCellHeight;
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    cell.detailTextLabel.frame = CGRectMake(cMaxLeftView - 100, 0.0, 70, cCellHeight);
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SubCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityView.frame = CGRectMake(self.view.frame.size.width - cRemainView - activityView.frame.size.width - 15.0 , (cCellHeight - activityView.frame.size.height) / 2.0, activityView.frame.size.width + 10.0 , activityView.frame.size.height);
        activityView.tag = 2;
        [cell addSubview:activityView];
    }
    
    cell.textLabel.text = [listItems objectAtIndex:indexPath.row];
    cell.imageView.image = [listImages objectAtIndex:indexPath.row];
    UILabel *labelNum = (UILabel*)[cell viewWithTag:1];
    if (labelNum == nil) {
        labelNum = [[UILabel alloc]init];
        [labelNum setTextAlignment:UITextAlignmentCenter];
        [labelNum setBackgroundColor:[UIColor grayColor]];
        [labelNum setTextColor:[UIColor whiteColor]];
        [labelNum setTag:1];
        [cell.contentView addSubview:labelNum];
    }
    if (!isload) {
        if (listNums.count >= indexPath.row) {
            labelNum.text = [NSString stringWithFormat:@"%d", [(NSNumber*)[listNums objectAtIndex:indexPath.row]intValue ]];
            UIActivityIndicatorView *activityView = (UIActivityIndicatorView*)[cell viewWithTag:2];
            [activityView stopAnimating ];
        }else {
            labelNum.text = @"0";
        }
    }else {
        labelNum.text = @"";
        UIActivityIndicatorView *activityView = (UIActivityIndicatorView*)[cell viewWithTag:2];
        [activityView startAnimating ];
    }
    [labelNum sizeToFit];
    labelNum.frame = CGRectMake(self.view.frame.size.width - cRemainView - labelNum.frame.size.width - 15.0 , (cCellHeight - labelNum.frame.size.height) / 2.0, labelNum.frame.size.width + 10.0 , labelNum.frame.size.height);
    NSLog(@"SubLeftView  %@", self.view);

    NSLog(@"lable NUM %@", labelNum);
    [cell.contentView bringSubviewToFront:labelNum];
    //labelNum = nil;
    //cell.detailTextLabel.text =[NSString stringWithFormat:@"%d", [(NSNumber*)[listNums objectAtIndex:indexPath.row]intValue ]];
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (tableView.scrollEnabled == NO) {
        return;
    }
    [self.detailVw.lbTitle setText: [NSString stringWithFormat:@"  %@", [listItems objectAtIndex:indexPath.row]]];
     NSDictionary *dict = [NSDictionary dictionaryWithObject:[listItems objectAtIndex:indexPath.row] forKey:@"itemName"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showDetailFromSubView" object:nil userInfo:dict];
}
#pragma overwrite supper

- (void) refresh
{
    
    isload = YES;
//    NSMutableArray *new_listNums = [[NSMutableArray alloc]init];
//    for (NSString* itemName in listItems) {
//        NSInteger  wallID = 0;
//        NSInteger countryID = 190;
//        countryID = [SupportFunction GetCountryIdFromConutryName:[UserPAInfo sharedUserPAInfo].userCountryPA];
//        wallID = [SupportFunction getWallIdFromCountryID:countryID andItemName:itemName];
//        NSNumber *num = [[PostadvertControllerV2 sharedPostadvertController] getCountPostsWithWallId:[NSString stringWithFormat:@"%d", wallID]];
//        [new_listNums addObject:num];
//    }
//    isload = NO;
//    listNums = new_listNums;
//    [self stopLoading];
//    [self.tableView reloadData];
    isload = YES;
    //[self performSelectorOnMainThread:@selector(getSubNums) withObject:nil waitUntilDone:YES];
    [self performSelectorInBackground:@selector(getSubNums) withObject:nil];
}

#pragma mark - Implement
- (void) getSubNums
{
    isload = YES;
    if ( ! listNums) {
        listNums = [[NSMutableArray alloc]init];
    }
    NSMutableArray *new_listNums = [[NSMutableArray alloc]init];
    for (NSString* itemName in listItems) {
        NSInteger  wallID = 1;
        NSInteger countryID = 190;
        countryID = [SupportFunction GetCountryIdFromConutryName:[UserPAInfo sharedUserPAInfo].userCountryPA];
        wallID = [SupportFunction getWallIdFromCountryID:countryID andItemName:itemName];
        NSNumber *num = [[PostadvertControllerV2 sharedPostadvertController] getCountPostsWithWallId:[NSString stringWithFormat:@"%d", wallID]];
        [new_listNums addObject:num];
    }
    isload = NO;
    listNums = new_listNums;
    [self stopLoading];
    [self.tableView reloadData];
}

- (void) addTitle{
//    lbTitle = nil;
//    CGRect frame = self.navigationController.navigationBar.frame;
//    
//    lbTitle = [[UILabel alloc]initWithFrame:CGRectMake(160, 0.0, frame.size.width, frame.size.height)];
//    [lbTitle setBackgroundColor:[UIColor clearColor]];
//    [lbTitle setTextAlignment:UITextAlignmentCenter];
//    [lbTitle setTextColor:[UIColor whiteColor]];
//    [lbTitle setText:_itemName];
//    //[lbTitle setTextColor:[UIColor redColor]];
//    lbTitle.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
//    [self.navigationController.navigationBar addSubview:lbTitle];
//    [UIView animateWithDuration:0.35
//                          delay:0.0
//                        options: UIViewAnimationCurveEaseOut
//                     animations:^{
//                         [lbTitle setFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
//                     } 
//                     completion:^(BOOL finished){
//                         NSLog(@"Done!");
//                     }];

    
    //lbTitle = nil;
    self.title = _itemName;

}

- (void) disableScrollTable{
    self.tableView.scrollEnabled = NO;
}
- (void) enableScrollTable{
    self.tableView.scrollEnabled = YES;
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
