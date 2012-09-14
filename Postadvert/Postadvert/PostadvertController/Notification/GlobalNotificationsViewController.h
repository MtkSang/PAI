//
//  GlobalNotificationsViewController.h
//  Postadvert
//
//  Created by Mtk Ray on 6/26/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GlobalNotificationsViewControllerDelegate;
@interface GlobalNotificationsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    id <GlobalNotificationsViewControllerDelegate> delegate;
    IBOutlet UILabel *titleMessage;
    IBOutlet UIView* topView;
    NSMutableArray *listNotificationsCellContent;
}
@property (nonatomic, weak) id <GlobalNotificationsViewControllerDelegate> delegate;
@property (nonatomic, weak) IBOutlet UIView* topView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;


@end

@protocol GlobalNotificationsViewControllerDelegate
- (void) didSelectedRowWithInfo:(NSDictionary*)info;

@end
