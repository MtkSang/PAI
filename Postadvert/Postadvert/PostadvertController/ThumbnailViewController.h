//
//  ThumbnailViewController.h
//  PostAdvert11
//
//  Created by Mtk Ray on 5/24/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThumbnailViewController : UIViewController<UIWebViewDelegate>
{
    NSString *url;
}
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) UIImage *thumbnail;
-(id) initWithURLString:(NSString *)urlString;
@end
