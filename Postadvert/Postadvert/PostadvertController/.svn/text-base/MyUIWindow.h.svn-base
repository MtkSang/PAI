//
//  MyUIWindow.h
//  PostAdvert11
//
//  Created by Ray Mtk on 18/4/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
@class SideBarViewController;
@interface MyUIWindow : UIWindow
{
    SideBarViewController *sideBar;
    CGPoint startTouchPoint;
    BOOL isTouchBegan;
    BOOL isTouchMoved;
    BOOL isTouchEnd;
    BOOL shouldSendEvent;
    UIEvent *beganEvent;
    NSMutableSet *beginEvent;
    NSInteger touchCount;
    NSInteger direction;
    UITouch *touchBegan;
    NSMutableArray *lastLocations;
    NSMutableArray *lastTimes;
    
    SideBaState stateSideBar;
}
@property (nonatomic ) NSInteger sideBarState;
@end
