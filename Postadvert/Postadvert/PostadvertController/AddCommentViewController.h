//
//  AddCommentViewController.h
//  PostAdvert11
//
//  Created by Mtk Ray on 5/21/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostCellContent.h"

@interface AddCommentViewController : UIViewController <UITextViewDelegate>
{
    IBOutlet UIToolbar *toolbar;
    IBOutlet UIBarButtonItem *barButtonPost;
    CGRect defaulfFrame;
    
}
@property ( nonatomic, assign) PostCellContent *content;
@property ( nonatomic, strong) IBOutlet UITextView *comment;
-(IBAction)backButtinClicked;
-(IBAction)postButtinClicked;
@end
