//
//  PostViewController.h
//  Postadvert
//
//  Created by Mtk Ray on 6/8/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PostCellContent;
@class UIPlaceHolderTextView;
@class UIPostCell;
@interface PostViewController : UIViewController<UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIImagePickerController *imagePicker;
    NSInteger totalImage;
}

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activity;
@property (nonatomic, weak)IBOutlet UIImageView *avatarImg;
@property (nonatomic, weak)IBOutlet UIPlaceHolderTextView *phTextView;
@property (nonatomic, weak)IBOutlet UIScrollView * scrollView;
@property (nonatomic, weak)IBOutlet UIBarButtonItem *btnPost;
@property (nonatomic, weak)IBOutlet UIButton *photoButton;
@property (nonatomic, weak)IBOutlet UIView *botView;
@property (nonatomic, weak)IBOutlet UIView *thumbnailView;
@property (nonatomic, strong) UIPopoverController *popoverCtr;
- (IBAction)makeKeyboardGoAway:(id)sender;
@end
