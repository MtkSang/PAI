//
//  LinkPreview.m
//  PostAdvert11
//
//  Created by Mtk Ray on 5/23/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import "LinkPreview.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>
#import "SBJson.h"
#import "BrowserViewController.h"
#import "ThumbnailViewController.h"
#import "NSData+Base64.h"

@implementation LinkPreview
 
@synthesize webView;
@synthesize title;
@synthesize discriptionView;
@synthesize buttonOnTitle;
@synthesize buttonOnWebView;
@synthesize linkInfo = _linkInfo;
- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:219.0/255.0 alpha:1.0];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame Link:(NSString *)urlStr Type:(LinkPreviewType) type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.linkInfo = [[NSDictionary alloc]init];
        // Initialization code
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCreateThumbnail) name:@"didCreateThumbnail" object:nil];
        //
        buttonOnTitle = [[UIButton alloc]init];
        buttonOnTitle.backgroundColor = [UIColor clearColor];
        linkType = type;
        urlString = urlStr;
        webView = [[UIWebView alloc]initWithFrame:CGRectMake(CELL_CONTENT_MARGIN_LEFT, CELL_MARGIN_BETWEEN_IMAGE, cYoutubeWidth, frame.size.height - ( 2 * CELL_MARGIN_BETWEEN_IMAGE))];
        webView.scrollView.contentSize = webView.frame.size ;
        webView.delegate = self;
        webView.scalesPageToFit = YES;
        webView.contentMode = UIViewContentModeScaleToFill;
        webView.autoresizesSubviews = YES;
        webView.scrollView.frame = webView.frame;
        webView.scrollView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:webView];
        
        title = [[UILabel alloc] initWithFrame:CGRectMake(webView.frame.origin.x + webView.frame.size.width + CELL_CONTENT_MARGIN_LEFT, webView.frame.origin.y, frame.size.width - webView.frame.size.width - webView.frame.origin.x -  CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT, FONT_TITLE_SIZE)];
        title.userInteractionEnabled = NO;

        title.textColor = [UIColor blackColor];
        title.numberOfLines = 0;
        [title setTextAlignment:UITextAlignmentLeft];
        title.backgroundColor = [UIColor clearColor];
        [title setFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE]];
        if (!showDiscription) {
            CGRect zframe = title.frame;
            zframe.size.height = frame.size.height - ( 2 * CELL_MARGIN_BETWEEN_IMAGE);
            title.frame = zframe;
        }
        [self addSubview:title];
        
        discriptionView = [[UITextView alloc] initWithFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y + title.frame.size.height + CELL_MARGIN_BETWEEN_IMAGE, title.frame.size.width, frame.size.height - (title.frame.origin.y + title.frame.size.height + CELL_MARGIN_BETWEEN_IMAGE + CELL_MARGIN_BETWEEN_IMAGE))];
        discriptionView.editable = NO;
        discriptionView.userInteractionEnabled = NO;
        discriptionView.backgroundColor = [UIColor clearColor];
        [self addSubview:discriptionView];
        
        //button on webview
        [self addSubview:buttonOnTitle];
        buttonOnWebView = [[UIButton alloc] initWithFrame:webView.frame];
        [buttonOnWebView addTarget:self action:@selector(openURLWhenTitleClicked:) forControlEvents:UIControlEventTouchUpInside];
        buttonOnWebView.backgroundColor = [UIColor clearColor];
        if (type == linkPreviewTypeYoutube ) {
            webView.scrollView.scrollEnabled = NO;
            CGFloat w = webView.frame.size.width;
            CGFloat h = webView.frame.size.height;
            NSString *embed = [NSString stringWithFormat:@"<html><head><meta name=\"viewport\""\
                               " content=\"initial-scale=1.0, user-scalable=no, width=%0.0f\"/></head><body "\
                               "style=\"background-color:transparent;margin-top:0px;margin-left:0px\"><div><object "\
                               "width=\"%0.0f\" height=\"%0.0f\"><param name=\"movie\" value=\"%@\" /><param name=\"wmode"\
                               "\"value=\"transparent\" /><param name=\"allowFullScreen\" value=\"true\" /><param"\
                               " name=\"quality\" value=\"high\" /><embed src=\"%@\" type=\"application/x-shockwave-flash"\
                               "\" allowfullscreen=\"true\" wmode=\"transparent\" width=\"%0.0f\" height=\"%0.0f\" />"\
                               "</object></div></body></html>", w, w, h, urlStr, urlStr, w, h];
            NSLog(@"Ember %@", embed);
            [webView loadHTMLString:embed baseURL:nil];
            NSString *youtubeID = [self getYoutubeIDFromUrl:urlStr];
            NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos/%@?v=2&alt=json-in-script&callback=youtubeFeedCallback", youtubeID] ];
            NSLog(@"url %@", [url absoluteString]);
            NSString *infoYoutubeVideo = [[NSString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
            infoYoutubeVideo = [infoYoutubeVideo stringByReplacingOccurrencesOfString:@"// API callback\nyoutubeFeedCallback(" withString:@""];
            infoYoutubeVideo = [infoYoutubeVideo stringByReplacingOccurrencesOfString:@");" withString:@""];
            NSLog(@"info %@ ", infoYoutubeVideo);
            NSMutableDictionary *returnDictionary = [infoYoutubeVideo JSONValue];
            NSLog(@"Dic %@", returnDictionary);

            NSDictionary *returnObject = [returnDictionary valueForKey:@"entry"];
            returnObject = [returnObject valueForKey:@"media$group"];
            returnObject = [returnObject valueForKey:@"media$title"];
            NSLog(@"media feed%@", [returnObject valueForKey:@"$t"]);
            title.text = [returnObject valueForKey:@"$t"];
            [title sizeToFit];
        }else {
            [buttonOnTitle addTarget:self action:@selector(openURLWhenTitleClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:buttonOnWebView];
            
            [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]]];
                       //[self addSubview:thumbnailView];
            
            
            
            ////////// test;
        }
        //[webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]]];
        
        self.layer.cornerRadius = 2.0;
        self.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:219.0/255.0 alpha:1.0];

    }
    return self;
}

- (void) loadContentWithFrame:(CGRect)frame Link:(NSString *)urlStr Type:(LinkPreviewType) type
{
    self.frame = frame;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    buttonOnTitle = [[UIButton alloc]init];
    NSLog(@"Button title: %@", buttonOnTitle);
    buttonOnTitle.backgroundColor = [UIColor clearColor];
    linkType = type;
    urlString = urlStr;
    //dispatch_async(dispatch_get_main_queue(), ^{
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(CELL_CONTENT_MARGIN_LEFT, CELL_MARGIN_BETWEEN_IMAGE, cYoutubeWidth, frame.size.height - ( 2 * CELL_MARGIN_BETWEEN_IMAGE))];
        NSLog(@"Webview Load : %@", webView);
    //});
    webView.scrollView.contentSize = webView.frame.size ;
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    webView.contentMode = UIViewContentModeScaleToFill;
    webView.autoresizesSubviews = YES;
    webView.scrollView.frame = webView.frame;
    webView.scrollView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:webView];
    
    //dispatch_async(dispatch_get_main_queue(), ^{
    title = [[UILabel alloc] initWithFrame:CGRectMake(webView.frame.origin.x + webView.frame.size.width + CELL_CONTENT_MARGIN_LEFT, webView.frame.origin.y, frame.size.width - webView.frame.size.width - webView.frame.origin.x -  CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT, FONT_TITLE_SIZE)];
    //});
    title.userInteractionEnabled = NO;
    
    title.textColor = [UIColor blackColor];
    title.numberOfLines = 0;
    [title setTextAlignment:UITextAlignmentLeft];
    title.backgroundColor = [UIColor clearColor];
    [title setFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE]];
    if (!showDiscription) {
        CGRect zframe = title.frame;
        zframe.size.height = frame.size.height - ( 2 * CELL_MARGIN_BETWEEN_IMAGE);
        title.frame = zframe;
    }
    [self addSubview:title];
    //dispatch_async(dispatch_get_main_queue(), ^{
    discriptionView = [[UITextView alloc] initWithFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y + title.frame.size.height + CELL_MARGIN_BETWEEN_IMAGE, title.frame.size.width, frame.size.height - (title.frame.origin.y + title.frame.size.height + CELL_MARGIN_BETWEEN_IMAGE + CELL_MARGIN_BETWEEN_IMAGE))];
    //});
    discriptionView.editable = NO;
    discriptionView.userInteractionEnabled = NO;
    discriptionView.backgroundColor = [UIColor clearColor];
    [self addSubview:discriptionView];
    
    //button on webview
    [self addSubview:buttonOnTitle];
    //dispatch_async(dispatch_get_main_queue(), ^{
    buttonOnWebView = [[UIButton alloc] initWithFrame:webView.frame];
    [buttonOnWebView addTarget:self action:@selector(openURLWhenTitleClicked:) forControlEvents:UIControlEventTouchUpInside];
    //});
    buttonOnWebView.backgroundColor = [UIColor clearColor];
    if (type == linkPreviewTypeYoutube ) {
        webView.scrollView.scrollEnabled = NO;
        CGFloat w = webView.frame.size.width;
        CGFloat h = webView.frame.size.height;
        NSString *embed = [NSString stringWithFormat:@"<html><head><meta name=\"viewport\""\
                           " content=\"initial-scale=1.0, user-scalable=no, width=%0.0f\"/></head><body "\
                           "style=\"background-color:transparent;margin-top:0px;margin-left:0px\"><div><object "\
                           "width=\"%0.0f\" height=\"%0.0f\"><param name=\"movie\" value=\"%@\" /><param name=\"wmode"\
                           "\"value=\"transparent\" /><param name=\"allowFullScreen\" value=\"true\" /><param"\
                           " name=\"quality\" value=\"high\" /><embed src=\"%@\" type=\"application/x-shockwave-flash"\
                           "\" allowfullscreen=\"true\" wmode=\"transparent\" width=\"%0.0f\" height=\"%0.0f\" />"\
                           "</object></div></body></html>", w, w, h, urlStr, urlStr, w, h];
        NSLog(@"Ember %@", embed);
        [webView loadHTMLString:embed baseURL:nil];
        NSString *youtubeID = [self getYoutubeIDFromUrl:urlStr];
        NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos/%@?v=2&alt=json-in-script&callback=youtubeFeedCallback", youtubeID] ];
        NSLog(@"url %@", [url absoluteString]);
        NSString *infoYoutubeVideo = [[NSString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        infoYoutubeVideo = [infoYoutubeVideo stringByReplacingOccurrencesOfString:@"// API callback\nyoutubeFeedCallback(" withString:@""];
        infoYoutubeVideo = [infoYoutubeVideo stringByReplacingOccurrencesOfString:@");" withString:@""];
        NSLog(@"info %@ ", infoYoutubeVideo);
        NSMutableDictionary *returnDictionary = [infoYoutubeVideo JSONValue];
        NSLog(@"Dic %@", returnDictionary);
        
        NSDictionary *returnObject = [returnDictionary valueForKey:@"entry"];
        returnObject = [returnObject valueForKey:@"media$group"];
        returnObject = [returnObject valueForKey:@"media$title"];
        NSLog(@"media feed%@", [returnObject valueForKey:@"$t"]);
        title.text = [returnObject valueForKey:@"$t"];
        [title sizeToFit];
    }else {
        [buttonOnTitle addTarget:self action:@selector(openURLWhenTitleClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonOnWebView];
        
        [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]]];
        //[self addSubview:thumbnailView];
        
        
        
        ////////// test;
    }
    //[webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]]];
    
    self.layer.cornerRadius = 2.0;
    self.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:219.0/255.0 alpha:1.0];
}

- (void) loadContentWithFrame:(CGRect)frame LinkInfo:(NSDictionary *)dict Type:(LinkPreviewType)type
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    self.frame = frame;
    [self performSelectorOnMainThread:@selector(loadNibFile) withObject:nil waitUntilDone:YES];
    
    linkType = type;
     NSString *urlStr = [dict objectForKey:@"url"];
    urlString = [NSData stringDecodeFromBase64String:urlStr];
    NSLog(@"Dict %@",dict);
    if (type == linkPreviewTypeYoutube ) {
        webView.scrollView.scrollEnabled = NO;
        CGFloat w = webView.frame.size.width;
        CGFloat h = webView.frame.size.height;
        NSString *embed = [NSString stringWithFormat:@"<html><head><meta name=\"viewport\""\
                           " content=\"initial-scale=1.0, user-scalable=no, width=%0.0f\"/></head><body "\
                           "style=\"background-color:transparent;margin-top:0px;margin-left:0px\"><div><object "\
                           "width=\"%0.0f\" height=\"%0.0f\"><param name=\"movie\" value=\"%@\" /><param name=\"wmode"\
                           "\"value=\"transparent\" /><param name=\"allowFullScreen\" value=\"true\" /><param"\
                           " name=\"quality\" value=\"high\" /><embed src=\"%@\" type=\"application/x-shockwave-flash"\
                           "\" allowfullscreen=\"true\" wmode=\"transparent\" width=\"%0.0f\" height=\"%0.0f\" />"\
                           "</object></div></body></html>", w, w, h, urlString, urlString, w, h];
        NSLog(@"Ember %@", embed);
        webView.userInteractionEnabled = YES;
        buttonOnWebView.hidden = YES;
        [webView loadHTMLString:embed baseURL:nil];
        [buttonOnTitle addTarget:self action:@selector(buttonPlayClicked:) forControlEvents:UIControlEventTouchUpInside];
    }else {
        [buttonOnWebView addTarget:self action:@selector(openURLWhenTitleClicked:) forControlEvents:UIControlEventTouchUpInside];
        [buttonOnTitle addTarget:self action:@selector(openURLWhenTitleClicked:) forControlEvents:UIControlEventTouchUpInside];
        [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]]];
    }
    
    //Title
    NSString *titleStr = [dict objectForKey:@"title"];
    NSLog(@"Title %@", titleStr);
    title.text = [NSData stringDecodeFromBase64String:titleStr];
    NSString *descriptionStr = [dict objectForKey:@"description"];
    NSLog(@"Description %@",[NSData stringDecodeFromBase64String:descriptionStr] );
    description.text = [NSData stringDecodeFromBase64String:descriptionStr];
    //Set posittion for title & description
    CGSize constraint, size;
    constraint = CGSizeMake(title.frame.size.width ,self.frame.size.height - (2*CELL_MARGIN_BETWEEN_IMAGE));
    size = [title.text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    frame = title.frame;
    frame.size = size;
    frame.origin.y = CELL_MARGIN_BETWEEN_IMAGE;
    title.frame = frame;
    frame = description.frame;
    frame.origin.y = title.frame.origin.y + size.height;
    frame.size.height = self.frame.size.height - frame.origin.y - CELL_MARGIN_BETWEEN_IMAGE;
    description.frame = frame;
    buttonOnTitle.frame = title.frame;
    self.layer.cornerRadius = 2.0;
    self.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:219.0/255.0 alpha:1.0];
}

- (void) reDrawWithFrame:(CGRect)frame
{
//    title.frame = CGRectMake(webView.frame.origin.x + webView.frame.size.width + CELL_CONTENT_MARGIN_LEFT, webView.frame.origin.y, frame.size.width - webView.frame.size.width - webView.frame.origin.x -  CELL_CONTENT_MARGIN_LEFT - CELL_CONTENT_MARGIN_RIGHT, FONT_TITLE_SIZE);
//    [title sizeToFit];
//    buttonOnTitle.frame = title.frame;
    //Set posittion for title & description
    CGSize constraint, size;
    constraint = CGSizeMake(title.frame.size.width ,self.frame.size.height - (2*CELL_MARGIN_BETWEEN_IMAGE));
    size = [title.text sizeWithFont:[UIFont fontWithName:FONT_NAME size:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    frame = title.frame;
    frame.size = size;
    frame.origin.y = CELL_MARGIN_BETWEEN_IMAGE;
    title.frame = frame;
    buttonOnTitle.frame = title.frame;
    frame = description.frame;
    frame.origin.y = title.frame.origin.y + size.height;
    frame.size.height = self.frame.size.height - frame.origin.y - CELL_MARGIN_BETWEEN_IMAGE;
    description.frame = frame;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)_webView
{
    if (linkType == linkPreviewTypeWebSite) {
         NSLog(@"Webview-LinkPreview DidLoad Type=Website");
        [title setText:[_webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
        [title sizeToFit];
        //title.text = [webView.request.URL absoluteString];
        
    }else {
        NSLog(@"Webview-LinkPreview DidLoad Type=Youtube");
        [buttonOnTitle addTarget:self action:@selector(buttonPlayClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
}

#pragma mark - implement

- (NSString*) getYoutubeIDFromUrl:(NSString*) url
{
    NSString *videoID = [url stringByReplacingOccurrencesOfString:@"http://m." withString:@""];
    videoID = [videoID stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    videoID = [videoID stringByReplacingOccurrencesOfString:@"www." withString:@""];
    videoID = [videoID stringByReplacingOccurrencesOfString:@"youtube.com/watch?v=" withString:@""];
    videoID = [videoID stringByReplacingOccurrencesOfString:@"youtube.com/v/" withString:@""];
    videoID = [videoID stringByReplacingOccurrencesOfString:@"youtu.be/" withString:@""]; 
    return [[videoID componentsSeparatedByString:@"&"] objectAtIndex:0];
    videoID = nil;
}
- (UIButton *)findButtonInView:(UIView *)view {
	UIButton *button = nil;
	
	if ([view isMemberOfClass:[UIButton class]]) {
		return (UIButton *)view;
	}
	
	if (view.subviews && [view.subviews count] > 0) {
		for (UIView *subview in view.subviews) {
			button = [self findButtonInView:subview];
			if (button) return button;
		}
	}
	
	return button;
}

- (IBAction)buttonPlayClicked:(id)sender
{
    UIButton *b = [self findButtonInView:webView];
    if (b == nil) {
        [self openURLWhenTitleClicked:title];
    }else {
        [b sendActionsForControlEvents:UIControlEventTouchUpInside];
        b = nil;
    }
	
}

- (IBAction)openURLWhenTitleClicked:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (void) didCreateThumbnail
{
    thumbnailView = [[UIImageView alloc] initWithImage:thumbnail.thumbnail];
    CGRect frame = webView.frame;
    frame.origin.x = 150;
    thumbnailView.frame = frame;
}

-(void) loadNibFile
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LinkPreview" owner:self options:nil];
    UIView *mainView = [topLevelObjects objectAtIndex:0];
    topLevelObjects = nil;
    webView = (UIWebView*)[mainView viewWithTag:1];
    buttonOnWebView = (UIButton*)[mainView viewWithTag:2];
    title = (UILabel*)[mainView viewWithTag:3];
    buttonOnTitle = (UIButton*)[mainView viewWithTag:4];
    description = (UILabel*)[mainView viewWithTag:5];
    CGRect frame = self.frame;
    NSLog(@"LinkPreview %@", self);
    frame.origin.x = 0;
    frame.origin.y = 0;
    mainView.frame = frame;
    [mainView setAutoresizesSubviews:YES];
    mainView.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:219.0/255.0 alpha:1.0];
    [mainView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
    [self addSubview:mainView];
}
@end

/*
temp
 
 NSString *youtubeID = [dict objectForKey:@"video_id"];
 NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos/%@?v=2&alt=json-in-script&callback=youtubeFeedCallback", youtubeID] ];
 NSLog(@"url %@", [url absoluteString]);
 NSString *infoYoutubeVideo = [[NSString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
 infoYoutubeVideo = [infoYoutubeVideo stringByReplacingOccurrencesOfString:@"// API callback\nyoutubeFeedCallback(" withString:@""];
 infoYoutubeVideo = [infoYoutubeVideo stringByReplacingOccurrencesOfString:@");" withString:@""];
 NSLog(@"info %@ ", infoYoutubeVideo);
 NSMutableDictionary *returnDictionary = [infoYoutubeVideo JSONValue];
 NSLog(@"Dic %@", returnDictionary);
 */
