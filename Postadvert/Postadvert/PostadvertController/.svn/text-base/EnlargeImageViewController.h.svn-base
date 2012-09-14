//
//  EnlargeImageViewController.h
//  PostAdvert11
//
//  Created by Mtk Ray on 5/25/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PostCellContent;
@class MyUIImageView;
typedef enum{
    currentCenterImage_leftImage,
    currentCenterImage_centerImage,
    currentCenterImage_rightImage
} CurrentCenterImage;
@interface EnlargeImageViewController : UIViewController <UIScrollViewDelegate,  UIActionSheetDelegate, UIGestureRecognizerDelegate>
{
    NSInteger current;
    NSInteger numberOfTap;
    CurrentCenterImage currentCenter;
    IBOutlet UIView *logoView;
    IBOutlet UIView *thumbnailImageView;
    IBOutlet UIView *enlargeImageView;
    IBOutlet UIView *botBackview;
    IBOutlet UIToolbar *topToolbar;
    UILabel *title;
    MyUIImageView *centerImageView;
    MyUIImageView *leftImageView;
    MyUIImageView *rightImageView;
    IBOutlet UIScrollView *contentView;
    CGRect defaultFrame;
    BOOL isToolbarHide;
    UISwipeGestureRecognizer *swipeLeft;
    UISwipeGestureRecognizer *swipeRight;
    BOOL isZooming;
}

@property ( nonatomic, strong) UINavigationController *navigationController;
@property ( nonatomic, assign) PostCellContent *content;
@property ( nonatomic ) NSInteger index;

@end