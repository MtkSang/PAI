//
//  UITablePostViewController.m
//  Postadvert
//
//  Created by Mtk Ray on 7/27/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "UITablePostViewController.h"
#import "UIPostCell.h"
#import "PostCellContent.h"
#import "Constants.h"
#import "PostadvertControllerV2.h"
#import "LinkPreview.h"
#import "LinkViewController.h"
#import "ImageViewController.h"
#import "ThumbnailPostCellView.h"
#import "SDWebImageRootViewController.h"

#define records_one_load 3
@interface UITablePostViewController ()
- (void) reloadTableView;
- (void) loadCellsInBackground;
- (void) addBottomCells;
- (void) addTopCells;
- (void) loadCellAtIndex:(NSNumber*)num;
//- (void) updateCell:(UIPostCell *)cell withContent:(PostCellContent*) content;
@end

@implementation UITablePostViewController

@synthesize myTableView = _myTableView;
@synthesize navigationController = _navigationCtr;
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibNameOrNil owner:self options:nil];
//    self = (UITablePostViewController *)[nib objectAtIndex:0];
//    if (self) {
//        // Custom initialization
//    }else
//    {
//        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    }
//    return self;
//}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableViewCellWithInfo:) name:@"UIPostCell_More_Click" object:nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:235.0/255.0 blue:245.0/255.0 alpha:1];
    //setup footview
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 44)];
    [footerView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth];
    footerView.autoresizesSubviews = YES;
    self.view.frame =[[UIScreen mainScreen] bounds];
    self.tableView.frame = [[UIScreen mainScreen] bounds];
    [self.tableView setTableFooterView: footerView];
    footerLoading = [[MBProgressHUD alloc]initWithView:self.tableView.tableFooterView];
    footerLoading.hasBackground = NO;
    footerLoading.mode = MBProgressHUDModeIndeterminate;
    footerLoading.autoresizingMask = footerView.autoresizingMask;
    footerLoading.autoresizesSubviews = YES;
    footerView = nil;
    NSLog(@"UITablePostViewController %@ %@",self.view, self.tableView);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    _containerOrigin = self.navigationController.view.frame.origin;
//}
//
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self reloadTableView];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
}
#pragma mark -
#pragma mark UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isLoading || isLoadData) {
        return;
    }

    [super scrollViewDidScroll:scrollView];
	if (([scrollView contentOffset].y + scrollView.frame.size.height) + self.tableView.tableFooterView.frame.size.height >= [scrollView contentSize].height - cCellHeight - 100) {
        NSLog(@"scrolled to bottom");
        if (! isLoadData) {
            if (! footerLoading.superview) {
                [self.tableView.tableFooterView addSubview:footerLoading];
            }
            [footerLoading showWhileExecuting:@selector(addBottomCells) onTarget:self withObject:nil animated:YES];
        }
        return;
	}
	if ([scrollView contentOffset].y == scrollView.frame.origin.y) {
        NSLog(@"scrolled to top ");
        
	}
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (listContent.count == 0) {
        return 1;
    }
    return listContent.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (listContent.count == 0) {
        return tableView.frame.size.height;
    }
    
    Float32 height = [UIPostCell getCellHeightWithContent:[listContent objectAtIndex:indexPath.section]];
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == listContent.count) {
        return 10.0;
    }
    return 1.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (listContent.count == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:tableView.frame];
        cell.backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }
    UIPostCell *cell = [listPostCell objectAtIndex:indexPath.section];
    if ([cell isKindOfClass:[NSNull class]]) {
        [self performSelectorOnMainThread:@selector(loadCellAtIndex:) withObject:[NSNumber numberWithInteger:indexPath.section] waitUntilDone:YES];
        cell = [listPostCell objectAtIndex:indexPath.section];
    }
    [cell updateCellWithContent:[listContent objectAtIndex:indexPath.section]];
    [cell performSelectorOnMainThread:@selector(updateView) withObject:nil waitUntilDone:YES];
    [listPostCell replaceObjectAtIndex:indexPath.section withObject:cell];
    NSLog(@"UIPostCell_Landscape %@", cell);
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
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
    HUD = nil;
}

#pragma mark Supper method

- (void) refresh
{
    if (!loadingHideView) {
        loadingHideView = [[MBProgressHUD alloc]init];
        loadingHideView.hasBackground = NO;
        loadingHideView.mode = MBProgressHUDModeIndeterminate;
    }
    
    isLoadData = YES;
    fromstr = @"0";
    totalstr = @"5";
    //[self.tableView beginUpdates];
    [loadingHideView showWhileExecuting:@selector(loadCellsInBackground) onTarget:self withObject:nil animated:YES];
}

#pragma mark - implement
- (void) drawACell
{
    if (currentCellLoad >= listContent.count) {
        return;
    }
    UIPostCell *cell = [listPostCell objectAtIndex:currentCellLoad];
    if ([cell isKindOfClass:[NSNull class]]) {
        [self performSelectorOnMainThread:@selector(loadCellAtIndex:) withObject:[NSNumber numberWithInteger:currentCellLoad] waitUntilDone:YES];
    }
    cell = nil;
    currentCellLoad ++;
}

- (void) loadCellAtIndex:(NSNumber*)num
{
    NSInteger index = [num integerValue];
    UIPostCell *cell = [listPostCell objectAtIndex:index];
    NSArray *nib = nil;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        nib = [[NSBundle mainBundle] loadNibNamed:@"UIPostCell_Landscape" owner:self options:nil];
    }
    else{
        nib = [[NSBundle mainBundle] loadNibNamed:@"UIPostCell_IPad" owner:self options:nil];
    }
    cell = (UIPostCell *)[nib objectAtIndex:0];
    [cell loadNibFile];
    NSIndexPath *indexPath = [[NSIndexPath alloc]initWithIndex:index];
    cell.indexPath = indexPath;
    cell.navigationController = self.navigationController;
    [cell updateCellWithContent:[listContent objectAtIndex:index]];
    [cell setSelectionStyle:UITableViewCellEditingStyleNone];
    [cell setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [listPostCell replaceObjectAtIndex:index withObject:cell];
    cell.backgroundView = [[UIView alloc]initWithFrame:cell.bounds];
    cell.backgroundView.backgroundColor = [UIColor whiteColor];
}

- (void) reloadTableView
{
    currentCellLoad = 0;
    for (int i=0; i<=listContent.count; i++) {
        [self drawACell];
       
    }
    //[self.tableView endUpdates];
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    //[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    //[self.tableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void) loadCellsWithWallID:(NSInteger)wallID From:(NSInteger)from Count:(NSInteger) count
{
    NSLog(@"Wall ID %d", wallID);
    isLoadData = YES;
    if (listContent) {
        [listContent removeAllObjects];
        [self.tableView reloadData];
    }
    
    totalCellLoad = count;
    wallIDstr = [NSString stringWithFormat:@"%d",wallID];
    fromstr = [NSString stringWithFormat:@"%d", from];
    totalstr = [NSString stringWithFormat:@"%d",count];
    if (self.view.superview) {
        HUD = [[MBProgressHUD alloc]initWithView:self.view.superview];
        [self.view.superview addSubview:HUD];
    }else {
        HUD = [[MBProgressHUD alloc]initWithView:self.view];
        [self.view addSubview:HUD]; 
    }
    
    HUD.userInteractionEnabled = NO;
    [HUD setLabelText:@"Loading..."];
    [HUD showWhileExecuting:@selector(loadCellsInBackground) onTarget:self withObject:nil animated:YES];
    
}
- (void) initPostCell
{
    if (!listPostCell) {
        listPostCell = [[NSMutableArray alloc]initWithCapacity:listContent.count];
    }
    //static NSString *CellIdentifier = @"UIPostCell_Landscape";
    for (int i=0; i<listContent.count; i++) {
        [listPostCell insertObject:[NSNull null] atIndex:0 ];
    }
    [self reloadTableView];

}

- (void) loadCellsInBackground
{
    id data = [[PostadvertControllerV2 sharedPostadvertController] getPostsWithWall:wallIDstr from:fromstr andCount:totalstr WithUserID:@"0"];
    if (data) {
        listContent = data;
        listPostCell = nil;
        [self.tableView setContentOffset:CGPointZero];
    }
    
    [self initPostCell];
    isLoadData = NO;
    self.tableView.scrollEnabled = YES;
    [self stopLoading];
    data = nil;
}
- (void) addTopCells
{
    while (YES) {
        int beforeLoad = listPostCell.count;
        isLoadData = YES;
        totalstr = [NSString stringWithFormat:@"%d", records_one_load];
        fromstr = [NSString stringWithFormat:@"%d",totalCellLoad];
        totalCellLoad += records_one_load;
        NSString *newlestPostID = [NSString stringWithFormat:@"%d",[(PostCellContent*)[listContent objectAtIndex:0] ID_Post]];
        NSMutableArray *bottomCells = [[PostadvertControllerV2 sharedPostadvertController]getContinuePostsWithWall:wallIDstr PostId:newlestPostID WithUserID:@"0" Type:@"next" andCount:totalstr];
        //[[PostadvertControllerV2 sharedPostadvertController] getPostsWithWall:wallIDstr from:fromstr andCount:totalstr WithUserID:@"0"];
        if (bottomCells.count < 1 ) {
            break;
        }
        while (bottomCells.count) {
            [listContent insertObject:[bottomCells lastObject] atIndex:0];
            [bottomCells removeLastObject];
            [listPostCell insertObject:[NSNull null] atIndex:0];
        }
        if (listPostCell.count > beforeLoad) {
            [self reloadTableView];
        }
    }
    isLoadData = NO;
    [self stopLoading];
    
}

- (void) addBottomCells
{
    int beforeLoad = listPostCell.count;
    isLoadData = YES;
    totalstr = [NSString stringWithFormat:@"%d", records_one_load];
    fromstr = [NSString stringWithFormat:@"%d",totalCellLoad];
    totalCellLoad += records_one_load;
    NSString *lastPostID = [NSString stringWithFormat:@"%d",[(PostCellContent*)[listContent lastObject] ID_Post]];
    NSMutableArray *bottomCells = [[PostadvertControllerV2 sharedPostadvertController]getContinuePostsWithWall:wallIDstr PostId:lastPostID WithUserID:@"0" Type:@"previous" andCount:totalstr];
    for (PostCellContent *cellContent in bottomCells) {
        [listContent addObject:cellContent];
        [listPostCell addObject:[NSNull null]];
    }
    if (listPostCell.count > beforeLoad) {
        [self reloadTableView];
    }

    isLoadData = NO;
    
}

- (void) reloadTableViewCellWithInfo:(NSNotification*)userInfo
{
    //NSIndexPath *indexPath = [userInfo.userInfo objectForKey:@"indexPath"];
    //[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject: indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self reloadTableView];
    //
}
//- (void) updateCell:(UIPostCell *)cell withContent:(PostCellContent*) content
//{
//    [cell loadNibFile];
//    if (content == nil) {
//        return;
//    }
//    float cellHeight = 0;
//    CGRect cellFrame, videoFrame, frame;
//    CGSize constraint;
//    CGSize size;
//    if ([[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeRight) 
//    {
//        cellFrame = CGRectMake( 0.0, 0.0, 480, 311);
//    }else {
//        cellFrame = CGRectMake(0.0, 0.0, 320, 311);
//    }
//    videoFrame = CGRectMake(CELL_CONTENT_MARGIN_LEFT, 0.0, cellFrame.size.width - 20 - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT, cYoutubeHeight + (2 * CELL_MARGIN_BETWEEN_IMAGE));//Include left+right magrin 
//    [cell loadNibFile];
//    if (! cell.isLoadContent) {
//        //avatar
//        frame = CGRectMake(CELL_CONTENT_MARGIN_LEFT, CELL_CONTENT_MARGIN_TOP, cAvartaContentHeight, cAvartaContentHeight);
//        cell.imgAvatar.frame = frame;
//        cellHeight = CELL_CONTENT_MARGIN_TOP + cell.imgAvatar.frame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
//        //User name; do not resize now
//        constraint = CGSizeMake(cellFrame.size.width - 20 - cell.imgAvatar.frame.size.width - cell.imgAvatar.frame.origin.x - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT - CELL_MARGIN_BETWEEN_CONTROLL, 20000.0f);
//        size = [cell.userName.text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeClip];
//        [cell.userName setTextColor:[UIColor colorWithRed:79.0/255 green:178.0/255 blue:187.0/255 alpha:1]];
//        frame = CGRectMake(cell.imgAvatar.frame.origin.x + cell.imgAvatar.frame.size.width + CELL_MARGIN_BETWEEN_CONTROLL, CELL_CONTENT_MARGIN_TOP , size.width, size.height);
//        cell.userName.frame = frame;
//        //text 0978679648
//        if (![cell.textContent.text isEqualToString:@""]) {
//            [cell.textContent setFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE]];
//            constraint = CGSizeMake(cellFrame.size.width - 20 - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT, 20000.0f);
//            size = [cell.textContent.text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
//            frame = CGRectMake(CELL_CONTENT_MARGIN_LEFT, cellHeight, size.width, size.height);
//            cell.textContent.frame = frame;
//            cellHeight += size.height + CELL_MARGIN_BETWEEN_CONTROLL;
//        }else {
//            cell.textContent.hidden = YES;
//        }
//        //Video
//        if (content.listVideos.count) {
//            cell.videoView.autoresizesSubviews = YES;
//            [cell.videoView loadContentWithFrame:videoFrame Link:[content.listVideos objectAtIndex:0] Type:linkPreviewTypeYoutube];
//            frame = videoFrame;
//            frame.origin.y = cellHeight;
//            cell.videoView.frame = frame;
//            
//            cellHeight += videoFrame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
//        }else {
//            cell.videoView.hidden = YES;
//        }
//        //add link here
//        if (content.listLinks.count) {
//            cell.linkView.autoresizesSubviews = YES;
//            [cell.linkView loadContentWithFrame:videoFrame Link:[content.listLinks objectAtIndex:0] Type:linkPreviewTypeWebSite];
//            frame = videoFrame;
//            frame.origin.y = cellHeight;
//            cell.linkView.frame = frame;
//            
//            cellHeight += videoFrame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
//        }else {
//            cell.linkView.hidden = YES;
//        }
//        //Add Image
//        if (content.listImages.count) {        
//            frame = videoFrame;
//            cell.thumbnailView.content = content;
//            cell.thumbnailView.navigationController = self.navigationController;
//            
//            frame.origin.y = 0;
//            frame.size.height = cImageHeight + 2 * CELL_MARGIN_BETWEEN_IMAGE ;
//            //[thumbnailView CreateImagesViewWithFrame:frame];
//            
//            //new version here
//            //cell.newController = [[SDWebImageRootViewController alloc] initWithFrame:frame andArray:content.listImages];
//            //[[self navigationController] pushViewController:newController animated:YES];
//            //newController.navigationController = navigationController;
//            //[newController.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
//            //newController.view.frame = frame;
//            //[thumbnailView addSubview:newController.view];
//            
//            frame.origin.y = cellHeight;
//            //thumbnailView.frame = frame;
//            //thumbnailView.backgroundColor = [UIColor grayColor];
//            cellHeight += cImageHeight + 2 * CELL_MARGIN_BETWEEN_IMAGE + CELL_MARGIN_BETWEEN_CONTROLL;
//        }else {
//            cell.thumbnailView.hidden = YES;
//        }
//        //BotView
//        frame = cell.botView.frame;
//        frame.origin.y = cellHeight;
//        cell.botView.frame = frame;
//        //ClapComment
//        [cell.clapComment setBackgroundColor:[UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:219.0/255.0 alpha:1.0]];
//        //[cell.clapComment.layer setCornerRadius:4.0];
//        //- - > clapbtn
//        [cell.clapBtn addTarget:self action:@selector(clapButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        //- - > Clap num
//        NSLog(@"%@", NSStringFromClass([numClap class]));
//        numClap.text = [NSString stringWithFormat:@"%d", _content.totalClap];
//        //- - > button comments
//        [commentBtn setTitle:[NSString stringWithFormat:@"%d comments",_content.totalComment] forState:UIControlStateNormal];
//        [commentBtn addTarget:self action:@selector(commentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        //- - > Quick commentBtn
//        [quickCommentBtn addTarget:self action:@selector(plusButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        cellHeight += frame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
//        isLoadContent = YES;
//    }
//    else {
//        //avatar
//        cellHeight = CELL_CONTENT_MARGIN_TOP + imgAvatar.frame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
//        //User name; do not resize now
//        //text
//        if (![textContent.text isEqualToString:@""]) {
//            NSLog(@"Text : %@", textContent.text);
//            constraint = CGSizeMake(cellFrame.size.width - 20 - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT, 20000.0f);
//            size = [textContent.text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
//            frame = CGRectMake(CELL_CONTENT_MARGIN_LEFT, cellHeight, size.width, size.height);
//            textContent.frame = frame;
//            cellHeight += size.height + CELL_MARGIN_BETWEEN_CONTROLL;
//        }
//        //Video
//        if (_content.listVideos.count) {
//            [videoView reDrawWithFrame:videoFrame];
//            frame = videoFrame;
//            frame.origin.y = cellHeight;
//            videoView.frame = frame;
//            
//            cellHeight += videoFrame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
//        }
//        //add link here
//        if (_content.listLinks.count) {
//            [linkView reDrawWithFrame:videoFrame];
//            frame = videoFrame;
//            frame.origin.y = cellHeight;
//            linkView.frame = frame;
//            cellHeight += videoFrame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
//        }
//        //Add Image
//        if (_content.listImages.count) {
//            frame = thumbnailView.frame;
//            frame.origin.y = 0;
//            newController.view.frame = frame;
//            frame.origin.y = cellHeight;
//            thumbnailView.frame = frame;
//            cellHeight += cImageHeight + 2 * CELL_MARGIN_BETWEEN_IMAGE + CELL_MARGIN_BETWEEN_CONTROLL;
//        }
//        //BotView
//        frame = botView.frame;
//        frame.origin.y = cellHeight;
//        botView.frame = frame;
//        //ClapComment
//        
//        //- - > Clap num
//        
//        //- - > button comments
//        
//        
//        cellHeight += frame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
//    }
//    [cell setNeedsDisplay];
//    [cell setNeedsLayout];
//}
 
@end
