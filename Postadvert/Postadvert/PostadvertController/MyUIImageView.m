//
//  MyUIImageView.m
//  PostAdvert11
//
//  Created by Mtk Ray on 5/25/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import "MyUIImageView.h"

@implementation MyUIImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.multipleTouchEnabled = YES;
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundColor = [UIColor blackColor];
        //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        //[self addGestureRecognizer:tap];

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

- (BOOL) canBecomeFirstResponder
{
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"EnlargeImage touch begin ");
    isMovied = NO;
    UITouch *touch = [[event allTouches] anyObject];
    postStartMoveX = [touch locationInView:nil].x;
    touch = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateSwipe" object:nil];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    isMovied = YES;
    UITouch *touch = [[event allTouches] anyObject];
    NSNumber *num = [NSNumber numberWithFloat:[touch locationInView:nil].x - [touch previousLocationInView:nil].x];
    [[NSUserDefaults standardUserDefaults] setObject:num forKey:@"PointX"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EnlargeImageListenMoving" object:nil];
    touch = nil;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self performSelector:@selector(updateSwipe) withObject:nil afterDelay:0.5];
    if (isMovied) {
        UITouch *touch = [[event allTouches] anyObject];
        Float32 postEndMoveX = [touch locationInView:nil].x;
        touch = nil;
        Float32 distance = postEndMoveX - postStartMoveX;
        NSNumber *num = [NSNumber numberWithFloat:distance];
        [[NSUserDefaults standardUserDefaults] setObject:num forKey:@"PointX"];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"EnlargeImageListenMoveEnd" object:nil];
    }else {
        NSLog(@"End Touch without moving");
    }
    
    //Get all the touches.
    NSSet *allTouches = [event allTouches];
    
    //Number of touches on the screen
    switch ([allTouches count])
    {
        case 1:
        {
            //Get the first touch.
            UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
            
            switch([touch tapCount])
            {
                case 1://Single tap
                    NSLog(@"Single Tap");
                    numberOfTap = 1;
                    //[self performSelector:@selector(tapAction:) withObject:nil afterDelay:0.35];
                    //[[NSNotificationCenter defaultCenter] postNotificationName:@"SingleTapImageView" object:nil];
                    break;
                case 2://Double tap.
                    numberOfTap = 2;
                    NSLog(@"double Tap");                    
                    break;
            }
        } 
            break;
        case 2 :
            NSLog(@"touch count 2 ");
            break;
    }
    
}
-(void) tapAction:(id)sender
{
    NSLog(@"Tap");
    if (numberOfTap == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SingleTapImageView" object:nil];
    }
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ( [gestureRecognizer isMemberOfClass:[UITapGestureRecognizer class]] ) {
        // Return NO for views that don't support Taps
        return YES;
    } else if ( [gestureRecognizer isMemberOfClass:[UISwipeGestureRecognizer class]] ) {
        // Return NO for views that don't support Swipes
        return NO;
    }
    
    return YES;
}
- (void) updateSwipe
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateSwipe" object:nil];
}
@end
