//
//  LinkViewController.h
//  PostAdvert11
//
//  Created by Mtk Ray on 5/24/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LinkPreview.h"
@class BrowserViewController;
@class ThumbnailViewController;
@interface LinkViewController : UIViewController< UIWebViewDelegate>
{
    LinkPreviewType linkType;
    NSString *urlString;
    BOOL showDiscription;
    IBOutlet UIWebView *webView;
    IBOutlet UILabel *title;
    UITextView *discriptionView;
    UIButton *buttonOnTitle;
    UIButton *buttonOnWebView;
    UIImageView *thumbnailView;
    BrowserViewController *br;
    ThumbnailViewController *thumbnail;
}
- (id)initWithFrame:(CGRect)frame Link:(NSString *)urlStr Type:(LinkPreviewType) type;
@end