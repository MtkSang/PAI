//
//  ActivityViewController.h
//  Postadvert
//
//  Created by Ray on 8/30/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "PullRefreshTableViewController.h"
@interface ActivityViewController : PullRefreshTableViewController<MBProgressHUDDelegate>
{
    NSMutableArray *listContent;
    NSMutableArray *listActivityCell;
    MBProgressHUD *footerLoading;
    MBProgressHUD *loadingHideView;
    MBProgressHUD *HUD;
    BOOL isLoadData;
    long lastUserId;
}
@property (nonatomic) long lastUserID;
@end
