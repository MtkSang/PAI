//
//  PostViewController.m
//  Postadvert
//
//  Created by Mtk Ray on 6/8/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "PostViewController.h"
#import "UserPAInfo.h"
#import "ImageViewController.h"
#import "PostCellContent.h"
#import "UIPlaceHolderTextView.h"
#import "ImageViewController.h"
#import "UIPostCell.h"
#import "SBJson.h"
#import "AppDelegate.h"
#import "ListImages.h"
#import "UIImage+Resize.h"

#define MaxImageCanSave  2

@interface PostViewController ()
- (void) updatePostBtnState;
-(IBAction)takePhoto:(id)sender ;
-(IBAction)chooseFromLibrary:(id)sender;
- (UIImage *)fixOrientation:(UIImage*)image;
- (void) setActivityLocation;
@end

@implementation PostViewController
@synthesize activity = _activity, avatarImg = _avatarImg, phTextView = _phTextView, scrollView = _scrollView, btnPost = _btnPost, thumbnailView = _thumbnailView, botView = _botView, photoButton = _photoButton;
@synthesize popoverCtr = _popoverCtr;
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
    // Do any additional setup after loading the view from its nib
    self.navigationController.navigationBarHidden = YES;
    self.activity.hidden = YES;
    [self.phTextView becomeFirstResponder];
    self.avatarImg.image = [UserPAInfo sharedUserPAInfo].imgAvatar;
    [self.photoButton setImage:[UIImage imageNamed:@"icon_capture_photo_sel.png"] forState:UIControlStateSelected];
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(makeKeyboardGoAway:)];
    [self.thumbnailView addGestureRecognizer:tapGesture];
    tapGesture = nil;
    
    //delete old file
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathToDocuments=[paths objectAtIndex:0];
    for (int i =1; i <= 50; i++) {
        [[NSFileManager defaultManager]removeItemAtPath:[NSString stringWithFormat:@"%@/newPost%d.jpg", pathToDocuments, i] error:nil];
    }
    paths = nil;
    pathToDocuments = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    imagePicker = nil;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self setModalInPopover:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"Rotated %@", self);
    [self setActivityLocation];
}

//- (void) dealloc
//{
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - toolbar

-(IBAction)backButtinClicked{
    [self dismissModalViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"plusSuccessNoPost" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newPostWithOutData" object:nil];
    
}

-(IBAction)postButtinClicked{
    
    [[NSUserDefaults standardUserDefaults] setObject:self.phTextView.text forKey:@"_text_NewPost"];
    [[NSUserDefaults standardUserDefaults] setInteger:totalImage forKey:@"_totalImage_NewPost"];
    self.navigationController.navigationBarHidden = NO;
    [self dismissModalViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"plusSuccessWithPost" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newPostWithData" object:nil];
}


#pragma mark - UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    if (self.popoverCtr) {
        [self.popoverCtr dismissPopoverAnimated:YES];
    }
    [self setActivityLocation];
    self.activity.hidden = NO;
    [self.activity startAnimating ];
    totalImage += 1;
    self.btnPost.enabled = NO;
    self.botView.userInteractionEnabled = NO;
    //UIImage *image = [self normalizedImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    //[info setValue:nil forKey:@"UIImagePickerControllerOriginalImage"];
    [NSThread detachNewThreadSelector:@selector(SaveAndShowImage:) toTarget:self withObject: info];
    //picker = nil;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{ //cancel
	
	[picker dismissModalViewControllerAnimated:YES];
    if (self.popoverCtr) {
        [self.popoverCtr dismissPopoverAnimated:YES];
    }

	
}


#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
//    if ([textView.text isEqualToString:@""]) {
//        self.btnPost.enabled = NO;
//    }else {
//        self.btnPost.enabled = YES;
//    }
    [self updatePostBtnState];
}

#pragma mark - implement
- (void) updatePostBtnState
{
    BOOL canEnable = NO;
    if (totalImage) {
        canEnable = YES;
    }
    NSString *text = [_phTextView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if ([_phTextView.text isEqualToString:@""] || [text isEqualToString:@""]) {
        //canEnable = NO;
    }else {
        canEnable = YES;
    }
    text = nil;
    
    //Update post btn
    if (canEnable) {
        _btnPost.enabled = YES;
    }else {
        _btnPost.enabled = NO;
    }
}

- (IBAction)makeKeyboardGoAway:(id)sender
{
    [self.phTextView resignFirstResponder];
}

-(IBAction)takePhoto:(id)sender 
{
    // Set source to the camera
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera]) 
    {
        // Set source to the Photo Library
        imagePicker.sourceType =UIImagePickerControllerSourceTypeCamera;
        
    }
    
    // Show image picker
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *pathToDocuments=[paths objectAtIndex:0];
//    NSError *error;
//    [[NSFileManager defaultManager]removeItemAtPath:[NSString stringWithFormat:@"%@/newPost%d.jpg", pathToDocuments, totalImage + 1] error:&error];
//    if (error) {
//        NSLog(@"Error %@", error);
//    }
//    paths = nil;
//    pathToDocuments = nil;
	[self presentModalViewController:imagePicker animated:YES];
}
-(IBAction)chooseFromLibrary:(id)sender 
{
    // Set source to the camera
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary]) 
    {
        // Set source to the Photo Library
        imagePicker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    
    // Show image picker
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if (! self.popoverCtr) {
           self.popoverCtr = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        }
        UIButton *btnSender = (UIButton*)sender;
        CGRect rect = [btnSender convertRect:btnSender.bounds toView:self.view];
        [self.popoverCtr presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        [self presentModalViewController:imagePicker animated:YES];
    }
	
}

- (UIImage *)fixOrientation:(UIImage*)image
{
    
    // No-op if the orientation is already correct
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    image = nil;
    return img;
}

- (UIImage *)normalizedImage:(UIImage*)image {
    if (image == nil) {
        return nil;
    }
    if (image.imageOrientation == UIImageOrientationUp) return image; 
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void) showThumbnail:(UIImage*)image
{
    CGRect frame = self.thumbnailView.frame;
    frame.size.width = (totalImage) * (cImageWidth + CELL_MARGIN_BETWEEN_IMAGE) - CELL_MARGIN_BETWEEN_IMAGE;
    frame.size.height = cImageHeight;

    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.frame = CGRectMake( ( (cImageWidth + CELL_MARGIN_BETWEEN_IMAGE)* (totalImage - 1)), 0.0, cImageWidth, cImageHeight);
    imgView.backgroundColor =[UIColor clearColor];
    [self.thumbnailView addSubview:imgView];
    self.thumbnailView.backgroundColor = [UIColor clearColor];
    imgView = nil;
    frame.origin.x = (self.view.frame.size.width / 2) - frame.size.width/2 ;
    if (frame.origin.x < 0) {
        frame.origin.x = 0;
    }
    self.thumbnailView.frame = frame;
    
}
- (void) SaveAndShowImage:(NSDictionary *)info
{
    UIImage *image = [self normalizedImage: [info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    //image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationUp];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathToDocuments=[paths objectAtIndex:0];
    [self showThumbnail:[image resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(cImageWidth, cImageHeight) interpolationQuality:0]];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 01.0f);
     NSLog(@"Path %@ %d", pathToDocuments, totalImage);
    [imageData writeToFile:[NSString stringWithFormat:@"%@/newPost%d.jpg", pathToDocuments, totalImage] atomically:YES];
//    NSFileManager *fileManager = [[NSFileManager alloc]init];
//    NSMutableData *data = [NSMutableData dataWithData:UIImageJPEGRepresentation(image, 1)];
//    if (![fileManager createFileAtPath:path contents:data attributes:nil]) {
//        Log(@"error: create file at path");
//    }
    NSLog(@"Path %@ %d", pathToDocuments, totalImage);
    pathToDocuments= nil;
    paths = nil;
    imageData = nil;
    image = nil;
    
    
    self.btnPost.enabled = YES;
    self.botView.userInteractionEnabled = YES;
    [self.activity stopAnimating];
    self.activity.hidden = YES;
}

- (void) setActivityLocation
{
    CGRect frame = self.activity.frame;
    frame.origin.x = self.botView.center.x - frame.size.width/2.0;
    self.activity.frame = frame;
}
@end
