//

#import "NewAccountVwCtrl.h"
#import "PostAdvertController.h"
#import "CredentialInfo.h"
#import <QuartzCore/QuartzCore.h>

#import "Constants.h"


@implementation NewAccountVwCtrl

@synthesize listItems;
@synthesize palUpCtrl;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initTableView];
    }
    return self;
}

-(id) initWithPostAdvertController:(PostAdvertController *) postAdvertController
{
    if (self) {
        self.palUpCtrl = postAdvertController;
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void) initTableView
{
    if (listItems) {
        [listItems removeAllObjects];
        listItems = nil;
    }
    
    //listItems = [[NSMutableArray alloc] initWithObjects:@"First Name", @"Last Name", @"Email address", @"Passwork", "Confirm ", nil];
    listItems = [[NSMutableArray alloc] init];
    [listItems addObject:@"First Name"];
    [listItems addObject:@"Last Name"];
    [listItems addObject:@"Username"];
    [listItems addObject:@"Email Address"];
    [listItems addObject:@"Password"];
    [listItems addObject:@"Confirm Password"];
    
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BG1_revert.png"]];
    self.view.backgroundColor = [UIColor clearColor];
    // Register Notification event for Keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWilBeShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWilBeShown:)
                                                 name:UITextFieldTextDidBeginEditingNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(didParseDatafromServer) name:cRegistrationCreateFunc object:nil];
    
    [self initTableView];
    //tableVw = [[UITableView alloc]init];
    tableVw.scrollEnabled = NO;
    tableVw.separatorColor = [UIColor clearColor];
    tableVw.separatorStyle = UITableViewCellSeparatorStyleNone;
    ((UIScrollView*)self.view).scrollEnabled = NO;
    [(UIScrollView*)self.view setContentSize:CGSizeMake(320.0, 480 + 216)];
    
}

- (void)viewDidUnload
{
    NSLog(@"NewAccountBaseVwContrl : viewDidUnload");
    [super viewDidUnload];
    self.navigationController.navigationBarHidden = NO;
    [listItems removeAllObjects];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    //return YES;
}



/////////////////////
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}



#pragma mark - Handle Keyboard

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWilBeShown:(NSNotification*)aNotification
{
    CGPoint pt = CGPointZero;
    
    ((UIScrollView*)self.view).scrollEnabled = YES;
    
    switch (activeField.tag) {
        case 1:{
            pt = CGPointMake(0.0, 70.0);
        } break;
            
        case 2:{
            pt = CGPointMake(0.0, 90.0);
        } break;
            
        case 3:{
            pt = CGPointMake(0.0, 120.0);
        } break;
            
        case 4:{
            pt = CGPointMake(0.0, 150.0);
        } break;
        case 5:{
            pt = CGPointMake(0.0, 180.0);
        }
            break;
        case 6:{
            pt = CGPointMake(0.0, 216.0);
        }
            break;
        case 7:{
            pt = CGPointMake(0.0, 180.0);
        }
            break;

        default:
            NSLog(@"Don't know control.");
            break;
    }
    
    [(UIScrollView*)self.view setContentOffset:pt animated:YES];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    ((UIScrollView*) self.view).contentInset = contentInsets;
//    ((UIScrollView*) self.view).scrollIndicatorInsets = contentInsets;

    [(UIScrollView*)self.view setContentOffset:CGPointZero animated:YES];
    ((UIScrollView*)self.view).scrollEnabled = NO;
}


///////////////////     Table View
#pragma mark - Table View
// Check if user available
- (void)checkForUserAvailable: (NSString*) userName
{
    //PalUpController   *palUpCtrl = (PalUpController *)cAppiPhoneDelegate.palUpController;
    
    if(![palUpCtrl isConnectToWeb]){
        [palUpCtrl showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
        
        return;
    }
    
    

//    NSLog(@"checkForUserAvailable, %@", userName);
    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        "<soap:Body>"
                            "<CheckUsername xmlns='http://50.19.216.234/palup/server1.php'>"
                                "<userName>%@</userName>"
                            "</CheckUsername>"
                        "</soap:Body>"
					  "</soap:Envelope>", userName];
	
	NSLog(@"%@", post);
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, cCheckUsername]]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
    
	NSError *error;
	NSURLResponse *response;
	NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
//    NSLog(@"=====================");
    NSString *encodeData=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];	
/*    NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;" withString:@""];
    [encodeData release];
    data1 = [data1 stringByReplacingOccurrencesOfString:@"&amp;lt;" withString:@"<"];
    //    data1 = [data1 stringByReplacingOccurrencesOfString:@"&amp;gt;" withString:@">"];
    data1 = [data1 stringByReplacingOccurrencesOfString:@"&amp;amp;" withString:@"&"];
    data1 = [data1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    data1 = [data1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];*/
    
//	NSLog(@"%@", encodeData);
//    NSLog(@"=====================");

    NSScanner *scanner = [NSScanner scannerWithString:encodeData];    
    NSString *strResult;
    [scanner scanUpToString:@"<return xsi:type=\"xsd:int\">" intoString:nil];
    [scanner scanString:@"<return xsi:type=\"xsd:int\">" intoString:nil];
    [scanner scanUpToString:@"</return>" intoString:&strResult];
    NSLog(@"strResult: %@", strResult);
    if ([strResult intValue]) {
        lblUsrNmAvalidChk.text = @"User name is not available";
        lblUsrNmAvalidChk.textColor = [UIColor redColor];
        imgUsrNmAvalidChk.image = [UIImage imageNamed:@"icon_invalid_1.png"];
    } else {
        lblUsrNmAvalidChk.text = @"User name is available";
        lblUsrNmAvalidChk.textColor = [UIColor greenColor];
        imgUsrNmAvalidChk.image = [UIImage imageNamed:@"icon_valid_1.png"];
    }

}

- (void)onEventEditingChanged: (id) sender
{
    UITextField *txtFld = (UITextField*) sender;
    NSLog(@"txtFld.text =%@", txtFld.text);
    if (![txtFld.text isEqualToString:@""]) {
        [NSThread detachNewThreadSelector:@selector(checkForUserAvailable:)
                                 toTarget:self withObject:txtFld.text];
    } else {
        imgUsrNmAvalidChk.image = nil;
        lblUsrNmAvalidChk.text = @"";
    }
}

// return number of row in section. Please see more help from Apple
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return 1;
}


- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView 
{
    NSLog(@"List: %d %@",listItems.count, listItems);
    return [listItems count];
} 

// Draw for cell table. Please see more help from Apple
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *newAccStr = @"NewAccountTblId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newAccStr];
    if(cell == nil) 
    {         
        //cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)
         //                              reuseIdentifier:newAccStr];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newAccStr];
        cell.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        unsigned int section = [indexPath section];
        CGSize s = tableView.frame.size;
        
        UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 10.0, s.width - 35.0, 23.0)];
        textField.delegate = self;
        [textField addTarget:self action:@selector(didEndOnExitTxt:) 
            forControlEvents:UIControlEventEditingDidEndOnExit];
        textField.font = [UIFont fontWithName:@"Helvetica" size:16.0];
        textField.textColor = [UIColor blackColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;        
        textField.tag = section + 1;
        [textField setPlaceholder:[listItems objectAtIndex:section]];
        
        switch (section) {
            case 0:{
                textField.returnKeyType = UIReturnKeyNext;
            }
                break;
            case 1:{
                textField.returnKeyType = UIReturnKeyNext;
            }
                break;
            case 2:{
                [textField addTarget:self
                              action:@selector(onEventEditingChanged:) 
                    forControlEvents:UIControlEventEditingChanged];

                textField.returnKeyType = UIReturnKeyNext;
            }break;
                
            case 3:{
                textField.keyboardType = UIKeyboardTypeEmailAddress;
                textField.returnKeyType = UIReturnKeyNext;
            }break;
                
            case 4:{
                textField.secureTextEntry = YES;
                textField.returnKeyType = UIReturnKeyNext;
            }break;
                
            case 5:{
                textField.secureTextEntry = YES;
                textField.returnKeyType = UIReturnKeyDone;
            }break;
        }
        
        [cell.contentView addSubview:textField];
        
        if (section == 2) {
            UIImageView *imageBG = [[UIImageView alloc ] initWithFrame:CGRectMake(9.0, 0.0, 302.0, 60.0)] ;
            imageBG.opaque = NO;
            //    imageBG.layer.cornerRadius = 10;
            //    imageBG.layer.masksToBounds = YES;
            imageBG.image = [UIImage imageNamed:@"cell_updown_enable.png"];
            [cell setBackgroundView:imageBG];

            imgUsrNmAvalidChk = [[UIImageView alloc ] initWithFrame:CGRectMake(15.0, 43.0, 12.0, 12.0)];
            imgUsrNmAvalidChk.opaque = NO;
            //imgUsrNmAvalidChk.image = [UIImage imageNamed:@"icon_valid_1.png"];
            [cell.contentView addSubview: imgUsrNmAvalidChk];
 
            lblUsrNmAvalidChk = [[UILabel alloc] initWithFrame:CGRectMake(30.0, 43.0, 200.0, 14.0)];
            lblUsrNmAvalidChk.text = @"";
            lblUsrNmAvalidChk.textColor = [UIColor greenColor];
            lblUsrNmAvalidChk.opaque = NO;
            lblUsrNmAvalidChk.backgroundColor = [UIColor clearColor];
            lblUsrNmAvalidChk.font = [UIFont fontWithName:@"Helvetica" size:12.0];
            [cell.contentView addSubview:lblUsrNmAvalidChk];

        } else {
            UIImageView *imageBG = [[UIImageView alloc ] initWithFrame:CGRectMake(9.0, 0.0, 302.0, 55.0)] ;
            imageBG.opaque = NO;
            //    imageBG.layer.cornerRadius = 10;
            //    imageBG.layer.masksToBounds = YES;
            imageBG.image = [UIImage imageNamed:@"cell_bg_1.png"];
            [cell setBackgroundView:imageBG];
        }
    }
    
    return cell; 
}

// Return heigh of cell
- (CGFloat) tableView : (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath 
{
    CGFloat h = cCellHeight;
    if ([indexPath section] == 2) {
        h = cCellHeight * 3.0 / 2.0;
    }
    return h;
}

- (float) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ((section == 2) || (section == 3)) {
        return 24.0;
    }
    return 12.0;
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view;
    if ((section == 2) || (section == 3)) {
        CGRect rcView = CGRectZero;
        rcView.size.height = 24.0;
        rcView.size.width = tableView.frame.size.width;
        
        CGRect rectLabel = CGRectMake(15.0, 2.0, rcView.size.width, rcView.size.height);
        UILabel *lable = [[UILabel alloc] initWithFrame:rectLabel];
        
        lable.textColor = [UIColor whiteColor];
        lable.opaque = NO;
        lable.backgroundColor = [UIColor clearColor];
        lable.font = [UIFont fontWithName:@"Helvetica" size:11.0];
        
        if (section == 2) {
            lable.text = @"Choose a Unique Username";
        } else {
            lable.text = @"Valid email to confirm";
        }
        
        view = [[UIView alloc] initWithFrame:rcView];
        [view addSubview:lable];
    } else {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        //return nil;
    }

    return view;
}


-(IBAction) touchBackBtn: (id) sender
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) hidePopUpDialog:(UIView*) view
{
    CGRect rc = view.frame;
    rc.origin = CGPointMake(0.0f, -rc.size.height);
    
    // Animate the message view away
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
	
	view.frame = rc;
    [UIView commitAnimations];
    
	// Hide the overlay
	[self.view performSelector:@selector(setAlpha:) withObject:nil afterDelay:0.3f];
    [[self modalViewController] dismissModalViewControllerAnimated:NO];
    //[view removeFromSuperview];
}


-(IBAction) touchCreateAccountBtn: (id) sender
{
    NSLog(@"User name: %@", [(UITextView*)[self.view viewWithTag:3] text]);
    NSLog(@"Mail address: %@", [(UITextView*)[self.view viewWithTag:4] text]);
    NSLog(@"Password: %@", [(UITextView*)[self.view viewWithTag:5] text]);

    CredentialInfo *credential1 = [ [CredentialInfo alloc] initWithEmail:[(UITextView*)[self.view viewWithTag:4] text]
                                                               userName:[(UITextView*)[self.view viewWithTag:3] text] 
                                                               password:[(UITextView*)[self.view viewWithTag:5] text] ];

    long logInID = [palUpCtrl registrationCreate:credential1];
    if (logInID) {
        NSUserDefaults* dababase = [NSUserDefaults standardUserDefaults];
        long temp = [dababase integerForKey:@"UserID"];
        if(!temp){
            [dababase setInteger:logInID forKey:@"UserID"];
            [dababase synchronize];
        }
        
        [palUpCtrl getFullProfile];
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"Log in ID = %ld", logInID);
    } else {
        UIAlertView *baseAlert = [[UIAlertView alloc]
                                  initWithTitle: @"Alert!"
                                  message: @"Failed to create account. Please try again."
                                  delegate:self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"OK", nil];
        [baseAlert show];
    }

}

-(IBAction) didEndOnExitTxt: (id) sender
{
    switch ([(UITextField*)sender tag]) {
        case 1:{
            [(UITextView*)[self.view viewWithTag:2] becomeFirstResponder];
        } break;

        case 2:{
            [(UITextView*)[self.view viewWithTag:3] becomeFirstResponder];
        } break;

        case 3:{
            [(UITextView*)[self.view viewWithTag:4] becomeFirstResponder];
        } break;

        case 4:{
            [(UITextView*)[self.view viewWithTag:5] becomeFirstResponder];
        }
            break;
        case 5:{
            [(UITextView*)[self.view viewWithTag:6] becomeFirstResponder];
        }
        case 6:{
            //[self touchCreateAccountBtn:( (UIButton*)[self.view viewWithTag:98] )];
            //[(UITextView*)[self.view viewWithTag:98] becomeFirstResponder];
            //[self touchCreateAccountBtn:nil];
        } break;
            
        case 7:{
            //[self touchCreateAccountBtn:nil];
        } break;
            
        case 98:{
            //[self touchCreateAccountBtn:( (UIButton*)[self.view viewWithTag:6] )];
            [self touchCreateAccountBtn:nil];
        } break;
            
        case 99:{
            [activeField resignFirstResponder];
        }
            break;
        default:
            NSLog(@"Don't kown control.");
            break;
    }

}

@end
