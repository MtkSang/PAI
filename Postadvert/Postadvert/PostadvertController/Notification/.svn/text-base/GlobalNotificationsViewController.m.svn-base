//
//  GlobalNotificationsViewController.m
//  Postadvert
//
//  Created by Mtk Ray on 6/26/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "GlobalNotificationsViewController.h"
#import "NotificationsCellContent.h"
#import "UINotificationsCell.h"
#import "UserPAInfo.h"
#import "Constants.h"
@interface GlobalNotificationsViewController ()
- (void) loadListNotificationsContent;
@end

@implementation GlobalNotificationsViewController
@synthesize topView = _topView;
@synthesize tableView = _tableView;
@synthesize delegate = _delegate;
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadListNotificationsContent];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    return listNotificationsCellContent.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UINotificationsCell";
    UINotificationsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UINotificationsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setCellContent:[listNotificationsCellContent objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [(NotificationsCellContent*)[listNotificationsCellContent objectAtIndex:indexPath.row] getFullText];
    CGSize constraint = CGSizeMake(265,2000);
    CGSize size = [text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    return 40 + size.height ;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)ctableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [ctableView deselectRowAtIndexPath:indexPath animated:YES];
    //    //Send data to DetailViewCntroller
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[listNotificationsCellContent objectAtIndex:indexPath.row] forKey:@"NotificationsCellContent"];
    if (self.delegate) {
        [self.delegate didSelectedRowWithInfo:dict];
    }
}
-( UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}

#pragma mark -implement

- (void) loadListNotificationsContent
{
    if(listNotificationsCellContent == nil)
        listNotificationsCellContent = [[NSMutableArray alloc] init];
    [listNotificationsCellContent removeAllObjects];
    
    NotificationsCellContent *notifi = [[NotificationsCellContent alloc]init];
    notifi.text = @"Test Notification!";
    notifi.userPostName = @"David";
    notifi.userAvatar = [UserPAInfo sharedUserPAInfo].imgAvatar;
    notifi.timeNotifications = [NSDate date];
    notifi.actionText = @"commented on your";
    notifi.toObject = @"post";
    
    [listNotificationsCellContent addObject:notifi];
    
    [self.tableView reloadData];
}


@end
