//
//  NewAccountVwCtrl.h
//  PalUp
//
//  Created by Elisoft on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostAdvertController;
@interface NewAccountVwCtrl : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    PostAdvertController             *palUpCtrl;
    
    UITextField                 *activeField;
    IBOutlet UITableView        *tableVw;
    UIImageView                 *imgUsrNmAvalidChk;
    UILabel                     *lblUsrNmAvalidChk;
    
    NSMutableArray              *listItems;
}

@property (nonatomic, strong) PostAdvertController                   *palUpCtrl;
@property (nonatomic, strong) NSMutableArray                    *listItems;


-(IBAction) touchBackBtn: (id) sender;
-(IBAction) touchCreateAccountBtn: (id) sender;
-(IBAction) didEndOnExitTxt: (id) sender;


-(id) initWithPostAdvertController:( PostAdvertController *)  postAdvertController;


//-(unsigned int) tagOffsetFromIndexPath:(NSIndexPath *)indexPath;
-(void) keyboardWilBeShown:(NSNotification*)aNotification;
-(void) keyboardWillBeHidden:(NSNotification*)aNotification;
-(void) initTableView;

@end
