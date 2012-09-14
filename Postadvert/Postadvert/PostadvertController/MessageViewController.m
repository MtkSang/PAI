//
//  MessageViewController.m
//  Postadvert
//
//  Created by Mtk Ray on 6/28/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCellContent.h"
#import "Constants.h"
#import "UIMessageCell.h"
#import "UserPAInfo.h"
@interface MessageViewController ()
- (void) loadlistMessageCellContent;
@end

@implementation MessageViewController
@synthesize delegate = _delegate;
@synthesize tableView = _tableView;
//@synthesize listMessageCellContent = _listMessageCellContent;
//@synthesize filteredListContent =filteredListContent;
@synthesize navigationController = _navigationController;
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
    [self.view setAutoresizesSubviews:YES];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    // Do any additional setup after loading the view from its nib.
    [self loadlistMessageCellContent];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - tableViewDataSource
-(NSInteger)tableView:(UITableView *)ctableView numberOfRowsInSection:(NSInteger)section
{
    if (ctableView == self.searchDisplayController.searchResultsTableView)
    {
        return [filteredListContent count];
    }
    else
    {
        return [listMessageCellContent count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)ctableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"UIMessageCell";        
    // Try to retrieve from the table view a now-unused cell with the given identifier.
    UIMessageCell *cell = [ctableView dequeueReusableCellWithIdentifier:MyIdentifier];        
    // If no cell is available, create a new one using the given identifier.
    if (cell == nil) {
        cell = [[UIMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    MessageCellContent *cellCentent;
    if (ctableView == self.searchDisplayController.searchResultsTableView)
	{
        cellCentent = ((MessageCellContent*)[filteredListContent objectAtIndex:indexPath.row]);
    }
	else
	{
        cellCentent = ((MessageCellContent*)[listMessageCellContent objectAtIndex:indexPath.row]);
    }

    
    cell.message.text = cellCentent.text;
    cell.imageView.image = cellCentent.userAvatar;
    cell.userPostName.text = cellCentent.userPostName;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM:dd:yy"];
    NSString *theDate = [dateFormat stringFromDate:cellCentent.datePost];
    cell.postTime.text = theDate;
    theDate = nil;
    cellCentent = nil;

    return cell;   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)ctableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCellContent *cellContent = nil;
    if (ctableView == self.searchDisplayController.searchResultsTableView)
    {
        cellContent = [filteredListContent objectAtIndex:indexPath.row];
        [self.searchDisplayController.searchBar resignFirstResponder];
    }
    else
    {
        cellContent = [listMessageCellContent objectAtIndex:indexPath.row];
    }
    NSDictionary *dict = [NSDictionary dictionaryWithObject:cellContent forKey:@"MessageCellContent"];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"DetailMessageListenner" object:nil userInfo:dict];
    if (self.delegate) {
        [self.delegate messageViewControllerDidSelectedRowWithInfo:dict];
    }
    [ctableView deselectRowAtIndexPath:indexPath animated:YES];
    cellContent = nil;
}



#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
   //[self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    //[self.navigationController setNavigationBarHidden:NO animated:NO];
    //navigationController.navigationBarHidden = YES;
    if (self.delegate) {
        [self.delegate searchDisplayControllerDidEnterSearch];
    }
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    
}
- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    if (self.delegate) {
        [self.delegate  searchDisplayControllerDidGoAwaySearch];
    }
}



- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    //No sort this time
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]];
    [filteredListContent setArray:[filteredListContent sortedArrayUsingComparator:^(id firstObject, id secondObject) {
        if (searchOption == 1) {
            return [((NSString *)firstObject) compare:((NSString *)secondObject) options:NSNumericSearch | NSForcedOrderingSearch];
        }
        if (searchOption == 2) {
            NSComparisonResult result= [((NSString *)firstObject) compare:((NSString *)secondObject) options:NSNumericSearch | NSForcedOrderingSearch];
            if (result ==  NSOrderedAscending) {
                
                return NSOrderedDescending;
                
            } else {
                
                if (result == NSOrderedAscending) {
                    return NSOrderedAscending;
                }
            }
        }
        return NSOrderedSame;
        
        
    }]] ;
    return YES;
}

#pragma mark - implement

- (void) loadlistMessageCellContent
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
    if (listMessageCellContent.count) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
}


#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText
{
    if (filteredListContent == nil) {
        filteredListContent = [[NSMutableArray alloc] init];
    }
	[filteredListContent removeAllObjects]; // First clear the filtered array.
	for (int i = 0; i< listMessageCellContent.count; i++)
	{
		/*
         //EX: "vendor" vs "vendor 123" => OK , but "123" vs  "vendor 123" => Fail
         NSComparisonResult result = [vendor compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
         if (result == NSOrderedSame)
         {
         [self.filteredListContent addObject:vendor];
         }
         */
        //EX: "vendor" vs "vendor 123" => OK , "123" vs  "vendor 123" => OK
        MessageCellContent *content = [listMessageCellContent objectAtIndex:i];
        NSLog(@"Search text %@, text: %@",content.text  ,searchText);
        
        if([content.text rangeOfString:searchText options:(NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch)].location != NSNotFound)
        {
            [filteredListContent addObject:content];
        }
		
	}
    if (filteredListContent.count == 0) {
        //Search message sender
        for (int i = 0; i< listMessageCellContent.count; i++)
        {
            MessageCellContent *content = [listMessageCellContent objectAtIndex:i];
            
            NSArray *arrayName = [content.userPostName componentsSeparatedByString:@" "];
            NSArray *arraySearchText = [searchText componentsSeparatedByString:@" "];
            //maxindex = smallest count
            NSInteger maxIndex = (arrayName.count > arraySearchText.count)? arraySearchText.count : arrayName.count;
            maxIndex = maxIndex - 1;
            NSInteger numLoop = arrayName.count - arraySearchText.count;
            if (numLoop > maxIndex) {
                numLoop = maxIndex;
            }
    
            for (int i = 0; i <= numLoop; i++) {
                int indexOftextName = 0;
                int j = i;
                NSString *textName = [arrayName objectAtIndex:indexOftextName];
                NSString *textSearch = [arraySearchText objectAtIndex:i];
                
                while ([textName compare:textSearch options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [textName length])] == NSOrderedSame)
                {
                    NSLog(@"Search text %@, text: %@",textSearch, textName);
                    if (indexOftextName == maxIndex) {
                        //All is same
                        [filteredListContent addObject:content];
                        break;
                    }
                    j++;
                    indexOftextName++;
                    textName = [arrayName objectAtIndex:indexOftextName];
                    textSearch = [arraySearchText objectAtIndex:j];
                }
            }
        }
    }
    
    NSLog(@"Search Count %d", filteredListContent.count);
    
}
@end
