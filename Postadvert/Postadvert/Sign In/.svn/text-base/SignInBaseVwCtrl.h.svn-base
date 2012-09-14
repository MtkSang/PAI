//
//  SignInBaseVwCtrl.h
//  PalUp
//
//  Created by Elisoft on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SignInBaseVwCtrl : UIViewController </*UITableViewDataSource, UITableViewDelegate, */UITextFieldDelegate>
{

    IBOutlet UIView             *overlay;
    IBOutlet UIView             *loginErrorVw;

    @protected
    //IBOutlet UITableView        *tableVw;
    IBOutlet UITextField        *emailAddressTxt;
    IBOutlet UITextField        *passwordTxt;
    
}

@property (nonatomic, retain) UIView             *overlay;
@property (nonatomic, retain) UIView             *loginErrorVw;

//@property (nonatomic, retain) UITableView        *tableVw;
@property (nonatomic, retain) UITextField        *emailAddressTxt;
@property (nonatomic, retain) UITextField        *passwordTxt;


-(IBAction) touchBackBtn: (id) sender;
-(IBAction) didEndOnExitTxt: (id) sender;

-(void) initDialog:(UIView*) view;
-(void) showDialog:(UIView*) view;
-(void) hideDialog:(UIView*) view;
-(void) initTextField:(UITextField*) textField;

@end
