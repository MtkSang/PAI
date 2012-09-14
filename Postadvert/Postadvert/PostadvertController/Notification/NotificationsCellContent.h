//
//  NotificationsCellContent.h
//  Postadvert
//
//  Created by Mtk Ray on 6/26/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationsCellContent : NSObject
@property (nonatomic, strong)   NSString *userPostName;
@property (nonatomic, strong)   NSMutableArray *otherUsers;
@property (nonatomic, strong)   NSString *actionText;
@property (nonatomic, strong)   NSString *toObject;
@property (nonatomic, strong)   UIImage *userAvatar;
@property (nonatomic, strong)   NSString *text;
@property (nonatomic, strong)   NSDate *timeNotifications;
@property (nonatomic)           NSInteger actionCode;

- (NSString*) getFullText;
@end
