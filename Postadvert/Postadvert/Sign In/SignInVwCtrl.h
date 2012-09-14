//
//  SignInVwCtrl.h
//  PalUp
//
//  Created by Elisoft on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignInBaseVwCtrl.h"


@class PostAdvertController;

@interface SignInVwCtrl : SignInBaseVwCtrl <UITextFieldDelegate>
{
    PostAdvertController             *palUpCtrl;
    IBOutlet UIView             *resetPasswordVw;
    IBOutlet UIButton           *loginBtn;
    IBOutlet UIButton           *signupBtn;
//    IBOutlet UIView             *loginErrorVw;
}

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView      *activityIndicator;
@property (nonatomic, retain) PostAdvertController                       *palUpCtrl;
@property (nonatomic, retain) UIView                                *resetPasswordVw;
//@property (nonatomic, retain) UIView                                *loginErrorVw;
@property (nonatomic, retain) IBOutlet UITextField                  *txtFldRegisteredEmail;


-(id) initWithPostAdvertController:(PostAdvertController *) postAdvertController;
//-(void) didParseDatafromServer;

-(IBAction) didEndOnExitTxt:(id) sender;
-(IBAction) touchSignInBtn: (id) sender;
-(IBAction) touchForgetPasswordBtn: (id) sender;
-(IBAction) touchResetPasswordBtn: (id) sender;
-(IBAction) touchCancelResetPasswordBtn: (id) sender;
-(IBAction) touchTrySignInBtn: (id) sender;
-(IBAction) makeKeyboardGoAway:(id) sender;
-(IBAction) touchSignUpForPostAdvert:(id)sender;
- (void)registrationResetPassword:(NSString*) registeredEmail;

@end
