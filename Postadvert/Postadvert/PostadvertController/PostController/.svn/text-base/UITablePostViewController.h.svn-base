//
//  UITablePostViewController.h
//  Postadvert
//
//  Created by Mtk Ray on 7/27/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "PullRefreshTableViewController.h"
//@class SDWebImageRootViewController;
@interface UITablePostViewController :PullRefreshTableViewController <MBProgressHUDDelegate>
{
    NSMutableArray *listContent;
    NSMutableArray *listPostCell;
    NSMutableArray *listContentTemp;
    NSMutableArray *listPostCellTemp;
    MBProgressHUD *HUD;
    MBProgressHUD *footerLoading;
    MBProgressHUD *loadingHideView;
    NSString *wallIDstr ;
    NSString *fromstr ;
    NSString *totalstr ;
    NSInteger currentCellLoad;
    NSInteger totalCellLoad;
    UIActivityIndicatorView *activityView;
    BOOL isLoadData;
    NSInteger internalValue;
}

@property (nonatomic, weak) IBOutlet UITableView *myTableView;
@property (nonatomic, weak) UINavigationController *navigationController;
- (void) loadCellsWithWallID:(NSInteger)wallID From:(NSInteger)from Count:(NSInteger) count;
@end
