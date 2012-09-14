//
//  LinkViewController.m
//  PostAdvert11
//
//  Created by Mtk Ray on 5/24/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import "LinkViewController.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>
#import "SBJson.h"
#import "BrowserViewController.h"
#import "ThumbnailViewController.h"


@interface LinkViewController ()

@end

@implementation LinkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (id)initWithFrame:(CGRect)frame Link:(NSString *)urlStr Type:(LinkPreviewType) type
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.view.frame = frame;
    // Initialization code
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCreateThumbnail) name:@"didCreateThumbnail" object:nil];
    //
    buttonOnTitle = [[UIButton alloc]init];
    buttonOnTitle.backgroundColor = [UIColor clearColor];
    linkType = type;
    urlString = urlStr;
    webView.frame = CGRectMake(CELL_CONTENT_MARGIN_LEFT, CELL_MARGIN_BETWEEN_IMAGE, cYoutubeWidth, frame.size.height - ( 2 * CELL_MARGIN_BETWEEN_IMAGE));
    //[self.view addSubview:webView];
    
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
    //[self.view addSubview:title];
    
    discriptionView = [[UITextView alloc] initWithFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y + title.frame.size.height + CELL_MARGIN_BETWEEN_IMAGE, title.frame.size.width, frame.size.height - (title.frame.origin.y + title.frame.size.height + CELL_MARGIN_BETWEEN_IMAGE + CELL_MARGIN_BETWEEN_IMAGE))];
    discriptionView.editable = NO;
    discriptionView.userInteractionEnabled = NO;
    discriptionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:discriptionView];
    if (type == linkPreviewTypeYoutube ) {
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
        [webView loadHTMLString:embed baseURL:nil];
        NSString *youtubeID = [self getYoutubeIDFromUrl:urlStr];
        NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos/%@?v=2&alt=json-in-script&callback=youtubeFeedCallback", youtubeID] ];
        NSLog(@"url %@", [url absoluteString]);
        NSString *infoYoutubeVideo = [[NSString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"Info %@",infoYoutubeVideo);
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
        [self.view addSubview:buttonOnTitle];
        buttonOnWebView = [[UIButton alloc] initWithFrame:webView.frame];
        [buttonOnWebView addTarget:self action:@selector(openURLWhenTitleClicked:) forControlEvents:UIControlEventTouchUpInside];
        buttonOnWebView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:buttonOnWebView];
        
        [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]]];
        //[self addSubview:thumbnailView];
        
        
        
        ////////// test;
    }
    //[webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]]];
    
    self.view.layer.cornerRadius = 2.0;
    self.view.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:219.0/255.0 alpha:1.0];
    
    }
    return self;
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
        [self.view addSubview:buttonOnTitle];
        [buttonOnTitle addTarget:self action:@selector(buttonPlayClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [self.view sendSubviewToBack:title];
    buttonOnTitle.frame = title.frame;
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
    if (b) {
        [b sendActionsForControlEvents:UIControlEventTouchUpInside];
    }else {
        //[webView addSubview:buttonOnWebView];
        //[buttonOnTitle addTarget:self action:@selector(openURLWhenTitleClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self openURLWhenTitleClicked:self];
    }
	
    b = nil;
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
@end
