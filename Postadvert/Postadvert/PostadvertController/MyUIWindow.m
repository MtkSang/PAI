//
//  MyUIWindow.m
//  PostAdvert11
//
//  Created by Ray Mtk on 18/4/12.
//  Copyright (c) 2012 ray@futureworkz.com. All rights reserved.
//

#import "MyUIWindow.h"
#import "SideBarViewController.h"

@interface MyUIWindow()
- (NSInteger) speedForNavigationBar;
@end

@implementation MyUIWindow

@synthesize sideBarState;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        isTouchBegan = NO;
        sideBarState = 0;
        shouldSendEvent = YES;
        direction = 0;
        touchCount = 0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sideBarUpdate) name:@"sideBarUpdate" object:nil];
        lastLocations = [[NSMutableArray alloc]initWithCapacity:cMaxStoreLocation];
        lastTimes = [[NSMutableArray alloc]initWithCapacity:cMaxStoreLocation];
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
- (void) sideBarUpdate
{
    NSNumber *x = [[NSUserDefaults standardUserDefaults] objectForKey:@"sideBarUpdate"];
    sideBarState = [x integerValue];
    NSLog(@"Update %d", sideBarState);
}

- (void)sendEvent:(UIEvent*)event {
    [super sendEvent:event];
    return;
    if (event.type != UIEventTypeTouches 
        || sideBarState == 100 
        || sideBarState == 101
        || sideBarState == 102) 
    {
        [super sendEvent:event];
        return;
    }
    //NSSet *allTouches = [event allTouches];
    UITouch *touch = [[event allTouches] anyObject];
    NSNumber *num = nil;
    UIView * view = nil;
    NSInteger speed = 0;
    if (sideBarState == 1) {
        NSLog(@"Main Menu");
        switch (touch.phase) {
            case UITouchPhaseBegan:
                isTouchBegan = YES;
                isTouchMoved = NO;
                isTouchEnd = NO;
                shouldSendEvent = YES;
                touchBegan = nil;
                touchBegan = touch;
                direction = 0;
                touchCount = 1;
                beganEvent = event;
                startTouchPoint = [touch locationInView:nil];
                [lastTimes removeAllObjects];
                [lastLocations removeAllObjects];
                [lastLocations insertObject:[NSValue valueWithCGPoint:[touch locationInView:nil]] atIndex:0];
                [lastTimes insertObject:[NSNumber numberWithDouble:[touch timestamp]] atIndex:0];
                NSLog(@"direction BG %d", direction);
                break;
                
            case UITouchPhaseMoved:
                NSLog(@"direction %d", direction);
//                if (startTouchPoint.y <= cNavigationBarHeight) {//Top
//                    
//                    
//                    
//                    break;
//                }
//                
//                if (startTouchPoint.x < cMaxLeftView) { //Left
//                    
//                }else {
//                    
//                    
//                }
//                break;
                
                //Check for Move on Table / Navigation / -> choose Move down or Move Left/right
                if (startTouchPoint.y < cStatusAndNavBar || startTouchPoint.x >= cMaxLeftView) {
                    direction = 1;
                }
                if (direction == 0 || direction == 3) {
                    double detX = fabs([touch locationInView:nil].x - [touch previousLocationInView:nil].x );
                    double detY = fabs([touch locationInView:nil].y - [touch previousLocationInView:nil].y );
                    if(detX > detY){
                        direction = 1; //SideBar Move
                    }
                    else {
                        direction = -1;//UITableView Move
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"enableScrollTable" object:nil];
                    }
                }
                if (direction == -1) {
                    shouldSendEvent = YES;
                    break;
                }
                
                isTouchMoved = YES;
                if (lastTimes.count >= cMaxStoreLocation) {
                    [lastTimes removeLastObject];
                    [lastLocations removeLastObject];
                }
                [lastLocations insertObject:[NSValue valueWithCGPoint:[touch locationInView:nil]] atIndex:0];
                [lastTimes insertObject:[NSNumber numberWithDouble:[touch timestamp]] atIndex:0];
                NSLog(@"Rerererer");
                num = [NSNumber numberWithFloat:[touch locationInView:nil].x - [touch previousLocationInView:nil].x];
                [[NSUserDefaults standardUserDefaults] setObject:num forKey:@"PointX"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"navMove" object:nil];
                break;
                
            case UITouchPhaseEnded:
                isTouchEnd = YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"enableScrollTable" object:nil];
                if (startTouchPoint.x >= cMaxLeftView && startTouchPoint.y <= cNavigationBarHeight && isTouchMoved == NO) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"showhidesidebar" object:nil];
                    break;
                }
                if (direction == -1 || direction == 0 ) {
                    if (startTouchPoint.x >= cMaxLeftView) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"showhidesidebar" object:nil];
                    }

                    shouldSendEvent = YES;
                    break;
                }
                if (lastTimes.count >= cMaxStoreLocation) {
                    [lastTimes removeLastObject];
                    [lastLocations removeLastObject];
                }
                [lastLocations insertObject:[NSValue valueWithCGPoint:[touch locationInView:nil]] atIndex:0];
                [lastTimes insertObject:[NSNumber numberWithDouble:[touch timestamp]] atIndex:0];
                //Speed
                speed = [self speedForNavigationBar];
                if (speed != 0) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"speedForNavigationBar" object:nil];
                    shouldSendEvent = NO;
                    break;
                }
                
                if (startTouchPoint.x >= cMaxLeftView) {//Touch on Right View
                    if (isTouchMoved) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"navEndMove" object:nil];
                    }else {
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"showhidesidebar" object:nil];
                    }
                    shouldSendEvent =NO;
                } else {
                    if (isTouchMoved) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"navEndMove" object:nil];
                        shouldSendEvent = NO;
                    }else {
                        //[super.nextResponder touchesEnded:allTouches withEvent:event];	
                        shouldSendEvent = YES;
                        
                        if ([view isKindOfClass:[UINavigationBar class]] || [view isKindOfClass:[UINavigationItem class]]) {
                            NSLog(@"Show ==YES & NAV");
                            shouldSendEvent = YES;
                        } else {
                            NSLog(@"Show ==YES & NO");
                            if (isTouchMoved) {
                                shouldSendEvent = NO;
                            }else {
                                if ([touchBegan locationInView:nil].x >= cMaxLeftView) {
                                    shouldSendEvent = YES;
                                } else {
                                    shouldSendEvent = NO;
                                }
                            }
                            shouldSendEvent = NO;   
                        }   
                    }
                }                
                break;
            default:
                if (direction == 0) {
                        //direction = 3;
                }
                touchCount ++;
                //shouldSendEvent = YES;
                [super sendEvent:event];
                [lastTimes removeAllObjects];
                [lastLocations removeAllObjects];
                break;
        }
        
    } else if(sideBarState == 0)////////////////////// state full detail
    {
        NSLog(@"Full Detail");
                if (event.type == UIEventTypeTouches){
                    UITouch *touch = [[event allTouches] anyObject];
                    if (touch.phase == UITouchPhaseBegan) {
                        isTouchBegan = YES;
                        isTouchMoved = NO;
                        isTouchEnd = NO;
                        shouldSendEvent = YES;
                        touchBegan = nil;
                        touchBegan = touch;
                        direction = 0;
                        touchCount = 1;
                        beganEvent = event;
                        startTouchPoint = [touch locationInView:nil];
                        [lastTimes removeAllObjects];
                        [lastLocations removeAllObjects];
                        [lastLocations insertObject:[NSValue valueWithCGPoint:[touch locationInView:nil]] atIndex:0];
                        [lastTimes insertObject:[NSNumber numberWithDouble:[touch timestamp]] atIndex:0];
                        NSLog(@"direction %d", direction);

                    }
                    if (startTouchPoint.y > cNavigationBarHeight) {
                        shouldSendEvent = YES;
                    }else {
                        if (touch.phase == UITouchPhaseMoved) {
                            isTouchMoved = YES;
                            if (lastTimes.count >= cMaxStoreLocation) {
                                [lastTimes removeLastObject];
                                [lastLocations removeLastObject];
                            }
                            [lastLocations insertObject:[NSValue valueWithCGPoint:[touch locationInView:nil]] atIndex:0];
                            [lastTimes insertObject:[NSNumber numberWithDouble:[touch timestamp]] atIndex:0];
                            NSLog(@"Rerererer");
                            num = [NSNumber numberWithFloat:[touch locationInView:nil].x - [touch previousLocationInView:nil].x];
                            [[NSUserDefaults standardUserDefaults] setObject:num forKey:@"PointX"];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"navMove" object:nil];
                        }
                        
                        if (touch.phase == UITouchPhaseEnded) {
                            isTouchEnd = YES;
                            if (startTouchPoint.x < self.frame.size.width - cMaxLeftView && startTouchPoint.y <= cStatusAndNavBar && isTouchMoved == NO) {
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"showhidesidebar" object:nil];
                                
                            }else {
                                if (lastTimes.count >= cMaxStoreLocation) {
                                    [lastTimes removeLastObject];
                                    [lastLocations removeLastObject];
                                }
                                [lastLocations insertObject:[NSValue valueWithCGPoint:[touch locationInView:nil]] atIndex:0];
                                [lastTimes insertObject:[NSNumber numberWithDouble:[touch timestamp]] atIndex:0];
                                //Speed
                                speed = [self speedForNavigationBar];
                                if (speed != 0) {
                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"speedForNavigationBar" object:nil];
                                    shouldSendEvent = NO;
                                }else {
                                    if (isTouchMoved) {
                                        [[NSNotificationCenter defaultCenter] postNotificationName:@"navEndMove" object:nil];
                                        shouldSendEvent = NO;
                                    }else {
                                        shouldSendEvent = YES;
                                    }
                                }   
                            }
                        }
                        if ( touch.phase == UITouchPhaseStationary) {
                            shouldSendEvent = YES;
                            [lastTimes removeAllObjects];
                            [lastLocations removeAllObjects];
                        }
                    }
                }
    }
    if (direction == 0) {
        //[self performSelector:@selector(mySendEvent:)withObject:event afterDelay:1.0];
        [super sendEvent:event];
        return;
    }
    if (isTouchEnd) {
        if (!shouldSendEvent) {
                   }
    }
    if (direction == 1) {
        //just SideBar
        [super touchesBegan:[event allTouches] withEvent:event];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"disableScrollTable" object:nil];
        [super sendEvent:event];
        
        return;
    }
    
    if (shouldSendEvent || sideBarState == 3 || sideBarState == 4) {
        [super sendEvent:event];
        //NSLog(@"SendEvent: %@",event);
    }
}

- (void) mySendEvent:(UIEvent*) event
{
    NSLog(@"Delay");
    NSLog(@"begin T %@", beginEvent);
    if (shouldSendEvent) {
        NSLog(@"send");
        NSLog(@"Event: %@", beganEvent.description);
        [super sendEvent:beganEvent];
    }
}

- (NSInteger) speedForNavigationBar{
    NSLog(@"%@", lastLocations.description);
    if (lastLocations.count < cMaxStoreLocation) {
        return 0;
    }
    
    NSValue *startValue = [lastLocations objectAtIndex:0];
    NSValue *endValue = [lastLocations lastObject];
    CGPoint startPoint = [startValue CGPointValue];
    CGPoint endPoint = [endValue CGPointValue];
    NSNumber *startNum = [lastTimes objectAtIndex:0];
    NSNumber *endNum = [lastTimes lastObject];
    
    double s = startPoint.x - endPoint.x;
    double time = [startNum doubleValue] - [endNum doubleValue];
    
    double speed = s / time;
    NSNumber *num = nil;
    if (fabs(speed) >= cMinSpeedPermit) {
        if (speed > 0) {
            num = [NSNumber numberWithInteger:1];
            [[NSUserDefaults standardUserDefaults] setObject:num forKey:@"speedForNavigationBar"];
            return 1;
        }
        num = [NSNumber numberWithInteger:-1];
        [[NSUserDefaults standardUserDefaults] setObject:num forKey:@"speedForNavigationBar"];
        return -1 ;
    }
    num = nil;
    return 0;
}

//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"Touch Began");
//}
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"Touch Move");
//}
@end
