//
//  UIMessageCell.m
//  Postadvert
//
//  Created by Mtk Ray on 6/18/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "UIMessageCell.h"
#import "MessageCellContent.h"

@implementation UIMessageCell

@synthesize userPostName = _userPostName;
@synthesize postTime = _postTime;
@synthesize message = _message;
@synthesize imageView;
@synthesize iconSendView = _iconSendView;
@synthesize imageViewAttachment = _imageViewAttachment;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"UIMessageCell" owner:self options:nil];
    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
    self = [topLevelObjects objectAtIndex:0];
    topLevelObjects = nil;
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

@end
