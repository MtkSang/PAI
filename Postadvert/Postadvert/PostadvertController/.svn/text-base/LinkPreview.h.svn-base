//
//  LinkPreview.h
//  PostAdvert11
//
//  Created by Mtk Ray on 5/23/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    linkPreviewTypeWebSite,
    linkPreviewTypeYoutube
} LinkPreviewType;
@class BrowserViewController;
@class ThumbnailViewController;
@interface LinkPreview : UIView< UIWebViewDelegate>
{
    LinkPreviewType linkType;
    NSString *urlString;
    BOOL showDiscription;
    UIWebView *webView;
    UILabel *title;
    UILabel *description;
    UITextView *discriptionView;
    UIButton *buttonOnTitle;
    UIButton *buttonOnWebView;
    UIImageView *thumbnailView;
    BrowserViewController *br;
    ThumbnailViewController *thumbnail;
    //NSDictionary *linkInfo;
}
@property (nonatomic, strong)  UIWebView *webView;;
@property (nonatomic, strong)  UILabel *title;
@property (nonatomic, strong)  UITextView *discriptionView;
@property (nonatomic, strong)  UIButton *buttonOnTitle;
@property (nonatomic, strong)  UIButton *buttonOnWebView;
@property (nonatomic, strong) NSDictionary *linkInfo;
- (id)initWithFrame:(CGRect)frame Link:(NSString *)urlStr Type:(LinkPreviewType) type;
- (void) loadContentWithFrame:(CGRect)frame Link:(NSString *)urlStr Type:(LinkPreviewType) type;
- (void) loadContentWithFrame:(CGRect)frame LinkInfo:(NSDictionary *)dict Type:(LinkPreviewType) type;
- (void) reDrawWithFrame:(CGRect)frame;


@end
