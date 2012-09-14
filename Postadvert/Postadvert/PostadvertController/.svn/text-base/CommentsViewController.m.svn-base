//
//  CommentsViewController.m
//  Postadvert
//
//  Created by Mtk Ray on 6/5/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "CommentsViewController.h"
#import "PostCellContent.h"
#import "CommentsCellContent.h"
#import "UICommentsCell.h"
#import "Constants.h"
#import "UIPlaceHolderTextView.h"
#import <QuartzCore/QuartzCore.h>
#import "UserPAInfo.h"
@interface CommentsViewController ()
- (void) loadCells;
- (void) updateLeftBarBtnStateSideBar;
- (void) updateLeftBarBtnStateNormal;
- (void) tapAction;
@end

@implementation CommentsViewController

@synthesize content = _content;
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
    leftBarBtnItem = self.navigationItem.leftBarButtonItem;
    //_tableView.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:115.0/255.0 blue:115.0/255.0 alpha:1];
//    CGRect frame = _tableView.frame;
//    frame.size.height = 480 - 20 - 44 - 44;
//    _tableView.frame = frame;
    
    comment.layer.cornerRadius = 5.0;
    comment.layer.borderWidth = 0.25;
    comment.placeholder = @"Write a text";
    btnSend.layer.cornerRadius = 5.0;
    btnSend.layer.borderWidth = 0.20;
    btnSend.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    
    //TapGesture
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [_tableView addGestureRecognizer:tap];
    tap = nil;
    [self loadCells];
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
    
    preRightNaviBar = self.navigationItem.rightBarButtonItem;
    rightNaviBar = [[UIBarButtonItem alloc] initWithTitle: _content.isClap ? @"Unclap" : @"  Clap  " style:UIBarButtonItemStylePlain target:self action:@selector(clapBtnClick:)];
    self.navigationItem.rightBarButtonItem = rightNaviBar;
    
    
}
- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:0] forKey:@"inOutComments"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"inOutComments" object:nil userInfo:dict];
    dict = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"plusSuccessWithPost" object:nil];
    self.navigationItem.rightBarButtonItem = preRightNaviBar;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"%@ rotated", self);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }
    return _content.listComments.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        UICommentsCell * cell = [[UICommentsCell alloc]init];
        CommentsCellContent *commnet = [[CommentsCellContent alloc] init];
        commnet.userPostName = _content.userPostName;
        commnet.text = _content.text;
        commnet.userAvatar = _content.userAvatar;
        [cell updateCellWithContent:commnet];
        commnet = nil;
        return cell.height;
    }
    return [(UICommentsCell*)[listCells objectAtIndex:indexPath.row] height];
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    cell.detailTextLabel.frame = CGRectMake(cMaxLeftView - 100, 0.0, 70, cCellHeight);
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (listCells.count == 0) {
        CGRect frame = tableView.frame;
        frame.size.height += cCellHeight;//make "No data" below Loading
        UILabel *labelCell = [[UILabel alloc]initWithFrame:frame];
        labelCell.text = @"No Data";
        [labelCell setFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE * 2.5]];
        [labelCell setTextAlignment:UITextAlignmentCenter];
        labelCell.backgroundColor = [UIColor clearColor];
        labelCell.textColor = [UIColor darkGrayColor];
        labelCell.alpha = 0.6;
        UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:tableView.frame];
        [cell.contentView addSubview:labelCell];
        tableView.scrollEnabled = NO;
        labelCell = nil;
        return  cell;
    }
    if (indexPath.section == 0) {
        UICommentsCell * cell = [[UICommentsCell alloc]init];
        CommentsCellContent *commnet = [[CommentsCellContent alloc] init];
        commnet.userPostName = _content.userPostName;
        commnet.text = _content.text;
        commnet.userAvatar = _content.userAvatar;
        [cell updateCellWithContent:commnet];
        commnet = nil;
        return cell;
    }
    static NSString *CellIdentifier = @"UICommentsCell";
    
    UICommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UICommentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell = [listCells objectAtIndex:indexPath.row];
    NSLog(@"Cell%@", [listCells objectAtIndex:indexPath.row]);
    //[cell.contentView addSubview: [ cell drawContent]];
    NSLog(@"%@", cell.description);
    tableView.scrollEnabled = YES;
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        if (_content.totalClap) {
            return CELL_COMMENTS_HEADER_HEIGHT;
        }
    }
    return 10.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 10.0;
    }
    return 1.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = nil;
    if (section == 0) {
        return nil;
    }
    if (section == 1) {
        // Create view for header
        
        if (_content.totalClap > 0) {
            header = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, CELL_COMMENTS_WIDTH, CELL_COMMENTS_HEADER_HEIGHT)];
            header.backgroundColor = [UIColor clearColor];
            //icon clap
            UIImageView *clapIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clap.png"]];
            clapIcon.frame = CGRectMake( 20.0, 7, 25, 15);
            
            // people clap
            UILabel *lbPeopleClap = [[UILabel alloc]initWithFrame:CGRectMake(clapIcon.frame.origin.x + clapIcon.frame.size.width + CELL_MARGIN_BETWEEN_IMAGE, clapIcon.frame.origin.y, CELL_COMMENTS_WIDTH - (clapIcon.frame.origin.x + clapIcon.frame.size.width + CELL_MARGIN_BETWEEN_IMAGE), clapIcon.frame.size.height )];
            lbPeopleClap.backgroundColor = [UIColor clearColor];
            [lbPeopleClap setFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE]];
            
            if (_content.isClap) {
                // did clap
                switch (_content.totalClap) {
                    case 1:
                        lbPeopleClap.text = @"You like this";
                        break;
                    case 2:
                        lbPeopleClap.text = @"You and another like this";
                        break;
                    default:
                        lbPeopleClap.text = [NSString stringWithFormat:@"You and %d others like this.", _content.totalClap - 1];
                        break;
                }
                
            }else {
                switch (_content.totalClap) {
                    case 1:
                        lbPeopleClap.text = @"A persion likes this";
                        break;
                    default:
                        lbPeopleClap.text = [NSString stringWithFormat:@"%d people like this.", _content.totalClap];
                        break;
                }
                
            }
            
            [header addSubview:clapIcon];
            [header addSubview:lbPeopleClap];
            clapIcon = nil;
            lbPeopleClap = nil;
        }
        
        
    }
    return header;
}
#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        btnSend.enabled = NO;
        btnSend.titleLabel.textColor = [UIColor lightGrayColor];
    }else {
        btnSend.enabled = YES;
        btnSend.titleLabel.textColor = [UIColor blueColor];
//        CGSize constraint = CGSizeMake(textView.frame.size.width, 64.0 );
//        CGSize size = [textView.text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
//        if (size.height > 32.0) {
//            CGRect frame = textView.frame;
//            frame.size.height = size.height;
//            frame.origin.y -= (size.height - textView.frame.size.height);
//            textView.frame = frame;
//        }
    }
}
#pragma mark - Handle Keyboard

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWilBeShown:(NSNotification*)aNotification
{
    CGPoint pt = CGPointZero;
    
    ((UIScrollView*)self.view).scrollEnabled = YES;
    pt = CGPointMake(0.0, 216);
    [(UIScrollView*)self.view setContentOffset:pt animated:YES];
    _tableView.frame = CGRectMake(0.0, 216, self.view.frame.size.width, _tableView.frame.size.height - 216);
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:listCells.count -1 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
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



- (void) loadCells
{
    if (listCells == nil) {
        listCells = [[NSMutableArray alloc] init ];
        for (CommentsCellContent *commentContent in _content.listComments) {
            UICommentsCell *cell = [[UICommentsCell alloc]init];
            [cell updateCellWithContent:commentContent];
            [listCells addObject:cell];
            cell = nil;
        }
        [_tableView reloadData];
    }
}
- (void) addCell:(CommentsCellContent *) commentContent
{
    if (listCells == nil) {
        listCells = [[NSMutableArray alloc] init ];
    }
    _content.totalComment += 1;
    [_content.listComments addObject:commentContent];
    UICommentsCell *cell = [[UICommentsCell alloc]init];
    [cell updateCellWithContent:commentContent];
    [listCells addObject:cell];
    cell = nil;
    [_tableView reloadData];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:listCells.count - 1 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
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
    leftBarBtnItem = nil;
}

- (void) tapAction
{
    NSLog(@"Tap");
    [comment resignFirstResponder];
}

- (IBAction) buttonSendClicked:(id)sender
{
    
    CommentsCellContent *newComments = [[CommentsCellContent alloc]init];
    newComments.text = comment.text;
    newComments.userAvatar = [UserPAInfo sharedUserPAInfo].imgAvatar;
    newComments.userPostName = [UserPAInfo sharedUserPAInfo].usernamePU;
    [self addCell:newComments];
    newComments = nil;
    [comment resignFirstResponder];
    comment.text = @"";
}

- (IBAction)clapBtnClick:(id)sender
{
    if (_content.isClap) {
        //Unclap action
        _content.isClap = NO;
        _content.totalClap -= 1;
        rightNaviBar.title = @"  Clap  ";
    }
    else {
        //Clap
        _content.isClap = YES;
        _content.totalClap += 1;
         rightNaviBar.title = @"Unclap";
    }
    [_tableView reloadData];
}

@end
