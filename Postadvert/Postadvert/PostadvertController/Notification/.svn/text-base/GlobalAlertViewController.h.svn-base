//
//  GlobalAlertViewController.h
//  Postadvert
//
//  Created by Mtk Ray on 6/27/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GlobalAlertViewControllerDelegate;
@interface GlobalAlertViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    id <GlobalAlertViewControllerDelegate> delegate;
    IBOutlet UITableView *tableView;
    
    NSMutableArray *listAlertCellContent;
}
@property (nonatomic, weak) id <GlobalAlertViewControllerDelegate> delegate;
@property ( nonatomic, weak)     IBOutlet UITableView *tableView;
@end
@protocol GlobalAlertViewControllerDelegate
- (void) alertDidSelectedRowWithInfo:(NSDictionary*)info;

@end
