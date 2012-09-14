//
//  MainViewController.h
//  Sidebar
//
//  Created by Phan Quang Ha on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import "LeftViewController.h"
//#import "RightViewController.h"
#import "MBProgressHUD.h"
#import "PostViewController.h"
#import "WEPopoverController.h"
#import "GlobalNotificationsViewController.h"
#import "GlobalAlertViewController.h"
#import "MessageViewController.h"
#import "FriendsViewController.h"

@class DetailViewController;
@class ChatViewController;
@protocol DetailViewControllerDelegate <NSObject>
- (void) pushViewControllerWithView:(UIView*) view;
@end

@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate, WEPopoverControllerDelegate,GlobalNotificationsViewControllerDelegate, GlobalAlertViewControllerDelegate, MessageViewControllerDelegate, FriendsViewControllerDelegate >
{
#if EXPERIEMENTAL_ORIENTATION_SUPPORT
    CGPoint _containerOrigin;
#endif
    IBOutlet UIView * overlay;
    UIView *topMenu;
    UIView *topView;
    UIButton *btnPost;
    LeftViewController *leftViewController;
    MessageViewController *messageCtr;
    UIViewController    *customViewCtr;
    //RightViewController *rightViewController;
    IBOutlet UIButton *button;
    NSMutableArray *listCells;
    NSMutableArray *listContent;
    BOOL isEnterAddComment;
    MBProgressHUD *HUD;
    WEPopoverController *popoverController;
    UIView *viewUseToGetRectPopover;
    //Message
    BOOL isMessage;//Chatting
    
}

@property (strong, nonatomic) LeftViewController *leftViewController;
//@property (strong, nonatomic) RightViewController *rightViewController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UILabel *lbTitle;



@property (nonatomic, strong) UIView             *overlay;
- (void)showPopUpDialog:(UIView*) view :(CGPoint) point;
- (void) hidePopUpDialog:(UIView*) view;
- (UIView*) createLoginListView;
- (UIView*) drawPostAdvertTopMenu;
//- (UIView*) drawPostAdvertMainMenu;
- (IBAction)buttonClinked:(id)sender;
- (void) loadCells;

- (IBAction)showHideSidebar:(id)sender;
@end
