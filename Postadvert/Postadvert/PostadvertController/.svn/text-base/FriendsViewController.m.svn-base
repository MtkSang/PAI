//
//  FriendsViewController.m
//  Postadvert
//
//  Created by Mtk Ray on 7/3/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "FriendsViewController.h"
#import "PostAdvertControllerV2.h"
#import "Constants.h"
#import "CredentialInfo.h"
#import "UserPAInfo.h"
#import "UIImageView+URL.h"
@interface NSArray (SSArrayOfArrays)
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
@end

@implementation NSArray (SSArrayOfArrays)
- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
}

@end

@interface NSMutableArray (SSArrayOfArrays)
// If idx is beyond the bounds of the reciever, this method automatically extends the reciever to fit with empty subarrays.
- (void)addObject:(id)anObject toSubarrayAtIndex:(NSUInteger)idx;
@end

@implementation NSMutableArray (SSArrayOfArrays)

- (void)addObject:(id)anObject toSubarrayAtIndex:(NSUInteger)idx
{
    while ([self count] <= idx) {
        [self addObject:[NSMutableArray array]];
    }
    NSLog(@"Total %d, newindex %d", [self count], idx);
    
    [[self objectAtIndex:idx] addObject:anObject];
}

@end

@interface FriendsViewController ()
- (void) loadlistFriendCellContent;
- (void) plusLastFriends;
@end

@implementation FriendsViewController
@synthesize delegate = _delegate;
@synthesize tableView = _tableView;
//@synthesize listMessageCellContent = _listMessageCellContent;
//@synthesize filteredListContent =filteredListContent;
@synthesize navigationController = _navigationController;
@synthesize activityView = _activityView;
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
    NSLog(@"%@: %@", NSStringFromClass([self class]), self.view);
    [self performSelectorInBackground:@selector(getTotalFriends) withObject:nil];
    
    [self.activityView startAnimating];
    [self performSelectorInBackground:@selector(loadlistFriendCellContent) withObject:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.activityView.center = self.view.center;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
         return [[sectionedListContent objectAtIndex:section] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)ctableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"UITableViewCellFriend";        
    // Try to retrieve from the table view a now-unused cell with the given identifier.
    UITableViewCell *cell = [ctableView dequeueReusableCellWithIdentifier:MyIdentifier];        
    // If no cell is available, create a new one using the given identifier.
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    CredentialInfo *cellCentent = nil;
    if (ctableView == self.searchDisplayController.searchResultsTableView)
	{
        cellCentent = ((CredentialInfo*)[filteredListContent objectAtIndex:indexPath.row]);
    }
	else
	{
        cellCentent = ((CredentialInfo*)[sectionedListContent objectAtIndexPath:indexPath]);
    }
//    if (!cellCentent.imgAvatar) {
//        cellCentent.imgAvatar = [UIImage imageNamed:@"user_default_thumb.png"];
//        
//    }
    [cell.imageView setImageWithURL:[NSURL URLWithString: cellCentent.avatarUrl] placeholderImage:[UIImage imageNamed:@"user_default_thumb.png"]];
    cell.textLabel.text = cellCentent.fullName;
    ctableView.scrollEnabled = YES;
    return cell;   
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 47;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)ctableView
{
    if (ctableView == self.searchDisplayController.searchResultsTableView)
	{
        return 1;
    }
	else
	{
        return [sectionedListContent count];
    }
}


- (NSString *)tableView:(UITableView *)ctableView titleForHeaderInSection:(NSInteger)section
{
	if (ctableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    } else {
        return [[sectionedListContent objectAtIndex:section] count] ? [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section] : nil;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)ctableView
{
    if (ctableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    } else {
        return [[NSArray arrayWithObject:UITableViewIndexSearch] arrayByAddingObjectsFromArray:
                [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
    }
}

- (NSInteger)tableView:(UITableView *)ctableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (ctableView == self.searchDisplayController.searchResultsTableView) {
        return 0;
    } else {
        if (title == UITableViewIndexSearch) {
            [ctableView scrollRectToVisible:self.searchDisplayController.searchBar.frame animated:NO];
            return -1;
        } else {
            return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index-1];
        }
    }
}
#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)ctableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CredentialInfo *cellCentent = nil;
    if (ctableView == self.searchDisplayController.searchResultsTableView)
	{
        cellCentent = ((CredentialInfo*)[filteredListContent objectAtIndex:indexPath.row]);
    }
	else
	{
        cellCentent = ((CredentialInfo*)[sectionedListContent objectAtIndexPath:indexPath]);
    }

    NSDictionary *dict = [NSDictionary dictionaryWithObject:cellCentent forKey:@"FriendCellContent"];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"DetailMessageListenner" object:nil userInfo:dict];
    if (self.delegate) {
        [self.delegate friendsViewControllerDidSelectedRowWithInfo:dict];
    }
    [ctableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    //No sort this time
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]];
    return YES;
}

#pragma mark -
#pragma mark UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (([scrollView contentOffset].y + scrollView.frame.size.height) + self.tableView.tableFooterView.frame.size.height >= [scrollView contentSize].height * 4.0 / 5.0) {
        NSLog(@"scrolled to bottom");
        if (! isLoadData) {
            
        }
        return;
	}
	if ([scrollView contentOffset].y == scrollView.frame.origin.y) {
        NSLog(@"scrolled to top ");
        
	}
    
    
}

#pragma mark - implement

- (void) loadlistFriendCellContent
{
    isLoadData = YES;
    if(listFriendCellContent == nil)
        listFriendCellContent = [[NSMutableArray alloc] init];
    [listFriendCellContent removeAllObjects];
    if(sectionedListContent == nil)
        sectionedListContent = [[NSMutableArray alloc] init];
    [sectionedListContent removeAllObjects];
    NSInteger count = 20;
    count = 20 < totalFriends ? 20 : totalFriends;
    if (!count) {
        count = 1;
    }
    NSMutableArray *friends = [self getFriendsFrom:0 count:count];
    for (CredentialInfo *friend in friends) {
        [listFriendCellContent addObject:friend];
    }
    currentIndex_friend = listFriendCellContent.count;
    friends = nil;
    //
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    for (CredentialInfo *_id in listFriendCellContent) {
        NSInteger section = [collation sectionForObject:_id collationStringSelector:@selector(fullName)];
        [sectionedListContent addObject:_id toSubarrayAtIndex:section];
    }
    
    NSInteger section = 0;
    for (section = 0; section < [sectionedListContent count]; section++) {
        NSArray *sortedSubarray = [collation sortedArrayFromArray:[sectionedListContent objectAtIndex:section]
                                          collationStringSelector:@selector(fullName)];
        [sectionedListContent replaceObjectAtIndex:section withObject:sortedSubarray];
    }
    //
    [self.tableView reloadData];
    if (sectionedListContent.count) {
        //[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    self.activityView.hidden = YES;
    [self.activityView stopAnimating];
}

- (NSInteger)getTotalFriends{
        totalFriends = [[PostadvertControllerV2 sharedPostadvertController]countFriendOfUser:@"0"];
    return totalFriends;
}

-(id)getFriendsFrom:(NSInteger)start count:(NSInteger)count
{
    NSMutableArray *friends =  [[PostadvertControllerV2 sharedPostadvertController]getFriendsOfUserID:@"0" from:[NSString stringWithFormat:@"%d",start] count:[NSString stringWithFormat:@"%d",count]];
    
    NSMutableArray *listFriends = [[NSMutableArray alloc]initWithCapacity:friends.count];
    for (NSDictionary *dict in friends) {
        NSLog(@"Friends %@", dict);
        CredentialInfo *friendInfo = [[CredentialInfo alloc]init];
        friendInfo.email = [dict objectForKey:@"email"];
        friendInfo.fullName = [dict objectForKey:@"name"];
        friendInfo.avatarUrl = [dict objectForKey:@"thumb"];
        [listFriends addObject:friendInfo];
    }
    return listFriends;
}

- (void) plusLastFriends
{
    if (currentIndex_friend >= totalFriends) {
        return;
    }
    if (isLoadData) {
        return;
    }
    isLoadData = YES;
    if(listFriendCellContent == nil)
        listFriendCellContent = [[NSMutableArray alloc] init];
    if(sectionedListContent == nil)
        sectionedListContent = [[NSMutableArray alloc] init];
    NSInteger count = totalFriends - currentIndex_friend;
    count = MIN(20, count);
    if (count < 0) {
        count = 0;
    }
    NSMutableArray *friends = [self getFriendsFrom:currentIndex_friend count:count];
    for (CredentialInfo *friend in friends) {
        [listFriendCellContent addObject:friend];
    }
    currentIndex_friend = listFriendCellContent.count;
    friends = nil;
    //
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    for (CredentialInfo *_id in listFriendCellContent) {
        NSInteger section = [collation sectionForObject:_id collationStringSelector:@selector(fullName)];
        [sectionedListContent addObject:_id toSubarrayAtIndex:section];
    }
    
    NSInteger section = 0;
    for (section = 0; section < [sectionedListContent count]; section++) {
        NSArray *sortedSubarray = [collation sortedArrayFromArray:[sectionedListContent objectAtIndex:section]
                                          collationStringSelector:@selector(fullName)];
        [sectionedListContent replaceObjectAtIndex:section withObject:sortedSubarray];
    }
    //
    [self.tableView reloadData];
    if (sectionedListContent.count) {
        //[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    self.activityView.hidden = YES;
    [self.activityView stopAnimating];
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText
{
    if (filteredListContent == nil) {
        filteredListContent = [[NSMutableArray alloc] init];
    }
	[filteredListContent removeAllObjects]; // First clear the filtered array.
	for (int i = 0; i< listFriendCellContent.count; i++)
	{
        CredentialInfo *content = [listFriendCellContent objectAtIndex:i];
        
        if([content.fullName rangeOfString:searchText options:(NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch)].location != NSNotFound)
        {
            [filteredListContent addObject:content];
        }
		
	}
    NSLog(@"Search Count %d", filteredListContent.count);
    
}
@end
