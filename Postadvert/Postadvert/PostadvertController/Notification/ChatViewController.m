//
//  ChatViewController.m
//  Postadvert
//
//  Created by Mtk Ray on 6/20/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "ChatViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIMessageCell.h"
#import "MessageCellContent.h"
#import "UserPAInfo.h"
#import "UIPlaceHolderTextView.h"
#import "Constants.h"
#import "WEPopoverController.h"
#import "TakePhotoViewController.h"
@interface ChatViewController ()
- (void) updateLeftBarBtnStateSideBar;
- (void) updateLeftBarBtnStateNormal;
- (void) tapAction;
- (void) updatePostBtnState;
@end

@implementation ChatViewController
@synthesize infoChatting = _infoChatting;

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
    message.layer.cornerRadius = 5.0;
    message.layer.borderWidth = 0.25;
    message.placeholder = @"Write a reply";
    btnSend.layer.cornerRadius = 5.0;
    btnSend.layer.borderWidth = 0.20;
    btnSend.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    
    //TapGesture
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [_tableView addGestureRecognizer:tap];
    tap = nil;
    [self loadListMessageCellContent];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:1] forKey:@"inOutComments"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"inOutComments" object:nil userInfo:dict];
    dict = nil;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLeftBarBtnStateNormal) name:@"updateLeftBarBtnStateNormal" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLeftBarBtnStateSideBar) name:@"updateLeftBarBtnStateSideBar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWilBeShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    //Set rightBar
    preRightNaviBar = self.navigationItem.rightBarButtonItem;
    //rightNaviBar = [[UIBarButtonItem alloc] initWithTitle: _content.isClap ? @"Unclap" : @"  Clap  " style:UIBarButtonItemStylePlain target:self action:@selector(clapBtnClick:)];
    //self.navigationItem.rightBarButtonItem = rightNaviBar;
    
    
}
- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:0] forKey:@"inOutComments"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"inOutComments" object:nil userInfo:dict];
    dict = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.navigationItem.rightBarButtonItem = preRightNaviBar;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"Rotated %@", self);
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return listMessageCellContent.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MessageCellContent *cellContent = [listMessageCellContent objectAtIndex:[indexPath row]];
    
    CGSize constraint = CGSizeMake(244, 20000.0f);
    
    CGSize size = [cellContent.text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    CGFloat lableHieght = 21.0;
    
    CGFloat height = 47.0 + MAX(size.height - lableHieght , 0.0);
    
    if (cellContent.imageAttachment) {
        height += 102;// add 2 margin between imge&text
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UIMessageCell";
    UIMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UIMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.message.numberOfLines = 0;
    cell.message.text = ((MessageCellContent*)[listMessageCellContent objectAtIndex:indexPath.row]).text;
    
    {
        CGSize constraint = CGSizeMake(244, 20000.0f);
        
        CGSize size = [cell.message.text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        CGFloat lableHieght = 21.0;
        
        CGFloat height = MAX(size.height - lableHieght , 0.0) + lableHieght;
        CGRect frame = cell.message.frame;
        frame.size.height = height;
        cell.message.frame = frame;
    }
    
    cell.imageView.image = ((MessageCellContent*)[listMessageCellContent objectAtIndex:indexPath.row]).userAvatar;
    cell.imageViewAttachment.image = ((MessageCellContent*)[listMessageCellContent objectAtIndex:indexPath.row]).imageAttachment;
    cell.userPostName.text = ((MessageCellContent*)[listMessageCellContent objectAtIndex:indexPath.row]).userPostName;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM:dd:yy"];
    NSString *theDate = [dateFormat stringFromDate:((MessageCellContent*)[listMessageCellContent objectAtIndex:indexPath.row]).datePost];
    cell.postTime.text = theDate;
    theDate = nil;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    btnSend.titleLabel.textColor = [UIColor redColor];
    [self updatePostBtnState];
}
#pragma mark - Handle Keyboard

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWilBeShown:(NSNotification*)aNotification
{
    CGPoint pt = CGPointZero;
    
    ((UIScrollView*)self.view).scrollEnabled = YES;
    pt = CGPointMake(0.0, 216);
    
    _tableView.frame = CGRectMake(0.0, 216, self.view.frame.size.width, _tableView.frame.size.height - 216);
    [(UIScrollView*)self.view setContentOffset:pt animated:YES];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:listMessageCellContent.count -1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    //    ((UIScrollView*) self.view).contentInset = contentInsets;
    //    ((UIScrollView*) self.view).scrollIndicatorInsets = contentInsets;
    
    [(UIScrollView*)self.view setContentOffset:CGPointZero animated:YES];
    ((UIScrollView*)self.view).scrollEnabled = NO;
    _tableView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, _tableView.frame.size.height + 216);
}

#pragma mark - implement
- (void) updatePostBtnState
{
    //Update icon btn TakePhoto
    
    if (imageAttachment) {
        [btnPickPicture setImage:imageAttachment forState:UIControlStateNormal];
    }else {
        [btnPickPicture setImage:[UIImage imageNamed:@"take-photo.png"] forState:UIControlStateNormal];
    }
    
    BOOL canEnable = NO;
    if (imageAttachment) {
        canEnable = YES;
    }
    NSString *text = [message.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if ([message.text isEqualToString:@""] || [text isEqualToString:@""]) {
        //canEnable = NO;
    }else {
        canEnable = YES;
    }
    text = nil;

    //Update post btn
    if (canEnable) {
        btnSend.enabled = YES;
        btnSend.titleLabel.textColor = [UIColor blueColor];
    }else {
        btnSend.titleLabel.textColor = [UIColor lightGrayColor];
        btnSend.enabled = NO;
    }
}

- (void) addCell:(MessageCellContent *) newCell
{
    if (listMessageCellContent == nil) {
        listMessageCellContent = [[NSMutableArray alloc] init ];
    }
    [listMessageCellContent addObject:newCell];
    [_tableView reloadData];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:listMessageCellContent.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

- (void) updateLeftBarBtnStateNormal
{
    self.navigationItem.leftBarButtonItem = leftBarBtnItem;
}

- (void) updateLeftBarBtnStateSideBar
{
    UIButton *abutton = [[UIButton alloc]initWithFrame:CGRectMake(5.0, 0.0, 30, 30)];
    [abutton setImage:[UIImage imageNamed:@"list_btn.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:abutton];
    leftBarItem.width = 30;
    self.navigationItem.leftBarButtonItem = leftBarItem;
    abutton = nil;
    //leftBarBtnItem = nil;
}

- (void) tapAction
{
    NSLog(@"Tap");
    [message resignFirstResponder];
}

- (IBAction) buttonSendClicked:(id)sender
{
    
    MessageCellContent *newComments = [[MessageCellContent alloc]init];
    newComments.text = message.text;
    newComments.userAvatar = [UserPAInfo sharedUserPAInfo].imgAvatar;
    newComments.userPostName = [UserPAInfo sharedUserPAInfo].usernamePU;
    newComments.datePost = [NSDate date]; 
    newComments.imageAttachment = imageAttachment;
    
    [self addCell:newComments];
    newComments = nil;
    [message resignFirstResponder];
    message.text = @"";
    imageAttachment = nil;
    [self updatePostBtnState];
}

- (void) loadListMessageCellContent
{
    if(listMessageCellContent == nil)
        listMessageCellContent = [[NSMutableArray alloc] init];
    [listMessageCellContent removeAllObjects];
    
    MessageCellContent *message1 = [[MessageCellContent alloc]init];
    message1.text = @"Good morning!";
    message1.userPostName = [UserPAInfo sharedUserPAInfo].usernamePU;
    message1.userAvatar = [UserPAInfo sharedUserPAInfo].imgAvatar;
    message1.datePost = [NSDate date];
    
    [listMessageCellContent addObject:message1];
    
    MessageCellContent *message2 = [[MessageCellContent alloc]init];
    message2.text = @"Good moring!";
    message2.userAvatar = [UIImage imageNamed:@"user01.png"];
    message2.userPostName = _infoChatting.userPostName;
    message2.datePost = [NSDate date];
    
    [listMessageCellContent addObject:message2];
    
    for (int i =1; i < 10; i++) {
        MessageCellContent *message3 = [[MessageCellContent alloc]init];
        message3.userPostName = [UserPAInfo sharedUserPAInfo].usernamePU;
        message3.userAvatar = [UserPAInfo sharedUserPAInfo].imgAvatar;
        message3.text = [NSString stringWithFormat:@"This is an automatic text %d 1",i];
        message3.datePost = [NSDate date];
        [listMessageCellContent addObject:message3];
        MessageCellContent *message4 = [[MessageCellContent alloc]init];
        message4.userPostName = self.infoChatting.userPostName;
        message4.userAvatar =  [UIImage imageNamed:@"user01.png"];
        message4.text = [NSString stringWithFormat:@"This is an automatic text %d 2",i];
        message4.datePost = [NSDate date];
        [listMessageCellContent addObject:message4];
    }
    
    [_tableView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{ //cancel
	
	[picker dismissModalViewControllerAnimated:YES];
	
}

-(IBAction)onTakePhoto:(id)sender{
    if (popoverController) {
		[popoverController dismissPopoverAnimated:YES];
		popoverController = nil;
	} else {
        [message resignFirstResponder];
        TakePhotoViewController *contentViewController = [[TakePhotoViewController alloc] init];
		CGRect rect = CGRectMake(0.0 , 400,((UIView*)sender).frame.size.width + 6, 70);
		//self.navigationController.navigationBarHidden = YES;
        contentViewController.navigationController = self.navigationController;
        if (imageAttachment) {
            [contentViewController performSelectorOnMainThread:@selector(setImageForView:) withObject :imageAttachment waitUntilDone:NO];
            contentViewController.showPicker = NO;
            //contentViewController.imageView =[[UIImageView alloc]initWithImage:imageAttachment];
        }
        
        contentViewController.delegate = self;
        contentViewController.contentSizeForViewInPopover = CGSizeMake(280, 300);
		popoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
		
		if ([popoverController respondsToSelector:@selector(setContainerViewProperties:)]) {
			[popoverController setContainerViewProperties:[self improvedContainerViewProperties]];
		}
		
		popoverController.delegate = self;
		popoverController.passthroughViews = [NSArray arrayWithObject:sender];
		
		[popoverController presentPopoverFromRect:rect  
												inView:self.navigationController.view 
							  permittedArrowDirections:(UIPopoverArrowDirectionLeft)
											  animated:YES];
    }
}

#pragma mark WEPopoverControllerDelegate implementation

- (void)popoverControllerDidDismissPopover:(WEPopoverController *)thePopoverController {
	//Safe to release the popover here
    popoverController = nil;
}

- (BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)thePopoverController {
	//The popover is automatically dismissed if you click outside it, unless you return NO here
	return YES;
}

- (WEPopoverContainerViewProperties *)improvedContainerViewProperties {
	
    WEPopoverContainerViewProperties *ret = [[WEPopoverContainerViewProperties alloc] init];
	
	CGSize imageSize = CGSizeMake(30.0f, 30.0f);
	NSString *bgImageName = @"popoverBgSimple.png";
	CGFloat bgMargin = 6.0;
	CGFloat contentMargin = 4.0;
	
	ret.leftBgMargin = bgMargin;
	ret.rightBgMargin = bgMargin;
	ret.topBgMargin = bgMargin;
	ret.bottomBgMargin = bgMargin;
	ret.leftBgCapSize = imageSize.width/2;
	ret.topBgCapSize = imageSize.height/2;
	ret.bgImageName = bgImageName;
	ret.leftContentMargin = contentMargin;
	ret.rightContentMargin = contentMargin;
	ret.topContentMargin = contentMargin;
	ret.bottomContentMargin = contentMargin;
	ret.arrowMargin = 1.0;
	
	ret.upArrowImageName = @"popoverArrowUpSimple.png";
	ret.downArrowImageName = @"popoverArrowDownSimple.png";
	ret.leftArrowImageName = @"popoverArrowLeftSimple.png";
	ret.rightArrowImageName = @"popoverArrowRightSimple.png";
	return ret;	
}

#pragma mark - TakePhotoDelegate
- (void) didTakePicture:(UIImage *)picture
{
    if (popoverController) {
        [popoverController dismissPopoverAnimated:YES];
        popoverController = nil;
    }
    imageAttachment = nil;
    imageAttachment = picture;
    picture = nil;
    [self updatePostBtnState];
}
- (void) didCancelPicture
{
    if (popoverController) {
        [popoverController dismissPopoverAnimated:YES];
        popoverController = nil;
    }
    [self updatePostBtnState];
}
- (void)didReMovePicture
{
    if (popoverController) {
        [popoverController dismissPopoverAnimated:YES];
        popoverController = nil;
    }
    imageAttachment = nil;
    [self updatePostBtnState];
}
@end
