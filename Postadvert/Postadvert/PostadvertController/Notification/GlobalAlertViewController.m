//
//  GlobalAlertViewController.m
//  Postadvert
//
//  Created by Mtk Ray on 6/27/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "GlobalAlertViewController.h"
#import "AlertCellContent.h"
#import "UIAlertCell.h"
#import "UserPAInfo.h"
@interface GlobalAlertViewController ()

@end

@implementation GlobalAlertViewController
@synthesize delegate = _delegate;
@synthesize tableView = _tableView;
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
    [self loadListMessageCellContent];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    if(listAlertCellContent == nil)
        listAlertCellContent = [[NSMutableArray alloc] init];
    [listAlertCellContent removeAllObjects];
    
    AlertCellContent *alertContent = [[AlertCellContent alloc] init];
    alertContent.imageAvatar = [[UserPAInfo sharedUserPAInfo] imgAvatar];
    alertContent.userPostName = @"Thomas";
    alertContent.numMutiFriends = 2;
    [listAlertCellContent addObject:alertContent];
    alertContent = nil;
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
    return listAlertCellContent.count;
}

- (UITableViewCell *)tableView:(UITableView *)ctableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UIAlertCell";
    UIAlertCell *cell = [ctableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UIAlertCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.imageAvatar.image = ((AlertCellContent*)[listAlertCellContent objectAtIndex:indexPath.row]).imageAvatar;
    cell.userName.text = ((AlertCellContent*)[listAlertCellContent objectAtIndex:indexPath.row]).userPostName;
    NSInteger num = ((AlertCellContent*)[listAlertCellContent objectAtIndex:indexPath.row]).numMutiFriends;
    if (num) {
        if (num == 1) {
            cell.mutiFriends.text =@"1 mutual friend";
        } else {
            cell.mutiFriends.text = [NSString stringWithFormat:@"%d mutual friends", num];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72 ;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)ctableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [ctableView deselectRowAtIndexPath:indexPath animated:YES];
    //    //Send data to LeftViewCntroller
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[listAlertCellContent objectAtIndex:indexPath.row] forKey:@"AlertCellContent"];
    if (self.delegate) {
        [self.delegate alertDidSelectedRowWithInfo:dict];
    }
}
-( UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
@end
