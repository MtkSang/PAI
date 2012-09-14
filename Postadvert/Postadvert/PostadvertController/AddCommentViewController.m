//
//  AddCommentViewController.m
//  PostAdvert11
//
//  Created by Mtk Ray on 5/21/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import "AddCommentViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CommentsCellContent.h"
#import "UserPAInfo.h"
@interface AddCommentViewController ()

@end

@implementation AddCommentViewController
@synthesize comment;
@synthesize content;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    defaulfFrame = comment.frame;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    NSLog(@"AddCommentViewController: viewDidUnload");
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"enterAddComment" object:nil];
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [comment becomeFirstResponder];
    comment.frame = CGRectMake(comment.center.x, comment.center.y, 0.0, 0.0);
//    [UIView setAnimationDuration:0.8];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
//    [UIView beginAnimations:@"addComment" context:(__bridge void *)comment];
//    comment.frame = defaulfFrame;
    comment.layer.cornerRadius = 10.0;
    comment.layer.borderWidth = 1.0;
    comment.layer.borderColor = self.view.backgroundColor.CGColor;
//    [UIView commitAnimations];
    
    
}
- (void) viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewDidDisappear:animated];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"enterAddComment" object:nil];
    [comment resignFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

#pragma mark - toolbar

-(IBAction)backButtinClicked{
    
    
//    [UIView setAnimationDuration:0.8];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
//    [UIView beginAnimations:@"addComment" context:(__bridge void *)self.view];
//    self.view.alpha = 0.1;
//    [UIView commitAnimations];
    [self dismissModalViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"plusSuccessNoPost" object:nil];
    
}

-(IBAction)postButtinClicked{
    content.totalComment += 1;
    CommentsCellContent *newComments = [[CommentsCellContent alloc]init];
    newComments.text = comment.text;
    newComments.userAvatar = [UserPAInfo sharedUserPAInfo].imgAvatar;
    newComments.userPostName = [UserPAInfo sharedUserPAInfo].usernamePU;
    [content.listComments addObject:newComments];
    self.navigationController.navigationBarHidden = NO;
    [self dismissModalViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"plusSuccessWithPost" object:nil];
    
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        barButtonPost.enabled = NO;
    }else {
        barButtonPost.enabled = YES;
    }
}

#pragma mark -
- (void) keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo]
                            objectForKey:UIKeyboardFrameEndUserInfoKey]
                           CGRectValue].size;
    NSLog(@"Self.view %@ \n Supper %@ \n comment %@", self.view, comment.superview, comment);
    CGRect mainFrame = self.view.frame;
    CGRect commnetFrame = comment.frame;
    commnetFrame.origin.x = 4;
    commnetFrame.origin.y = 48;
    //commnetFrame.size.width = mainFrame.size.width - 8;
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIDeviceOrientationPortrait
        || orientation == UIDeviceOrientationPortraitUpsideDown ) {
        commnetFrame.size.height = mainFrame.size.height - keyboardSize.height - 50;
        commnetFrame.size.width = mainFrame.size.width - 8;
    }else{
        commnetFrame.size.height = mainFrame.size.width - keyboardSize.width - 50;
        commnetFrame.size.width = mainFrame.size.height - 8;
    }
    [UIView setAnimationDuration:0.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
    [UIView beginAnimations:@"addComment" context:(__bridge void *)comment];
    comment.frame = commnetFrame;
    [UIView commitAnimations];
}

- (void) keyboardDidShow:(NSNotification *)notification {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    CGSize keyboardSize = [[[notification userInfo]
                            objectForKey:UIKeyboardFrameEndUserInfoKey]
                           CGRectValue].size;
    NSLog(@"Self.view %@ \n Supper %@ \n comment %@", self.view, comment.superview, comment);
    CGRect mainFrame = self.view.frame;
    CGRect commnetFrame = comment.frame;
    commnetFrame.origin.x = 4;
    commnetFrame.origin.y = 48;
    //commnetFrame.size.width = mainFrame.size.width - 8;
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIDeviceOrientationPortrait
        || orientation == UIDeviceOrientationPortraitUpsideDown ) {
        commnetFrame.size.height = mainFrame.size.height - keyboardSize.height - 50;
        commnetFrame.size.width = mainFrame.size.width - 8;
    }else{
        commnetFrame.size.height = mainFrame.size.width - keyboardSize.width - 50;
        commnetFrame.size.width = mainFrame.size.height - 8;
    }
    [UIView setAnimationDuration:0.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
    [UIView beginAnimations:@"addComment" context:(__bridge void *)comment];
     comment.frame = commnetFrame;
    [UIView commitAnimations];

    
}
@end
