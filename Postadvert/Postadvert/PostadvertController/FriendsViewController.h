//
//  FriendsViewController.h
//  Postadvert
//
//  Created by Mtk Ray on 7/3/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendsViewControllerDelegate;

@interface FriendsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>
{
    id <FriendsViewControllerDelegate> delegate;
    NSMutableArray *listFriendCellContent;
    NSMutableArray *filteredListContent;
    NSMutableArray *sectionedListContent;  // The content filtered into alphabetical sections.
    IBOutlet UITableView *tableView;
    UINavigationController *navigationController;
    NSInteger totalFriends;
    NSInteger currentIndex_friend;
    BOOL isLoadData;
}
//@property (nonatomic, strong) NSMutableArray *listMessageCellContent;
//@property (nonatomic, strong) NSMutableArray *filteredListContent;
@property (nonatomic, weak) id <FriendsViewControllerDelegate> delegate;
@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityView;

- (NSInteger)getTotalFriends;
- (id)getFriendsFrom:(NSInteger)start count:(NSInteger)count;
@end

@protocol FriendsViewControllerDelegate
- (void) friendsViewControllerDidSelectedRowWithInfo:(NSDictionary*)info;
@end