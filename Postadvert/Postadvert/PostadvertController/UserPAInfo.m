//
//  UserPAInfo.m
//  Postadvert
//
//  Created by Mtk Ray on 6/5/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "UserPAInfo.h"

@implementation UserPAInfo
static UserPAInfo* _sharedMySingleton = nil;

+(UserPAInfo*)sharedUserPAInfo
{
	@synchronized([UserPAInfo class])
	{
		if (!_sharedMySingleton)
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Wunused-value"
            [[self alloc] init];
            #pragma clang diagnostic pop
		return _sharedMySingleton;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([UserPAInfo class])
	{
		NSAssert(_sharedMySingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedMySingleton = [super alloc];
		return _sharedMySingleton;
	}
    
	return nil;
}

-(id)init {
	self = [super init];
	if (self != nil) {
		// initialize stuff here
	}
    
	return self;
}
@end
