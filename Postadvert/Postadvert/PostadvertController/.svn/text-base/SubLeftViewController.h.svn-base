//
//  SubLeftViewController.h
//  PostAdvert11
//
//  Created by Ray Mtk on 24/4/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
@class DetailViewController;
@interface SubLeftViewController : PullRefreshTableViewController<UIGestureRecognizerDelegate>
{
    CGPoint previousPoint;
    UILabel *lbTitle;
    BOOL isload;
}
@property (nonatomic, strong) NSMutableArray *listItems;
@property (nonatomic, strong) NSMutableArray *listImages;
@property (nonatomic, strong) NSMutableArray *listNums;
@property (nonatomic, strong) DetailViewController *detailVw;
@property (nonatomic, strong) NSString       *itemName;

- (void) getSubNums;
@end
