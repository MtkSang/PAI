//
//  ChatViewController.h
//  Postadvert
//
//  Created by Mtk Ray on 6/20/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEPopoverController.h"
#import "TakePhotoViewController.h"
@class MessageCellContent;
@class UIPlaceHolderTextView;
@interface ChatViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, WEPopoverControllerDelegate, TakePhotoViewControllerDelegate>
{
    IBOutlet UITableView *_tableView;
    IBOutlet UIView *botView;
    IBOutlet UIPlaceHolderTextView *message;
    IBOutlet UIButton *btnSend;
    IBOutlet UIButton *btnPickPicture;
    UIBarButtonItem *rightNaviBar;
    UIBarButtonItem *leftBarBtnItem;
    UIBarButtonItem *preRightNaviBar;
    NSMutableArray *listMessageCellContent;
    WEPopoverController *popoverController;
    MessageCellContent *infoChatting;
    UIImage *imageAttachment;
}
@property (nonatomic, strong) MessageCellContent *infoChatting;

- (IBAction) buttonSendClicked:(id)sender;
- (void) loadListMessageCellContent;
@end
