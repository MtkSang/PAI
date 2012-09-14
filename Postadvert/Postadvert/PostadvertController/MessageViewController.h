//
//  MessageViewController.h
//  Postadvert
//
//  Created by Mtk Ray on 6/28/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MessageViewControllerDelegate;
@interface MessageViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>
{
    id <MessageViewControllerDelegate> delegate;
    NSMutableArray *listMessageCellContent;
    NSMutableArray *filteredListContent;
    IBOutlet UITableView *tableView;
    UINavigationController *navigationController;
}
//@property (nonatomic, strong) NSMutableArray *listMessageCellContent;
//@property (nonatomic, strong) NSMutableArray *filteredListContent;
@property (nonatomic, weak) id <MessageViewControllerDelegate> delegate;
@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@protocol MessageViewControllerDelegate
- (void) searchDisplayControllerDidEnterSearch;
- (void) searchDisplayControllerDidGoAwaySearch;
- (void) messageViewControllerDidSelectedRowWithInfo:(NSDictionary*)info;
@end