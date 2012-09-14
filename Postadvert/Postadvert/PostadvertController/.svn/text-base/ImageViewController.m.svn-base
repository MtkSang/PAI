//
//  ImageViewController.m
//  PostAdvert11
//
//  Created by Mtk Ray on 5/24/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import "ImageViewController.h"
#import "PostCellContent.h"
#import "Constants.h"
#import "EnlargeImageViewController.h"
#import "EnlargeImageViewControllerV2.h"
#import "UIImage+Resize.h"
@interface ImageViewController ()

@end

@implementation ImageViewController

@synthesize navigationController;
@synthesize content;
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
    NSLog(@"ImageViewController: viewDidUnload");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}

#pragma mark - implement

- (UIView*) CreateImagesViewFromOrginY:(float) y
{
    totalScreen = content.listImages.count / 3 ;
    if (totalScreen * 3 < content.listImages.count) {
        totalScreen +=1;
    }
    current = 1;
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0.0 , y, (cImageWidth + CELL_MARGIN_BETWEEN_IMAGE) * content.listImages.count,cImageHeight + 2 * CELL_MARGIN_BETWEEN_IMAGE )];
    self.view.userInteractionEnabled = YES;
    UISwipeGestureRecognizer * recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(myRightAction)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];
    
    UISwipeGestureRecognizer * recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(myLeftAction)];
    [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:recognizer2];
    
    
    CGRect frame = CGRectMake(CELL_CONTENT_MARGIN_LEFT, CELL_MARGIN_BETWEEN_IMAGE, cImageWidth, cImageHeight);
    NSInteger tag = 0;
    for (UIImage *image in content.listImages) {
        tag += 1;// = index -1;
        [self.view addSubview:[self imageViewFromImage:image withFrame:frame tag:tag]];
        frame.origin.x += cImageWidth + CELL_MARGIN_BETWEEN_IMAGE;
        
    }
    recognizer = nil;
    recognizer2 = nil;
    
    return self.view;
}
- (void) addImage:(UIImage*) img
{
    [content.listImages addObject:img];
    totalScreen = content.listImages.count / 3 ;
    if (totalScreen * 3 < content.listImages.count) {
        totalScreen +=1;
    }
    CGRect frame = CGRectMake(self.view.frame.size.width - CELL_CONTENT_MARGIN_LEFT, CELL_MARGIN_BETWEEN_IMAGE, cImageWidth, cImageHeight);
    NSInteger tag = [content.listImages count];
    [self.view addSubview:[self imageViewFromImage:img withFrame:frame tag:tag]];
    
    frame = self.view.frame;
    frame.size.width = (cImageWidth + CELL_MARGIN_BETWEEN_IMAGE) * content.listImages.count;
    self.view.frame = frame;
    
}

-(UIImageView*) imageViewFromImage:(UIImage*)image withFrame:(CGRect)frame tag:(NSInteger) tag
{
    //image = [image thumbnailImage:20 transparentBorder:0 cornerRadius:0 interpolationQuality:4];
    image = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(cImageWidth, cImageHeight) interpolationQuality:0];
    UIImageView *myImageView = [[UIImageView alloc]initWithImage:image];
    myImageView.frame = frame;
    myImageView.userInteractionEnabled =YES;
    myImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UISwipeGestureRecognizer * recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(myRightAction)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [myImageView addGestureRecognizer:recognizer];

    UISwipeGestureRecognizer * recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(myLeftAction)];
    [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [myImageView addGestureRecognizer:recognizer2];


    // Add tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findOutTheTag:)];
    myImageView.tag = tag;
    NSLog(@"Tag %d", tag);
    [myImageView addGestureRecognizer:tap];
    return myImageView;
}

- (void) myRightAction
{
    CGRect frame = self.view.frame;
    
    if ( current == 1) {
        return;
    }
    frame.origin.x += (3 * (cImageWidth + CELL_MARGIN_BETWEEN_IMAGE));
    current -= 1;
    [UIView setAnimationDuration:0.99];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
    [UIView beginAnimations:@"imageSwipe" context:(__bridge void *)self.view];
    self.view.frame = frame;
    [UIView commitAnimations];
}
- (void) myLeftAction
{
    NSLog(@"Left");
    CGRect frame = self.view.frame;
    frame.origin.x -= (3 * (cImageWidth + CELL_MARGIN_BETWEEN_IMAGE));
    NSLog(@"Current %d", current);
    if (current == (totalScreen )) {
        return;
    }
    current += 1;
    [UIView setAnimationDuration:0.99];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector( animationDidStop:finished:context: )];
    [UIView beginAnimations:@"imageSwipe" context:(__bridge void *)self.view];
    self.view.frame = frame;
    [UIView commitAnimations];

}
- (void)findOutTheTag:(id)sender {
    NSInteger tag = ((UIGestureRecognizer *)sender).view.tag  ;    
    NSLog(@"Tap %d", tag);
    EnlargeImageViewControllerV2 *enlargelView = [[EnlargeImageViewControllerV2 alloc]init];
    //enlargelView.content = content;
    //enlargelView.index = tag - 1;
    [self.navigationController presentModalViewController:enlargelView animated:YES];
    enlargelView = nil;
}

- (UIImage *)normalizedImage:(UIImage*)image {
    if (image == nil) {
        return nil;
    }
    if (image.imageOrientation == UIImageOrientationUp) return image; 
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    image = nil;
    return normalizedImage;
}

@end
