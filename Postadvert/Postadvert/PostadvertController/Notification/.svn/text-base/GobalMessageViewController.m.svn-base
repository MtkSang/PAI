//
//  GobalMessageViewController.m
//  Postadvert
//
//  Created by Mtk Ray on 6/18/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "GobalMessageViewController.h"
#import "Constants.h"
#import "MessageCellContent.h"
#import "UIMessageCell.h"
#import "UserPAInfo.h"
#import <QuartzCore/QuartzCore.h>
#import "ChatViewController.h"
@interface GobalMessageViewController ()
- (void) loadListMessageCellContent;
@end

@implementation GobalMessageViewController
@synthesize topView = _topView;
@synthesize tableView = _tableView;
@synthesize navigationController = _navigationController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        listMessageCellContent = [[NSMutableArray alloc] init];
        //self.contentSizeForViewInPopover = CGSizeMake(100, 100);
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
    listMessageCellContent = nil;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadListMessageCellContent];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"Rorote");
}
#pragma mark - implement

- (void) loadListMessageCellContent
{
    if(listMessageCellContent == nil)
        listMessageCellContent = [[NSMutableArray alloc] init];
    [listMessageCellContent removeAllObjects];
    
    MessageCellContent *message = [[MessageCellContent alloc]init];
    message.text = @"Thank you!";
    message.userPostName = [UserPAInfo sharedUserPAInfo].usernamePU;
    message.userAvatar = [UserPAInfo sharedUserPAInfo].imgAvatar;
    message.datePost = [NSDate date];
    
    [listMessageCellContent addObject:message];
    
    MessageCellContent *message2 = [[MessageCellContent alloc]init];
    message2.text = @"あなたも";
    message2.userAvatar = [UserPAInfo sharedUserPAInfo].imgAvatar;
    message2.userPostName = @"Ray";
    message2.datePost = [NSDate date];
    
    [listMessageCellContent addObject:message2];
    
    for (int i =1; i < 10; i++) {
        MessageCellContent *message3 = [[MessageCellContent alloc]init];
        message3.userPostName = [NSString stringWithFormat:@"User %d", i];
        message3.userAvatar = [UserPAInfo sharedUserPAInfo].imgAvatar;
        message3.text = [NSString stringWithFormat:@"This is an automatic text %d",i];
        message3.datePost = [NSDate distantPast];
        [listMessageCellContent addObject:message3];
    }
    
    [self.tableView reloadData];
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
    return listMessageCellContent.count;
}

- (UITableViewCell *)tableView:(UITableView *)ctableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UIMessageCell";
    UIMessageCell *cell = [ctableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UIMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.message.text = ((MessageCellContent*)[listMessageCellContent objectAtIndex:indexPath.row]).text;
    cell.imageView.image = ((MessageCellContent*)[listMessageCellContent objectAtIndex:indexPath.row]).userAvatar;
    cell.userPostName.text = ((MessageCellContent*)[listMessageCellContent objectAtIndex:indexPath.row]).userPostName;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM:dd:yy"];
    NSString *theDate = [dateFormat stringFromDate:((MessageCellContent*)[listMessageCellContent objectAtIndex:indexPath.row]).datePost];
    cell.postTime.text = theDate;
    theDate = nil;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47 ;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    //Send data to LeftViewCntroller
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[listMessageCellContent objectAtIndex:indexPath.row] forKey:@"MessageCellContent"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DetailMessageListenner" object:nil userInfo:dict];
}
-( UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}

@end
