//
//  UICommentsCell.m
//  Postadvert
//
//  Created by Mtk Ray on 6/5/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "UICommentsCell.h"

#import "Constants.h"
#import "CommentsCellContent.h"
#import <QuartzCore/QuartzCore.h>

#define inset 20.0;
@interface UICommentsCell()

@end

@implementation UICommentsCell
{
    UIImageView *avarta;
    UILabel *userName;
    UILabel *label;
    UITextView *textView;
    UITextField *textField;
    UIView *_contentCellView;
    Float32 cellHeight;
}
@synthesize content = _content;
@synthesize height = _height;
@synthesize navigationController;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//- (void) setFrame:(CGRect)frame
//{
//    frame.origin.x += inset;
//    frame.size.width -= 2 * inset;
//    [super setFrame:frame];
//}
#pragma mark - textView delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}

#pragma mark - congfig cell

- (void) updateCellWithContent:(CommentsCellContent *)content
{
    if (content != nil) {
        _content = nil;
        _content = content;
    }
    [self drawContent];
}

-(UIView*) drawContent
{
    if (!_content) {
        return nil;
    }
    CGSize constraint;
    CGSize size;
    cellHeight = 0.0;
    if (!_contentCellView) {
        _contentCellView = [[UIView alloc]init];
    }
    if (_content.userAvatar == nil) {
        _content.userAvatar = [UIImage imageNamed:@"avatar.png"];
    }
    avarta = [[UIImageView alloc]initWithImage:_content.userAvatar ];
    avarta.contentMode = UIViewContentModeScaleAspectFill;
    avarta.frame = CGRectMake(CELL_CONTENT_MARGIN_LEFT, CELL_CONTENT_MARGIN_TOP, cAvartaComments, cAvartaComments);
    [_contentCellView addSubview:avarta];
    
    userName = nil;
    constraint = CGSizeMake(CELL_COMMENTS_WIDTH - (avarta.frame.size.width + avarta.frame.origin.x + CELL_CONTENT_MARGIN_LEFT + CELL_CONTENT_MARGIN_RIGHT), self.frame.size.height);
    size = [_content.userPostName sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    userName = [[UILabel alloc]initWithFrame:CGRectMake( avarta.frame.size.width + avarta.frame.origin.x + CELL_CONTENT_MARGIN_LEFT, CELL_CONTENT_MARGIN_TOP, size.width , size.height)];
    userName.text = _content.userPostName;
    [userName setFont:[UIFont fontWithName: FONT_NAME size:FONT_SIZE]];
    [userName setTextColor:[UIColor colorWithRed:79.0/255 green:178.0/255 blue:187.0/255 alpha:1]];
    //userName.backgroundColor = self.backgroundColor;
    [_contentCellView addSubview:userName];
    cellHeight += userName.frame.origin.y + size.height;
    
    constraint = CGSizeMake(CELL_COMMENTS_WIDTH - (userName.frame.origin.x + CELL_CONTENT_MARGIN_RIGHT), 20000.0f);
    size = [_content.text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    textView = nil;
    textView = [[UITextView alloc]initWithFrame:CGRectMake(userName.frame.origin.x, cellHeight, CELL_COMMENTS_WIDTH - (userName.frame.origin.x + CELL_CONTENT_MARGIN_RIGHT), size.height)];
    //textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [textView setFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE]];
    [textView setText:_content.text];
    textView.editable = NO;
    textView.scrollEnabled = NO;
    textView.backgroundColor = self.backgroundColor;
    //Testing
    //textView.dataDetectorTypes = UIDataDetectorTypeAll;
    CGRect frame = textView.frame;
    frame.size.height = textView.contentSize.height + 10.0 + textView.contentInset.top + textView.contentInset.bottom;
    textView.frame = frame;
    NSLog(@"%f %f", textView.frame.origin.x ,userName.frame.origin.x);
    [_contentCellView addSubview:textView];
    cellHeight += textView.frame.size.height ;
    cellHeight += CELL_MARGIN_BETWEEN_IMAGE;
    _height = cellHeight;
    _contentCellView.frame = CGRectMake(0.0, 0.0, CELL_COMMENTS_WIDTH, cellHeight);
    [self.contentView addSubview:_contentCellView ];
    return _contentCellView;
}
@end

