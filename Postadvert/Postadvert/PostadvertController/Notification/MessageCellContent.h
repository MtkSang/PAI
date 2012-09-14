//
//  MessageCellContent.h
//  Postadvert
//
//  Created by Mtk Ray on 6/18/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCellContent : NSObject
@property (nonatomic, strong)   NSString *userPostName;
@property (nonatomic, strong)   UIImage *userAvatar;
@property (nonatomic, strong)   NSString *text;
@property (nonatomic, strong)   NSDate *datePost;
@property (nonatomic, strong)   UIImage *imageAttachment;
//@property (nonatomic, strong)   NSTimer *timePost;
@end
