//
//  CommentsViewController.h
//  Postadvert
//
//  Created by Mtk Ray on 6/5/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PostCellContent;
@class UIPlaceHolderTextView;

@interface CommentsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
{
    IBOutlet UITableView *_tableView;
    IBOutlet UIView *botView;
    IBOutlet UIPlaceHolderTextView *comment;
    IBOutlet UIButton *btnSend;
    UIBarButtonItem *rightNaviBar;
    NSMutableArray *listCells;
    UIBarButtonItem *leftBarBtnItem;
    UIBarButtonItem *preRightNaviBar;
}

@property (nonatomic, weak) PostCellContent *content;
- (IBAction) buttonSendClicked:(id)sender;
@end
