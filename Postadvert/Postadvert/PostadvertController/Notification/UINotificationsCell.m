//
//  UINotificationsCell.m
//  Postadvert
//
//  Created by Mtk Ray on 6/26/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "UINotificationsCell.h"
#import "NotificationsCellContent.h"

@implementation UINotificationsCell

@synthesize postTime = _postTime;
@synthesize imageAvatar = _imageAvatar;
@synthesize webView = _webView;
@synthesize cellHeight = _cellHeight;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"UINotificationsCell" owner:self options:nil];
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

- (CGFloat) setCellContent:(NotificationsCellContent*) content
{
    //Set avatar
    _imageAvatar.image = content.userAvatar;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM:dd:yy"];
    NSString *theDate = [dateFormat stringFromDate:content.timeNotifications ];
    [self.postTime setText:theDate];
    NSString *str = [NSString stringWithFormat:@"<font color='#0222e4'>%@</font> ", content.userPostName];
    if (content.otherUsers) {
        switch (content.otherUsers.count) {
            case 0:
                break;
            case 1:
                str = [str stringByAppendingString:[NSString stringWithFormat:@"and <font color='#0222e4'>%@</font> ", [content.otherUsers objectAtIndex:0]]];
                break;
            case 2:
                str = [str stringByAppendingString:[NSString stringWithFormat:@", <font color='#0222e4'>%@</font> and <font color='#0222e4'>%@</font> ", [content.otherUsers objectAtIndex:0], [content.otherUsers objectAtIndex:1]]];
                break;
            default:
                str = [str stringByAppendingString:[NSString stringWithFormat:@", <font color='#0222e4'>%@</font> and <font color='#0222e4'>%d</font> others ", [content.otherUsers objectAtIndex:0], content.otherUsers.count - 1]];
                break;
        }
    }
    str = [str stringByAppendingString:content.actionText];
    str = [str stringByAppendingString:[NSString stringWithFormat:@"<font color='#0222e4'> %@</font>: %@", content.toObject, content.text]];
    
    NSString *htmlString =  [NSString stringWithFormat:@"<html><body><p>%@</p></body></html>", str];
    [_webView loadHTMLString:htmlString baseURL:nil];
    
    str = nil;
    htmlString = nil;
    return 50.0;
}

#pragma mark - UIwebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)nwebView
{
    NSLog(@"WebView DidLoad");
}
@end
