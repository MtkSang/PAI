//
//  UINotificationsCell.h
//  Postadvert
//
//  Created by Mtk Ray on 6/26/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NotificationsCellContent;
@interface UINotificationsCell : UITableViewCell<UIWebViewDelegate>

{
    IBOutlet UILabel *postTime;
    IBOutlet UIWebView *webView;
    IBOutlet UIImageView *imageAvatar;
}
@property (nonatomic, weak) IBOutlet UILabel *postTime;
@property (nonatomic, weak) IBOutlet UIImageView *imageAvatar;
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic)                CGFloat cellHeight;

- (CGFloat) setCellContent:(NotificationsCellContent*) content;
@end
