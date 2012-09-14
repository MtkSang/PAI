//
//  ThumbnailViewController.m
//  PostAdvert11
//
//  Created by Mtk Ray on 5/24/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import "ThumbnailViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ThumbnailViewController ()

@end

@implementation ThumbnailViewController
@synthesize webView = _webView;
@synthesize thumbnail = _thumbnail;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id) initWithURLString:(NSString *)urlString
{
    self = [super init];
    if (self) {
        url = urlString;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]]];
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


#pragma mark - WebView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
       return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)nwebView
{
    
}


- (void)webViewDidFinishLoad:(UIWebView *)nwebView
{
    UIGraphicsBeginImageContext(nwebView.bounds.size);
    [nwebView.layer renderInContext:UIGraphicsGetCurrentContext()];
    _thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didCreateThumbnail" object:nil];
}


- (void)webView:(UIWebView *)nwebView didFailLoadWithError:(NSError *)error
{   
   
}

@end
