//
//  CredentialInfo.h
//  PalUp
//
//  Created by Elisoft on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CredentialInfo : NSObject 
{
    long                        registrationID;
    NSString                    *avatarUrl;
    NSString                    *fullName; 
    NSString                    *email; 
    NSString                    *phone; 
    NSString                    *zipcode;
    NSString                    *location;
    NSString                    *gender; 
    NSDate                      *birthday; 
    int                         age;
    NSString                    *timeZone; 
    NSString                    *usernamePU; 
    NSString                    *passwordPU;
    NSString                    *usernameFB; 
    NSString                    *passwordFB;
    NSString                    *usernameET; 
    NSString                    *passwordET;
    NSString                    *build;
    
    NSString                    *smoking;
    NSString                    *drinking;
    NSString                    *education;
    NSString                    *smokingTypeID;
    NSString                    *drinkingTypeID;
    NSString                    *educationTypeID;
    NSString                    *book;
    NSString                    *appearance;
    NSString                    *appearanceTypeID;
    NSString                    *children;
    NSString                    *childrenTypeID;
    NSString                    *music;
    NSString                    *musicTypeIDs;
    NSString                    *movies;
    NSString                    *moviesTypeIDs;
    
    NSString                    *userCountryPA;
    UIImage                     *imgAvatar;
}

@property(nonatomic, assign) long                      registrationID; 
@property(nonatomic, copy) NSString                    *avatarUrl;
@property(nonatomic, retain) UIImage                     *imgAvatar;
@property(nonatomic, copy) NSString                    *fullName;
@property(nonatomic, copy) NSString                    *build;
@property(nonatomic, copy) NSString                    *email; 
@property(nonatomic, copy) NSString                    *phone; 
@property(nonatomic, copy) NSString                    *zipcode;
@property(nonatomic, copy) NSString                    *location;
@property(nonatomic, copy) NSString                    *gender;
@property(nonatomic, copy) NSDate                      *birthday; 
@property(nonatomic, copy) NSString                    *timeZone;
@property(nonatomic, copy) NSString                    *usernamePU;
@property(nonatomic, copy) NSString                    *passwordPU;
@property(nonatomic, copy) NSString                    *usernameFB;
@property(nonatomic, copy) NSString                    *passwordFB;
@property(nonatomic, copy) NSString                    *usernameET;
@property(nonatomic, copy) NSString                    *passwordET;
@property(nonatomic, copy) NSString                    *firstName;
@property(nonatomic, copy) NSString                    *interest;
@property(nonatomic, copy) NSString                    *interestTypeID;
@property(nonatomic, copy) NSString                    *registrationStatusTypeID;
@property(nonatomic, copy) NSString                    *statusText;
@property(nonatomic, copy) NSString                    *statusMessage;
@property(nonatomic, copy) NSString                    *relationshipTypeID;
@property(nonatomic, copy) NSString                    *relationshipText;
@property(nonatomic, copy) NSString                    *smoking;
@property(nonatomic, copy) NSString                    *drinking;
@property(nonatomic, copy) NSString                    *education;
@property(nonatomic, copy) NSString                    *smokingTypeID;
@property(nonatomic, copy) NSString                    *drinkingTypeID;
@property(nonatomic, copy) NSString                    *educationTypeID;
@property(nonatomic, copy) NSString                    *book;
@property(nonatomic, copy) NSString                    *appearance;
@property(nonatomic, copy) NSString                    *appearanceTypeID;
@property(nonatomic, copy) NSString                    *children;
@property(nonatomic, copy) NSString                    *childrenTypeID;
@property(nonatomic, copy) NSString                    *music;
@property(nonatomic, copy) NSString                    *musicTypeIDs;
@property(nonatomic, copy) NSString                    *movies;
@property(nonatomic, copy) NSString                    *moviesTypeIDs;
@property(nonatomic, copy) NSString                    *userCountryPA;

- (id) initWithEmail:(NSString*) emailAddr password:(NSString*) pwd;
- (id) initWithEmail:(NSString*) emailAddr userName:(NSString*) usrName password:(NSString*) pwd;

- (long) getRegistrationId;
- (NSString*) getUserNamePU;
- (NSString*) getPwdNamePU;
- (int)getAge;

@end
