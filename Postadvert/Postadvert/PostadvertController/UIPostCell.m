//
//  UIPostCell.m
//  PostAdvert11
//
//  Created by Mtk Ray on 5/8/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import "UIPostCell.h"
#import "Constants.h"
#import "PostCellContent.h"
#import "AddCommentViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "LinkPreview.h"
#import "LinkViewController.h"
#import "ImageViewController.h"
#import "CommentsViewController.h"
#import "ThumbnailPostCellView.h"
#import "UILabel+RectForLetter.h"
#import "SDWebImageRootViewController.h"
#import "NSAttributedString+Attributes.h"

#define CharacterLimit 200



@interface UIPostCell()
- (void) refreshClapCommentsView;
- (void) addCommentsListenner;
- (void) removeCommentsListenner;
- (void) plusSuccessWithPost;
- (void) plusSuccessNoPost;
//- (void) addButtonMore;
+ (NSString*) limitText:(NSString*)str;

@end

@implementation UIPostCell
{
    UIImageView *avarta;
    UILabel *label;
    UITextView *textView;
    UITextField *textField;
    UIView *_contentCellView;
    Float32 cellHeight;
}
@synthesize content = _content;
@synthesize height = _height;
@synthesize isDidDraw = _isDidDraw;
@synthesize navigationController;
@synthesize videoView = _videoView;
@synthesize linkView = _linkPreview;
@synthesize thumbnailView = _thumnailView;
@synthesize clapComment = _clapCommentView;
@synthesize textContent = _textContent;
@synthesize  imgAvatar = _imageAvatar;
@synthesize userName = _userName;
@synthesize numClap = _numclap;
@synthesize clapBtn = _clapBtn;
@synthesize commentBtn = _commentBtn;
@synthesize quickCommentBtn = _quickCommentBtn;
@synthesize botView = _botView;
@synthesize isLoadContent = _isLoadContent;
@synthesize indexPath;
@synthesize isShowFullText;
@synthesize titlePost = titlePost;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (reuseIdentifier == nil) {
        reuseIdentifier = @"UIPostCell_Landscape";
    }
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:reuseIdentifier owner:self options:nil];
    self = [topLevelObjects objectAtIndex:0];
    topLevelObjects = nil;
    isDidDraw = NO;

    if (!self) {
        // Initialization code
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - textView delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}

#pragma mark - congfig cell
- (void) loadNibFile
{
    if (! isDidDraw) {
        imgAvatar  = (UIImageView*)[self viewWithTag:1];
        userName   = (UILabel*)[self viewWithTag:2];
        textContent       = (OHAttributedLabel*)[self viewWithTag:3];
        //textContent.linkColor = [UIColor colorWithRed:0/255.0 green:93.0/255.0 blue:179.0/255 alpha:1];
        textContent.linkColor = [UIColor blueColor];
        //textContent.contentInset = UIEdgeInsetsZero;
        //textContent.delegate = self;
        textContent.extendBottomToFit = YES;
        videoView  = (LinkPreview*)[self viewWithTag:4];
        linkView   = (LinkPreview*)[self viewWithTag:5];
        thumbnailView = (ThumbnailPostCellView*)[self viewWithTag:6];
        botView    =[self viewWithTag:7];
        clapComment= [self viewWithTag:8];
        clapBtn    = (UIButton*)[self viewWithTag:9];
        commentBtn = (UIButton*)[self viewWithTag:10];
        numClap    = (UILabel*)[self viewWithTag:11];
        quickCommentBtn = (UIButton*)[self viewWithTag:12];
        titlePost    = (OHAttributedLabel*)[self viewWithTag:13];
        isDidDraw = YES;
    }
}
- (void) updateView
{
    cellHeight = 0;
    CGRect cellFrame, videoFrame, frame;
    CGSize constraint;
    CGSize size;
    if ([[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeRight)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            cellFrame = CGRectMake( 0.0, 0.0, 480, 311);
        }else
        {
            cellFrame = CGRectMake( 0.0, 0.0, 1024, 768);
        }
        
    }else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            cellFrame = CGRectMake(0.0, 0.0, 320, 311);
        }else
        {
            cellFrame = CGRectMake( 0.0, 0.0, 768, 1024);
        }
    }
    float leftMarginContent = CELL_CONTENT_MARGIN_LEFT;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        leftMarginContent = CELL_CONTENT_MARGIN_LEFT + cAvartaContentHeight + CELL_MARGIN_BETWEEN_CONTROLL;
    }
    videoFrame = CGRectMake(leftMarginContent, 0.0, cellFrame.size.width - 20 - leftMarginContent - CELL_CONTENT_MARGIN_RIGHT, cYoutubeHeight + (2 * CELL_MARGIN_BETWEEN_IMAGE));//Include left+right magrin
    //avatar
    
    //Title
    cellHeight = CELL_CONTENT_MARGIN_TOP + imgAvatar.frame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
    constraint = CGSizeMake(cellFrame.size.width - 20 - imgAvatar.frame.size.width - imgAvatar.frame.origin.x - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT - CELL_MARGIN_BETWEEN_CONTROLL, 20000.0f);
    size = [titlePost.text sizeWithFont:titlePost.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    titlePost.frame = CGRectMake(imgAvatar.frame.origin.x + imgAvatar.frame.size.width + CELL_MARGIN_BETWEEN_CONTROLL, 22, size.width, size.height);
    //[titlePost setTextColor:[UIColor colorWithRed:105.0/255.0 green:92.0/255.0 blue:75.0/225.0 alpha:1.0]];
    
    Float32 tempHeight = titlePost.frame.origin.y + titlePost.frame.size.height;
    
    cellHeight = cellHeight > tempHeight ? cellHeight : tempHeight;
    //titlePost.frame = CGRectMake(imgAvatar.frame.origin.x + imgAvatar.frame.size.width + CELL_MARGIN_BETWEEN_CONTROLL, 22, cellFrame.size.width - 20 - imgAvatar.frame.size.width - imgAvatar.frame.origin.x - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT - CELL_MARGIN_BETWEEN_CONTROLL, titlePost.frame.size.height);
    
    
    //User name; do not resize now
    //text
    NSLog(@"User Name %@", userName.text);
    if (![textContent.text isEqualToString:@""]) {
        if (self.isShowFullText) {
            textContent.text = _content.text;
        }
        NSLog(@"Text : %@", textContent.text);
        constraint = CGSizeMake(cellFrame.size.width - 20 - leftMarginContent - CELL_CONTENT_MARGIN_RIGHT, 20000.0f);
        size = [textContent.text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        frame = CGRectMake(leftMarginContent, cellHeight, size.width, size.height);
        textContent.frame = frame;
        cellHeight += size.height + CELL_MARGIN_BETWEEN_CONTROLL;
    }
    //Add Image
    if (_content.listImages.count) {
        frame = thumbnailView.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        newController.view.frame = frame;
        frame = videoFrame;
        frame.origin.y = cellHeight;
        thumbnailView.frame = frame;
        cellHeight += cImageHeight + 2 * CELL_MARGIN_BETWEEN_IMAGE + CELL_MARGIN_BETWEEN_CONTROLL;
    }
    //add link here
    if (_content.listLinks.count) {
        //[linkView reDrawWithFrame:videoFrame];
        frame = videoFrame;
        frame.origin.y = cellHeight;
        linkView.frame = frame;
        cellHeight += videoFrame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
    }
    //Video
    if (_content.listVideos.count) {
        [videoView reDrawWithFrame:videoFrame];
        frame = videoFrame;
        frame.origin.y = cellHeight;
        videoView.frame = frame;
        
        cellHeight += videoFrame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
    }
    
    
    //BotView
    frame = botView.frame;
    frame.origin.y = cellHeight;
    botView.frame = frame;
    //ClapComment
    
    //- - > Clap num
    
    //- - > button comments
    
    
    //cellHeight += frame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
}
- (void) updateCellWithContent:(PostCellContent *)content
{
    if (content != nil) {
        _content = nil;
        _content = content;
    }
    if (content.ID_Post == 1044 || content.ID_Post== 1035) {
        NSLog(@"%d", [UIPostCell limitText:content.text].length);
    }
    cellHeight = 0;
    CGRect cellFrame, videoFrame, frame;
    CGSize constraint;
    CGSize size;
    if ([[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeRight) 
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            cellFrame = CGRectMake( 0.0, 0.0, 480, 311);
        }else
        {
            cellFrame = CGRectMake( 0.0, 0.0, 1024, 768);
        }
        
    }else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            cellFrame = CGRectMake(0.0, 0.0, 320, 311);
        }else
        {
            cellFrame = CGRectMake( 0.0, 0.0, 768, 1024);
        }
    }
    float leftMarginContent = CELL_CONTENT_MARGIN_LEFT;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        leftMarginContent = CELL_CONTENT_MARGIN_LEFT + cAvartaContentHeight + CELL_MARGIN_BETWEEN_CONTROLL;
    }
    videoFrame = CGRectMake(leftMarginContent, 0.0, cellFrame.size.width - 20 - leftMarginContent - CELL_CONTENT_MARGIN_RIGHT, cYoutubeHeight + (2 * CELL_MARGIN_BETWEEN_IMAGE));//Include left+right magrin 
    //[self loadNibFile];
    if (! isLoadContent) {
        
        imgAvatar.image = content.userAvatar;
        userName.text = content.userPostName;
        //textContent.text = _content.text;
        titlePost.text = content.titlePost;
        
        NSLog(@"Name %@ %@",userName.text, _content.userPostName);
        //avatar
        frame = CGRectMake(CELL_CONTENT_MARGIN_LEFT, CELL_CONTENT_MARGIN_TOP, cAvartaContentHeight, cAvartaContentHeight);
        imgAvatar.frame = frame;
        cellHeight = CELL_CONTENT_MARGIN_TOP + imgAvatar.frame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
        //User name; do not resize now
        constraint = CGSizeMake(cellFrame.size.width - 20 - imgAvatar.frame.size.width - imgAvatar.frame.origin.x - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT - CELL_MARGIN_BETWEEN_CONTROLL, 20000.0f);
        size = [userName.text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeClip];
        [userName setTextColor:[UIColor colorWithRed:79.0/255 green:178.0/255 blue:187.0/255 alpha:1]];
        //[userName setTextColor:[UIColor blueColor]];
        
        //Title
        constraint = CGSizeMake(cellFrame.size.width - 20 - imgAvatar.frame.size.width - imgAvatar.frame.origin.x - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT - CELL_MARGIN_BETWEEN_CONTROLL, 20000.0f);
        size = [titlePost.text sizeWithFont:titlePost.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        titlePost.frame = CGRectMake(imgAvatar.frame.origin.x + imgAvatar.frame.size.width + CELL_MARGIN_BETWEEN_CONTROLL, 22, size.width, size.height);
        //[titlePost setTextColor:[UIColor colorWithRed:105.0/255.0 green:92.0/255.0 blue:75.0/225.0 alpha:1.0]];
        
        Float32 tempHeight = titlePost.frame.origin.y + titlePost.frame.size.height;
        
        cellHeight = cellHeight > tempHeight ? cellHeight : tempHeight;
        
        
        if (![content.text isEqualToString:@""]) {
//            NSMutableAttributedString* attrStr = [NSMutableAttributedString attributedStringWithString:[UIPostCell limitText: _content.text]];
//            // for those calls we don't specify a range so it affects the whole string
//            [attrStr setFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE]];
//            [attrStr setTextAlignment:kCTLeftTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
//            textContent.attributedText = attrStr;
            textContent.text = [UIPostCell limitText:content.text];
            [textContent setFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE]];
            constraint = CGSizeMake(cellFrame.size.width - 20 - leftMarginContent - CELL_CONTENT_MARGIN_RIGHT, 20000.0f);
            size = [textContent.text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
            frame = CGRectMake(leftMarginContent, cellHeight, size.width, size.height);
            textContent.frame = frame;
            if (textContent.text.length != content.text.length) {
                // addButton "more"
                //[self addButtonMore];
                NSRange linkRange = [textContent.text rangeOfString:@"... more"];
                [textContent addCustomLink:[NSURL URLWithString:@"more://locallhost"] inRange:linkRange];
            }
            cellHeight += size.height + CELL_MARGIN_BETWEEN_CONTROLL;
            textContent.hidden = NO;
        }else {
            textContent.hidden = YES;
        }
        //Add Image
        if (_content.listImages.count) {
            frame = videoFrame;
            frame.origin.x = 0;
            frame.origin.y = 0;
            frame.size.height = cImageHeight + 2 * CELL_MARGIN_BETWEEN_IMAGE ;
            //[thumbnailView CreateImagesViewWithFrame:frame];
            //new version here
            newController = [[SDWebImageRootViewController alloc] initWithFrame:frame andArray:_content.listImages];
            newController.navigationController = navigationController;
            [newController LoadThumbnail];
            newController.view.frame = frame;
            [thumbnailView addSubview:newController.view];
            thumbnailView.backgroundColor = self.backgroundColor;
            frame = videoFrame;
            frame.origin.y = cellHeight;
            thumbnailView.frame = frame;
            cellHeight += cImageHeight + 2 * CELL_MARGIN_BETWEEN_IMAGE + CELL_MARGIN_BETWEEN_CONTROLL;
            thumbnailView.hidden = NO;
        }else {
            thumbnailView.hidden = YES;
        }
        //add link here
        if (_content.linkWebsite) {
            linkView.autoresizesSubviews = YES;
            frame = videoFrame;
            [linkView loadContentWithFrame:frame LinkInfo:_content.linkWebsite Type:linkPreviewTypeWebSite];
            frame.origin.y = cellHeight;
            linkView.frame = frame;
            cellHeight += videoFrame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
            linkView.hidden = NO;
        }else {
            linkView.hidden = YES;
        }
        //Video
        if (_content.linkYoutube) {
            videoView.autoresizesSubviews = YES;
            frame = videoFrame;
            [videoView loadContentWithFrame:frame LinkInfo:_content.linkYoutube Type:linkPreviewTypeYoutube];
            frame.origin.y = cellHeight;
            videoView.frame = frame;
            cellHeight += videoFrame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
            videoView.hidden = NO;
        }else {
            videoView.hidden = YES;
        }
        
        
        //BotView
        frame = botView.frame;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            frame.origin.x = leftMarginContent - CELL_CONTENT_MARGIN_LEFT;
            frame.size.width = frame.size.width - (leftMarginContent - CELL_CONTENT_MARGIN_LEFT);
        }
        frame.origin.y = cellHeight;
        botView.frame = frame;
          //ClapComment
        [clapComment setBackgroundColor:[UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:219.0/255.0 alpha:1.0]];
        [clapComment.layer setCornerRadius:4.0];
        //- - > clapbtn
        [clapBtn addTarget:self action:@selector(clapButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        //- - > Clap num
        numClap.text = [NSString stringWithFormat:@"%d", _content.totalClap];
        //- - > button comments

        commentBtn.titleLabel.textColor = [UIColor colorWithRed:79.0/255 green:178.0/255 blue:187.0/255 alpha:1];
        //commentBtn.titleLabel.textColor = [UIColor blueColor];
        [commentBtn setTitle:[NSString stringWithFormat:@"%d comments",_content.totalComment] forState:UIControlStateNormal];
        [commentBtn addTarget:self action:@selector(commentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //- - > Quick commentBtn
        [quickCommentBtn addTarget:self action:@selector(plusButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        cellHeight += frame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
        isLoadContent = YES;
        NSLog(@"Cell Height1 %d %f",content.ID_Post, cellHeight);
    }
    else {
        //avatar
        cellHeight = CELL_CONTENT_MARGIN_TOP + imgAvatar.frame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
        // title
        constraint = CGSizeMake(cellFrame.size.width - 20 - imgAvatar.frame.size.width - imgAvatar.frame.origin.x - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT - CELL_MARGIN_BETWEEN_CONTROLL, 20000.0f);
        size = [titlePost.text sizeWithFont:titlePost.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        titlePost.frame = CGRectMake(imgAvatar.frame.origin.x + imgAvatar.frame.size.width + CELL_MARGIN_BETWEEN_CONTROLL, 22, size.width, size.height);
        //[titlePost setTextColor:[UIColor colorWithRed:105.0/255.0 green:92.0/255.0 blue:75.0/225.0 alpha:1.0]];
        
        Float32 tempHeight = titlePost.frame.origin.y + titlePost.frame.size.height;
        
        cellHeight = cellHeight > tempHeight ? cellHeight : tempHeight;
        
        //titlePost.frame = CGRectMake(imgAvatar.frame.origin.x + imgAvatar.frame.size.width + CELL_MARGIN_BETWEEN_CONTROLL, 22, cellFrame.size.width - 20 - imgAvatar.frame.size.width - imgAvatar.frame.origin.x - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT - CELL_MARGIN_BETWEEN_CONTROLL, titlePost.frame.size.height);
        //User name; do not resize now
        //text
        NSLog(@"User Name %@", userName.text);
        if (![textContent.text isEqualToString:@""]) {
            if (self.isShowFullText) {
                textContent.text = content.text;
            }
            NSLog(@"Text : %@", textContent.text);
            constraint = CGSizeMake(cellFrame.size.width - 20 - leftMarginContent - CELL_CONTENT_MARGIN_RIGHT, 20000.0f);
            size = [textContent.text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
            frame = CGRectMake(leftMarginContent, cellHeight, size.width, size.height);
            textContent.frame = frame;
            cellHeight += size.height + CELL_MARGIN_BETWEEN_CONTROLL;
        }
        //Add Image
        if (_content.listImages.count) {
            frame = videoFrame;
            frame.origin.x = 0;
            frame.origin.y = 0;
            newController.view.frame = frame;
            frame = videoFrame;
            frame.origin.y = cellHeight;
            thumbnailView.frame = frame;
            cellHeight += cImageHeight + 2 * CELL_MARGIN_BETWEEN_IMAGE + CELL_MARGIN_BETWEEN_CONTROLL;
        }
        //add link here
        if (_content.listLinks.count) {
            //[linkView reDrawWithFrame:videoFrame];
            frame = videoFrame;
            frame.origin.y = cellHeight;
            linkView.frame = frame;
            cellHeight += videoFrame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
        }

        //Video
        if (_content.listVideos.count) {
            [videoView reDrawWithFrame:videoFrame];
            frame = videoFrame;
            frame.origin.y = cellHeight;
            videoView.frame = frame;
            
            cellHeight += videoFrame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
        }
                
        //BotView
        frame = botView.frame;
        frame.origin.y = cellHeight;
        botView.frame = frame;
        //ClapComment
        
        //- - > Clap num
        
        //- - > button comments
        
        
        //cellHeight += frame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
    }
    //[self performSelectorOnMainThread:@selector(setNeedsLayout) withObject:nil waitUntilDone:YES];
    //[self setNeedsDisplay];
    //[self performSelector:@selector(setNeedsDisplay)];
    //[self setNeedsLayout];
    //[self setNeedsDisplay];
}

+ (Float32) getCellHeightWithContent:(PostCellContent*)content
{
    if (!content) {
        return 0.0;
    }
    if (content.ID_Post == 1044 || content.ID_Post== 1035) {
        NSLog(@"%d", [UIPostCell limitText:content.text].length);
    }
    Float32 cellHeight = 0;
    CGRect cellFrame, videoFrame, frame;
    CGSize constraint;
    CGSize size;
    if ([[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeRight)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            cellFrame = CGRectMake( 0.0, 0.0, 480, 311);
        }else
        {
            cellFrame = CGRectMake( 0.0, 0.0, 1024, 768);
        }
        
    }else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            cellFrame = CGRectMake(0.0, 0.0, 320, 311);
        }else
        {
            cellFrame = CGRectMake( 0.0, 0.0, 768, 1024);
        }
    }
    float leftMarginContent = CELL_CONTENT_MARGIN_LEFT;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        leftMarginContent = CELL_CONTENT_MARGIN_LEFT + cAvartaContentHeight + CELL_MARGIN_BETWEEN_CONTROLL;
    }
    videoFrame = CGRectMake(leftMarginContent, 0.0, cellFrame.size.width - 20 - leftMarginContent - CELL_CONTENT_MARGIN_RIGHT, cYoutubeHeight + (2 * CELL_MARGIN_BETWEEN_IMAGE));//Include left+right magrin
    //avatar
    cellHeight = CELL_CONTENT_MARGIN_TOP + cAvartaContentHeight + CELL_MARGIN_BETWEEN_CONTROLL;
    //User name
    //title
    
    constraint = CGSizeMake(cellFrame.size.width - 20 - cAvartaContentHeight - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT - CELL_MARGIN_BETWEEN_CONTROLL, 20000.0f);
    size = [content.titlePost sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_TITLE_SIZE -1] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    //[titlePost setTextColor:[UIColor colorWithRed:105.0/255.0 green:92.0/255.0 blue:75.0/225.0 alpha:1.0]];
    
    Float32 tempHeight = 22 + size.height;
    
    cellHeight = cellHeight > tempHeight ? cellHeight : tempHeight;
    //text
    if (![content.text isEqualToString:@""]) {
        constraint = CGSizeMake(cellFrame.size.width - 20 - leftMarginContent - CELL_CONTENT_MARGIN_RIGHT, 20000.0f);
        NSString *str = [UIPostCell limitText:content.text];
        if (content.isShowFullText) {
            str = content.text;
        }
        size = [str sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        frame = CGRectMake(leftMarginContent, cellHeight, size.width, size.height);
        cellHeight += size.height + CELL_MARGIN_BETWEEN_CONTROLL;
    }
    //Add Image
    if (content.listImages.count) {
        cellHeight += cImageHeight + 2 * CELL_MARGIN_BETWEEN_IMAGE + CELL_MARGIN_BETWEEN_CONTROLL;
    }
    //add link here
    if (content.listLinks.count) {
        cellHeight += videoFrame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
    }
    //Video
    if (content.listVideos.count) {
        cellHeight += videoFrame.size.height + CELL_MARGIN_BETWEEN_CONTROLL;
    }
    
   
    //Bot view
    cellHeight += 38 + CELL_MARGIN_BETWEEN_CONTROLL;//botView.frame.size.height = 38
    
    cellHeight += CELL_MARGIN_BETWEEN_CONTROLL;

    NSLog(@"Cell Height2 %d %f",content.ID_Post, cellHeight);
    return cellHeight;
}

- (void) clapButtonClicked:(id) sender
{
    
    
    UIActionSheet *uias = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self 
                                             cancelButtonTitle:@"Cancel"
                                        destructiveButtonTitle:nil 
                                             otherButtonTitles:_content.isClap ? @"Unclap" : @"Clap", nil];
    
    [uias showInView:self];
    uias = nil;
}

- (void) commentButtonClick:(id) sender
{
    if (_content.listComments.count == 0) {
        return;
    }
    [self addCommentsListenner];
    CommentsViewController *commentViewCtr = [[CommentsViewController alloc]init];
    commentViewCtr.content = _content;
    //[self addCommentsListenner];
    [navigationController pushViewController: commentViewCtr animated:YES];
    // = nil;
    commentViewCtr = nil;
}

- (CGRect) nextFrameWithSize:(CGSize) size fromFrame:(CGRect) frame withMaxY:(Float32) y
{
    CGRect nextFrame = CGRectZero;
    nextFrame.origin.y = frame.origin.y;
    float margin = frame.origin.x<=CELL_CONTENT_MARGIN_LEFT ? 0 :CELL_MARGIN_BETWEEN_IMAGE;
    if (CELL_CONTENT_WIDTH - (frame.origin.x + frame.size.width + margin + CELL_CONTENT_MARGIN_RIGHT  ) >= size.width) {//check: can add more image horizontal
        nextFrame.origin.x = frame.origin.x + frame.size.width +margin;
        nextFrame.size = size;
        return nextFrame;
    }
    nextFrame.origin.x = CELL_CONTENT_MARGIN_LEFT;
    nextFrame.origin.y = y + margin;
    float width = CELL_CONTENT_WIDTH - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT;
    nextFrame.size.width = size.width > width ? width : size.width;
    nextFrame.size.height = size.height * (nextFrame.size.width / size.width);
    return nextFrame;
}

- (void) plusButtonClicked
{
    //navigationController.navigationBarHidden =YES;
    AddCommentViewController *addCommand = [[AddCommentViewController alloc]init];
    addCommand.content = self.content;
    [self addCommentsListenner];
    [navigationController presentModalViewController:addCommand animated:NO];
    // = nil;
    addCommand = nil;
}

/*|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
 
 Returns the video id for any type of youtube url that holds one, like the links bellow.
 
 http://www.youtube.com/watch?v=pkPgYbdQ1kQ&feature=feedu
 www.youtube.com/watch?v=pkPgYbdQ1kQ&feature=feedu
 youtube.com/watch?v=pkPgYbdQ1kQ&feature=feedu
 http://www.youtube.com/v/pkPgYbdQ1kQ&feature=feedu
 www.youtube.com/v/pkPgYbdQ1kQ&feature=feedu
 http://youtu.be/pkPgYbdQ1kQ
 youtu.be/pkPgYbdQ1kQ
 
 |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/

/* 
 get Thumbnail
 http://i3.ytimg.com/vi/NLqAF9hrVbY/hqdefault.jpg
 
 */

- (NSString*) getYoutubeIDFromUrl:(NSString*) url
{
    NSString *videoID = [url stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    videoID = [videoID stringByReplacingOccurrencesOfString:@"www." withString:@""];
    videoID = [videoID stringByReplacingOccurrencesOfString:@"youtube.com/watch?v=" withString:@""];
    videoID = [videoID stringByReplacingOccurrencesOfString:@"youtube.com/v/" withString:@""];
    videoID = [videoID stringByReplacingOccurrencesOfString:@"youtu.be/" withString:@""]; 
    return [[videoID componentsSeparatedByString:@"&"] objectAtIndex:0];
    videoID = nil;
}

- (UIImage*) getYoutubeThumbnailFromUrl:(NSString*) url
{
    if(!url)
        return nil;
    NSURL *imageLink = [NSURL URLWithString:[NSString stringWithFormat:@"http://i3.ytimg.com/vi/%@/hqdefault.jpg", [self getYoutubeIDFromUrl:url]]];
    return [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:imageLink]];
    imageLink = nil;
}


#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)uias clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // user pressed "Cancel"
    if(buttonIndex == [uias cancelButtonIndex]) return;
    // user pressed "Clap"/"Unclap" 
    //Upadte server
    
    //Update local
    _content.isClap = !_content.isClap;
    if (_content.isClap) {
        _content.totalClap += 1;
    }else {
        _content.totalClap -= 1;
    }
    [self refreshClapCommentsView];
}


#pragma mark - Notification

- (void) refreshClapCommentsView
{
    if (isDidDraw) {
        numClap.text = [NSString stringWithFormat:@"%d", _content.totalClap];
        [commentBtn setTitle:[NSString stringWithFormat:@"%d comments",_content.totalComment] forState:UIControlStateNormal];
    }
    

}
- (void) addCommentsListenner
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(plusSuccessNoPost) name:@"plusSuccessNoPost" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(plusSuccessWithPost) name:@"plusSuccessWithPost" object:nil];
}
- (void) removeCommentsListenner
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"plusSuccessNoPost" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"plusSuccessWithPost" object:nil];
}
- (void) plusSuccessWithPost
{
    [self removeCommentsListenner];
    [self refreshClapCommentsView];
}
- (void) plusSuccessNoPost
{
    [self removeCommentsListenner];
}

#pragma mark - 

+ (NSString*) limitText:(NSString*)str
{
    int lenght = [str length];
    if (lenght > (CharacterLimit + 7)) {
        str = [str substringToIndex:CharacterLimit];
        str = [str stringByAppendingString:@" ... more"];
    }
    return str;
}

//- (void) addButtonMore
//{
//    UITextView *textStuff = [[UITextView alloc] init];
//    textStuff.frame = textContent.frame;
//    textStuff.text = textContent.text;
//    textStuff.textColor = [UIColor blackColor];
    
//    UITextPosition *Pos2 = [textContent positionFromPosition: textContent.endOfDocument offset: 0];
//    UITextPosition *Pos1 = [textContent positionFromPosition: textContent.endOfDocument offset: -4];
//    
//    UITextRange *range = [textContent textRangeFromPosition:Pos1 toPosition:Pos2];
//    
//    CGRect result1 = [textContent firstRectForRange:(UITextRange *)range ];
//    
//    NSLog(@"%f, %f", result1.origin.x, result1.origin.y);
//    
//    UIView *view1 = [[UIView alloc] initWithFrame:result1];
//    view1.backgroundColor = [UIColor colorWithRed:0.2f green:0.5f blue:0.2f alpha:0.4f];
//    CGRect frame = [textContent rectForLetterAtIndex:textContent.text.length - 1];
//    NSLog(@"view %@ , X %f, Y %f, W %f, H %f", self, frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
//    btnMore.frame = frame;
//    btnMore.backgroundColor = [UIColor redColor];
//    btnMore.hidden = NO;
//    [textContent addSubview:btnMore];
//}

-(BOOL)attributedLabel:(OHAttributedLabel *)attributedLabel shouldFollowLink:(NSTextCheckingResult *)linkInfo
{
	NSLog(@"%@",[linkInfo.URL scheme]);
	if ([[linkInfo.URL scheme] isEqualToString:@"more"]) {
		// We use this arbitrary URL scheme to handle custom actions
		// So URLs like "user://xxx" will be handled here instead of opening in Safari.
		// Note: in the above example, "xxx" is the 'host' part of the URL
		// Prevent the URL from opening in Safari, as we handled it here manually instead
        NSDictionary *info = [NSDictionary dictionaryWithObject:self.indexPath forKey:@"indexPath"];
        
        [textContent removeAllCustomLinks];
        isShowFullText = YES;
        _content.isShowFullText = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UIPostCell_More_Click" object:nil userInfo:info];
        
		return NO;
	} else {
		switch (linkInfo.resultType) {
			case NSTextCheckingTypeLink: // use default behavior
				break;
			case NSTextCheckingTypeAddress:
				//DisplayAlert(@"Address",[linkInfo.addressComponents description]);
				break;
			case NSTextCheckingTypeDate:
				//DisplayAlert(@"Date",[linkInfo.date description]);
				break;
			case NSTextCheckingTypePhoneNumber:
				//DisplayAlert(@"Phone Number",linkInfo.phoneNumber);
				break;
			default:
				//DisplayAlert(@"Unknown link type",[NSString stringWithFormat:@"You typed on an unknown link type (NSTextCheckingType %lld)",linkInfo.resultType]);
				break;
		}
		// Execute the default behavior, which is opening the URL in Safari for URLs, starting a call for phone numbers, ...
		return YES;
	}
}


//-(UIView*) drawContent
//{
//    return nil;
//    NSLog(@"Cell Width %f", self.frame.size.width);
//    if (!_content) {
//        return nil;
//    }
//    CGSize constraint;
//    CGSize size;
//    NSLog(@"Content: %@ , %@, %d",_content.userPostName, _content.text, _content.listImages.count);
//    cellHeight = 0.0;
//    if (!_contentCellView) {
//        _contentCellView = [[UIView alloc]init];
//    }
//    if (_content.userAvatar == nil) {
//        _content.userAvatar = [UIImage imageNamed:@"avatar.png"];
//    }
//    avarta = [[UIImageView alloc]initWithImage:_content.userAvatar ];
//    avarta.contentMode = UIViewContentModeScaleAspectFill;
//    avarta.frame = CGRectMake(cAvartaMargin, CELL_CONTENT_MARGIN_TOP, cAvartaContentHeight, cAvartaContentHeight);
//    [_contentCellView addSubview:avarta];
//    
//    userName = nil;
//    constraint = CGSizeMake(CELL_CONTENT_WIDTH - (avarta.frame.size.width + avarta.frame.origin.x + CELL_CONTENT_MARGIN_RIGHT), self.frame.size.height);
//    size = [_content.userPostName sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
//    userName = [[UILabel alloc]initWithFrame:CGRectMake( avarta.frame.size.width + avarta.frame.origin.x + CELL_CONTENT_MARGIN_TOP, CELL_CONTENT_MARGIN_RIGHT, size.width , size.height)];
//    userName.text = _content.userPostName;
//    [userName setFont:[UIFont fontWithName: FONT_NAME size:FONT_SIZE]];
//    [userName setTextColor:[UIColor colorWithRed:79.0/255 green:178.0/255 blue:187.0/255 alpha:1]];
//    NSLog(@"UserName %@", userName);
//    [_contentCellView addSubview:userName];
//    cellHeight += avarta.frame.origin.y + avarta.frame.size.height + CELL_MARGIN_BETWEEN_IMAGE;
//    
//    constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN_LEFT + CELL_CONTENT_MARGIN_RIGHT), 20000.0f);
//    size = [_content.text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
//    //textView.delegate = self;
//    textView = nil;
//    textView = [[UITextView alloc]initWithFrame:CGRectMake(CELL_CONTENT_MARGIN_LEFT, cellHeight, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN_LEFT + CELL_CONTENT_MARGIN_RIGHT), size.height)];
//    //textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    [textView setFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE]];
//    [textView setText:_content.text];
//    textView.editable = NO;
//    textView.scrollEnabled = NO;
//    //textView.dataDetectorTypes = UIDataDetectorTypeAll;
//    CGRect frame = textView.frame;
//    frame.size.height = textView.contentSize.height + 10.0 + textView.contentInset.top + textView.contentInset.bottom;
//    textView.frame = frame;
//    [_contentCellView addSubview:textView];
//    cellHeight += textView.frame.size.height ;
//    
//    //add video here
//    if (_content.listVideos.count) {
//        frame = CGRectMake(CELL_CONTENT_MARGIN_LEFT , cellHeight, CELL_CONTENT_WIDTH - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT,cYoutubeHeight + 2 * CELL_MARGIN_BETWEEN_IMAGE );
//        videoView = nil;
//        videoView = [[LinkPreview alloc]initWithFrame:frame Link:[_content.listVideos objectAtIndex:0] Type:linkPreviewTypeYoutube];
//        //@"http://www.youtube.com/watch?v=DpwdwC6RKYY&feature=g-vrec";
//        [_contentCellView addSubview:videoView];
//        cellHeight += videoView.frame.size.height + CELL_MARGIN_BETWEEN_IMAGE;
//    }
//    //add link here
//    if (_content.listLinks.count) {
//        frame = CGRectMake(CELL_CONTENT_MARGIN_LEFT , cellHeight, CELL_CONTENT_WIDTH - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT,cYoutubeHeight + 2 * CELL_MARGIN_BETWEEN_IMAGE );
//        linkView = nil;
//        linkView = [[LinkPreview alloc]initWithFrame:frame Link:[_content.listLinks objectAtIndex:0] Type:linkPreviewTypeWebSite];
//        [_contentCellView addSubview:linkView];
//        cellHeight += linkView.frame.size.height + CELL_MARGIN_BETWEEN_IMAGE;
//    }
//    //add Image
//    frame = CGRectMake(CELL_CONTENT_MARGIN_LEFT, cellHeight, 0.0, 0.0);
//    
//    //    for (UIImage *image in _content.listImages) {
//    //        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
//    //        frame = [self nextFrameWithSize:image.size fromFrame:frame withMaxY: cellHeight];
//    //        imageView.frame = frame;
//    //        cellHeight = ( cellHeight < (frame.origin.y + frame.size.height) ) ? (frame.origin.y + frame.size.height) : cellHeight;
//    //        //Config for tap here
//    //        NSLog(@"Frame %@", imageView);
//    //        [_contentCellView addSubview:imageView];
//    //        imageView = nil;
//    //    }
//    if (_content.listImages.count) {
//        imageViewCtr = nil;
//        imageViewCtr = [[ImageViewController alloc] init];
//        imageViewCtr.content = _content;
//        imageViewCtr.navigationController = navigationController;
//        [_contentCellView addSubview:[imageViewCtr CreateImagesViewFromOrginY:cellHeight]];
//        
//        cellHeight += cImageHeight + CELL_MARGIN_BETWEEN_IMAGE;
//    }
//    //Clap+Commment
//    clapComment = nil;
//    clapComment = [self createClapCommentFromPoint:CGPointMake(CELL_CONTENT_MARGIN_LEFT , cellHeight + CELL_MARGIN_BETWEEN_IMAGE)];
//    cellHeight +=clapComment.frame.size.height + CELL_MARGIN_BETWEEN_IMAGE;
//    [_contentCellView addSubview:clapComment];
//    
//    cellHeight += CELL_MARGIN_BETWEEN_IMAGE;
//    _height = cellHeight + CELL_CONTENT_MARGIN_TOP;
//    _contentCellView.frame = CGRectMake(0.0, 0.0, CELL_CONTENT_WIDTH, cellHeight);
//    [self.contentView addSubview:_contentCellView ];
//    self.isDidDraw = YES;
//    _contentCellView.backgroundColor = [UIColor redColor];
//    return _contentCellView;
//}
//- (UIView*) createClapCommentFromPoint:(CGPoint) point
//{
//    UIView *botView = [[UIView alloc]initWithFrame:CGRectMake(point.x, point.y, CELL_CONTENT_WIDTH - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT, cCellHeight)];
//    UIView *leftBotView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, CELL_CONTENT_WIDTH - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT - cAvartaHeight * 02.0, cCellHeight)];
//    [leftBotView setBackgroundColor:[UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:219.0/255.0 alpha:1.0]];
//    leftBotView.layer.cornerRadius = 4;
//    //UIView *clapView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, CELL_CONTENT_WIDTH / 3.0, leftBotView.frame.size.height)];
//    UIButton *clapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    clapBtn.frame = CGRectMake(CELL_CONTENT_MARGIN_RIGHT + CELL_MARGIN_BETWEEN_IMAGE, CELL_CONTENT_MARGIN_RIGHT, cCellHeight * 1.5, cCellHeight - CELL_CONTENT_MARGIN_RIGHT * 2);
//    //disable - no need - requiment
//    //clapBtn.userInteractionEnabled = NO;
//    [clapBtn setImage:[UIImage imageNamed: _content.isClap ? @"clap.png" : @"clap.png"] forState:UIControlStateNormal];
//    [clapBtn addTarget:self action:@selector(clapButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UILabel *claplb = [[UILabel alloc]init ];
//    claplb.text = [NSString stringWithFormat:@"%d",_content.totalClap];
//    [claplb setFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE]];
//    CGSize constraint = CGSizeMake(clapBtn.frame.size.width , clapBtn.frame.size.height);
//    CGSize size = [claplb.text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeHeadTruncation];
//    claplb.frame = CGRectMake(clapBtn.frame.size.width + CELL_CONTENT_MARGIN_RIGHT + clapBtn.frame.origin.x, (leftBotView.frame.size.height - size.height)/2.0, size.width, size.height);
//    claplb.backgroundColor = [UIColor clearColor];
//    
//    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [commentBtn setTitle:[NSString stringWithFormat:@"%d %@", _content.totalComment, _content.totalComment > 1 ? @"comments" : @"comments"] forState:UIControlStateNormal];
//    [commentBtn.titleLabel setFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE]];
//    constraint = CGSizeMake(leftBotView.frame.size.width - claplb.frame.origin.x - claplb.frame.size.width - cAvartaHeight, cellHeight);
//    size = [commentBtn.titleLabel.text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeHeadTruncation];
//    commentBtn.frame = CGRectMake(claplb.frame.origin.x + claplb.frame.size.width + cAvartaHeight, claplb.frame.origin.y, size.width, size.height);
//    [commentBtn setBackgroundColor:[UIColor clearColor]];
//    [commentBtn setTitleColor:[UIColor colorWithRed:79.0/255 green:178.0/255 blue:187.0/255 alpha:1] forState:UIControlStateNormal];
//    [commentBtn addTarget:self action:@selector(commentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [leftBotView addSubview:clapBtn];
//    [leftBotView addSubview:claplb];
//    [leftBotView addSubview:commentBtn];
//    clapBtn = nil;
//    claplb = nil;
//    commentBtn = nil;
//    [botView addSubview:leftBotView];
//    leftBotView = nil;
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightButton.frame = CGRectMake(CELL_CONTENT_WIDTH - CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT - cCellHeight, 0.0, cCellHeight, cCellHeight);
//    [rightButton setImage:[UIImage imageNamed:@"comment_btn.png"] forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(plusButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    
//    [botView addSubview:rightButton];
//    rightButton  = nil;
//    
//    
//    
//    
//    return botView;
//}

//- (void)awakeFromNib {
//    NSLog(@"Wake from nib");
//    
//}

@end


///

/*
 // Add "more"
 UITextView *textStuff = [[UITextView alloc] init];
 textStuff.frame = CGRectMake(2.0, 200.0, 200.0, 40.0);
 textStuff.text = @"how are you today?";
 textStuff.textColor = [UIColor blackColor];
 
 UITextPosition *Pos2 = [textStuff positionFromPosition: textStuff.endOfDocument offset: nil];
 UITextPosition *Pos1 = [textStuff positionFromPosition: textStuff.endOfDocument offset: -3];
 
 UITextRange *range = [textStuff textRangeFromPosition:Pos1 toPosition:Pos2];
 
 CGRect result1 = [textStuff firstRectForRange:(UITextRange *)range ];
 
 NSLog(@"%f, %f", result1.origin.x, result1.origin.y);
 
 UIView *view1 = [[UIView alloc] initWithFrame:result1];
 view1.backgroundColor = [UIColor colorWithRed:0.2f green:0.5f blue:0.2f alpha:0.4f];
 [textStuff addSubview:view1];
 
 
 */
