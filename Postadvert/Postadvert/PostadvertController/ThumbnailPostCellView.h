//
//  ThumbnailPostCellView.h
//  Postadvert
//
//  Created by Mtk Ray on 7/18/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PostCellContent;
@interface ThumbnailPostCellView : UIView<UIGestureRecognizerDelegate>
{
    CGPoint previousPoint;
    CGPoint startPointOfView;
}

@property ( nonatomic, strong) UINavigationController *navigationController;
@property ( nonatomic, strong) PostCellContent *content;
- (UIView*) CreateImagesViewWithFrame:(CGRect)frame;
@end
