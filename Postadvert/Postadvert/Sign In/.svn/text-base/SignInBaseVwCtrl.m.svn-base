//
//  SignInBaseVwCtrl.m
//  PalUp
//
//  Created by Elisoft on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SignInBaseVwCtrl.h"




@implementation SignInBaseVwCtrl


@synthesize overlay, loginErrorVw;
@synthesize emailAddressTxt, passwordTxt;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    overlay.alpha = 0.0f;
    
    //tableVw.separatorColor = [UIColor clearColor];
    
    [self initDialog:loginErrorVw];
    [self initTextField:emailAddressTxt];
    [self initTextField:passwordTxt];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - List login form
-(void) initTextField:(UITextField*) textField
{
    [textField addTarget:self action:@selector(didEndOnExitTxt:) forControlEvents:UIControlEventEditingDidEndOnExit];
    textField.font = [UIFont fontWithName:@"Helvetica" size:16.0];
    textField.textColor = [UIColor blackColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //textField.enablesReturnKeyAutomatically = YES;
    
    if (textField.tag == 1) {
        textField.tag = 1;
        textField.keyboardType = UIKeyboardTypeEmailAddress;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [textField setPlaceholder:@"Username / Email"];
    } else if (textField.tag ==2) {
        textField.tag = 2;
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.returnKeyType = UIReturnKeyGo;
        textField.secureTextEntry = YES;
        [textField setPlaceholder:@"Password"];
    }
}


-(void) initDialog:(UIView*) view
{
	// Initialize the overlay and message view
	[overlay addSubview:view];
    
    CGRect rc = view.frame;
    
	rc.origin = CGPointMake(0.0f, -rc.size.height);
	view.frame = rc;
}

-(void) showDialog:(UIView*) view
{
/*    CGRect rc = [[UIScreen mainScreen] bounds];
    overlay.frame = rc;
    
	rc.origin = CGPointMake(0.0f, -rc.size.height);
	view.frame = rc;
    
	// Show the overlay
	if (!overlay.superview) 
        [self.view.window addSubview:overlay];
    
    //    UIViewController *modalViewController = [[UIViewController alloc] init];
    //    modalViewController.view = overlay;
    //    [self presentModalViewController:modalViewController animated:YES];
    
	overlay.alpha = 1.0f;
	
	// Animate the message view into place
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
	rc.origin = CGPointMake(0.0f, 90.0f);
	view.frame = rc;
    [UIView commitAnimations];
    
    //    [modalViewController release];*/
    
    [overlay addSubview:view];
    
    CGRect rc = [[UIScreen mainScreen] bounds];
    overlay.frame = rc;
    
    rc = view.frame;
	rc.origin = CGPointMake(0.0f, -rc.size.height);
	view.frame = rc;
    
	// Show the overlay
	if (!overlay.superview) 
        [self.view.window addSubview:overlay];
    
    //    UIViewController *modalViewController = [[UIViewController alloc] init];
    //    modalViewController.view = overlay;
    //    [self presentModalViewController:modalViewController animated:YES];
    
	overlay.alpha = 1.0;
	
	// Animate the message view into place
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
	rc.origin = CGPointMake(0.0f, 90.0f);//point; //CGPointMake(0.0f, 10.0f);
	view.frame = rc;
    [UIView commitAnimations];
    
    //    [modalViewController release];
}

-(void) hideDialog:(UIView*) view
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
	[overlay performSelector:@selector(setAlpha:) withObject:nil afterDelay:0.3f];
    [[self modalViewController] dismissModalViewControllerAnimated:NO];
}

///////////////////
/*
#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {return 2;}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *signInStr = @"SignInTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:signInStr]; 
    if(cell == nil) 
    { 
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:signInStr] autorelease];
        //cell.backgroundColor = [UIColor clearColor];
        int row = [indexPath row];
        if ( (row == 0) || (row == 1) ) {
            CGRect rc = cell.frame;
            UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(7.0, 7.0, rc.size.width - 50, rc.size.height - 23)];
            
            textField.delegate = self;            
            [textField addTarget:self action:@selector(didEndOnExitTxt:) forControlEvents:UIControlEventEditingDidEndOnExit];
            textField.font = [UIFont fontWithName:@"Helvetica" size:16.0];
            textField.textColor = [UIColor blackColor];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            //textField.enablesReturnKeyAutomatically = YES;
            
            if (row == 0) {
                textField.tag = 1;
                textField.keyboardType = UIKeyboardTypeEmailAddress;
                textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                [textField setPlaceholder:@"Email Address"];
            } else if (row ==1) {
                textField.tag = 2;
                textField.keyboardType = UIKeyboardTypeDefault;
                textField.returnKeyType = UIReturnKeyGo;
                textField.secureTextEntry = YES;
                [textField setPlaceholder:@"Password"];
            }

            [cell.contentView addSubview:textField];
            [textField release];
        }       

    } 

    return cell; 
}
*/

//////////////////////////
-(IBAction) touchBackBtn: (id) sender
{
    //self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction) didEndOnExitTxt: (id) sender
{
    switch ([(UITextField*)sender tag]) {
        case 1:{
            NSLog(@"User name");
        }break;
            
        case 2:{
            NSLog(@"Password");
        }break;
            
        default:
            break;
    }
}

@end
