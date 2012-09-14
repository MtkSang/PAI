//
//  UserProfileViewController.h
//  Postadvert
//
//  Created by Ray on 9/12/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
@interface UserProfileViewController :PullRefreshTableViewController
{
    IBOutlet UIView *headerViewSection;
}
@property (nonatomic, strong) IBOutlet UIView *headerViewSection;
@end
