//
//  TakePhotoViewController.h
//  Postadvert
//
//  Created by Mtk Ray on 6/21/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@protocol TakePhotoViewControllerDelegate;
@interface TakePhotoViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, MBProgressHUDDelegate>
{
    id <TakePhotoViewControllerDelegate> delegate;
    UIImagePickerControllerSourceType sourceType;
    IBOutlet UIImageView *imageView;
    IBOutlet UIBarButtonItem *cancelBtn;
    IBOutlet UIBarButtonItem *doneBtn;
    IBOutlet UIToolbar *toolbar;
    //IBOutlet UIBarButtonItem *reMoveBtn;
    BOOL imageFromTake;
    MBProgressHUD *HUD;
}
@property (nonatomic, weak) id <TakePhotoViewControllerDelegate> delegate;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet IBOutlet UIBarButtonItem *cancelBtn;
@property (nonatomic, weak) IBOutlet IBOutlet UIBarButtonItem *doneBtn;
@property (nonatomic, weak) IBOutlet UIToolbar *toolbar;
//@property (nonatomic, weak) IBOutlet IBOutlet UIBarButtonItem *reMoveBtn;
@property (nonatomic) UIImagePickerControllerSourceType sourceType;
@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic )  BOOL showPicker;

- (void) setImageForView:(UIImage*) picture;
@end

@protocol TakePhotoViewControllerDelegate

- (void)didTakePicture:(UIImage *)picture;
- (void)didCancelPicture;
- (void)didReMovePicture;

@end