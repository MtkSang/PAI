//
//  MyImageViewController.h
//  Postadvert
//
//  Created by Mtk Ray on 6/1/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    MyImageViewControllerSourceTypeImage,
    MyImageViewControllerSourceTypeUrl,
    MyImageViewControllerSourceTypeNormal
} MyImageViewControllerSourceType;

@interface MyImageViewController : UIViewController <UIScrollViewDelegate>
{
    UIImage *image;
    NSString *url;
    BOOL isDoubleTap;
    MyImageViewControllerSourceType sourceType;
}
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIScrollView *imageScrollView;
@property (nonatomic) BOOL isZooming;
- (id)initWithImage:(UIImage*)_image;
- (id)initWithURL:(NSString*)_url;
- (void) normalSize;
@end
