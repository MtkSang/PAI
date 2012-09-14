//
//  NotificationsCellContent.m
//  Postadvert
//
//  Created by Mtk Ray on 6/26/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "NotificationsCellContent.h"

@implementation NotificationsCellContent
@synthesize userPostName = _userPostName;
@synthesize otherUsers = _otherUsers;
@synthesize userAvatar = _userAvatar;
@synthesize text = _text;
@synthesize timeNotifications = _timeNotifications;
@synthesize actionText = _actionText;
@synthesize toObject = _toObject;
@synthesize actionCode = _actionCode;

- (NSString*) getFullText
{
    NSString *str = [NSString stringWithString:_userPostName];
    if (_otherUsers) {
        switch (_otherUsers.count) {
            case 0:
                break;
            case 1:
                str = [str stringByAppendingString:[NSString stringWithFormat:@"and %@ ", [_otherUsers objectAtIndex:0]]];
                break;
            case 2:
                str = [str stringByAppendingString:[NSString stringWithFormat:@", %@ and %@ ", [_otherUsers objectAtIndex:0], [_otherUsers objectAtIndex:1]]];
                break;
            default:
                str = [str stringByAppendingString:[NSString stringWithFormat:@", %@ and %d others ", [_otherUsers objectAtIndex:0], _otherUsers.count - 1]];
                break;
        }
    }
    str = [str stringByAppendingString:_actionText];
    str = [str stringByAppendingString:[NSString stringWithFormat:@" %@: %@", _toObject, _text]];
    return str;
}
@end
