//
//  PostadvertControllerV2.h
//  Postadvert
//
//  Created by Mtk Ray on 7/11/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Reachability;
@interface PostadvertControllerV2 : NSObject
{
    Reachability* internetReachable;
    Reachability* hostReachable;
    BOOL isChecked;
    
}
@property (nonatomic) BOOL internetActive;
@property (nonatomic) BOOL hostActive;
+(PostadvertControllerV2*)sharedPostadvertController;
- (void) checkNetworkStatus:(NSNotification *)notice;
- (BOOL) isConnectToWeb;
- (long) registrationLogin:(NSString *)userName :(NSString *)password;
-(void) testFunction;
- (id) getPostsWithWall:(NSString*) wallId from:(NSString*) start andCount:(NSString*) count WithUserID:(NSString*)userID;
-(id) getCountPostsWithWallId:(NSString*) wallId;
-(id) getFriendsOfUserID:(NSString*)userID from:(NSString*)start count:(NSString*)count;
-(NSInteger) countFriendOfUser:(NSString*)userID;
- (id) getContinuePostsWithWall:(NSString*) wallId PostId:(NSString*)postId WithUserID:(NSString*)userID Type:(NSString*) type andCount:(NSString*) count;
-(id) getStatusUpdateWithUserID:(NSString*)userId start:(NSString*)start limit:(NSString*)limit index:(NSString*)index row_id:(NSString*)row;
@end
