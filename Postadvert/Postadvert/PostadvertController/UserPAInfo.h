//
//  UserPAInfo.h
//  Postadvert
//
//  Created by Mtk Ray on 6/5/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "CredentialInfo.h"

@interface UserPAInfo : CredentialInfo

//- (id) initWithEmail:(NSString*) emailAddr password:(NSString*) pwd;
//- (id) initWithEmail:(NSString*) emailAddr userName:(NSString*) usrName password:(NSString*) pwd;
+(UserPAInfo*)sharedUserPAInfo;
@end
