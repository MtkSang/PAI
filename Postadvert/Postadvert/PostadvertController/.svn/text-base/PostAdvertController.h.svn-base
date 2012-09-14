
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
//#import "AQRecorder.h"




@interface ImageCachedModel : NSObject {
    
}
@property(nonatomic, strong) NSData             *imageData;
@property(nonatomic, strong) NSString              *imageUrl;
@end


@class CredentialInfo;


@interface PostAdvertController : NSObject <NSXMLParserDelegate,
CLLocationManagerDelegate>
{
    float                       progressInit;
    NSString                    *resultStr;
    BOOL                        isResultTag;
    BOOL                        isContentMsgs;
    
    CredentialInfo              *myProfile;
    CredentialInfo              *friend01;
    
    NSString                    *functionName;
    NSMutableData               *receivedData;
    
    NSMutableArray              *contactList;
    NSMutableArray              *searchList;
    
    
    int                         idxMsg;
    NSMutableArray              *emotionIconsList;
    NSString                    *strEmoticonsID;
    NSString                    *strReplacementText;
    NSString                    *strImageURL;
    NSString                    *strDisplayName;
    
    
    NSMutableArray              *listContact2Items;
    NSMutableArray              *listContact2;
    NSString                    *strContactID;
    NSString                    *strContactTypeID;
    NSString                    *strAvatarURL;
    NSString                    *strContactType;
    NSString                    *strContactName;
    NSString                    *strCreateDT;
    NSString                    *strStatus;
    NSString                    *strMiles;
    
    NSMutableArray              *listGift;
    NSString                    *strGiftID;
    NSString                    *strGiftName;
    NSString                    *strGiftImgURL;    
    int                         parseResult;
    
    NSMutableArray              *listFilters;
    //    NSString                    *strElemID;
    //    NSString                    *strElemName;
    NSString                    *strOptID;
    NSString                    *strOptName;
    
    CLLocationManager           *locationManager;
    CLLocation                  *currentLocation;
    
    NSTimer                     *timer4Location;
    NSTimer                     *timer4UpdLstCont2;
}

@property (nonatomic, assign) float                     progressInit;
@property (nonatomic, strong) NSTimer                   *timer4UpdLstCont2;

- (void)initPalUpControl;
- (void)initLocation;
@property (nonatomic, strong) CLLocation                *currentLocation;
@property (nonatomic, strong) CLLocationManager         *locationManager;
@property (nonatomic, strong) NSTimer                   *timer4Location;

- (void)onTickUpdate:(NSTimer *)timer;
- (void)initUpdateListContact2;

@property(nonatomic, strong) NSMutableArray      *listGift;
@property(nonatomic, strong) NSString              *strGiftID;
@property(nonatomic, strong) NSString              *strGiftName;
@property(nonatomic, strong) NSString              *strGiftImgURL;
- (void)initListGift;

@property(nonatomic, strong) NSMutableArray      *emotionIconsList;
@property(nonatomic, strong) NSString              *strEmoticonsID;
@property(nonatomic, strong) NSString              *strReplacementText;
@property(nonatomic, strong) NSString              *strImageURL;
@property(nonatomic, strong) NSString              *strDisplayName;


@property(nonatomic, strong) NSMutableArray      *listContact2Items;
@property(nonatomic, strong) NSMutableArray      *listContact2;
@property(nonatomic, strong) NSString              *strContactID;
@property(nonatomic, strong) NSString              *strContactTypeID;
@property(nonatomic, strong) NSString              *strAvatarURL;
@property(nonatomic, strong) NSString              *strContactType;
@property(nonatomic, strong) NSString              *strContactName;
@property(nonatomic, strong) NSString              *strCreateDT;
@property(nonatomic, strong) NSString              *strStatus;
@property(nonatomic, strong) NSString              *strMiles;


@property(nonatomic, strong) NSString            *resultStr;
@property(nonatomic, strong) NSString            *functionName;
@property(nonatomic, strong) CredentialInfo      *myProfile;
@property(nonatomic, strong) CredentialInfo      *friend01;
@property(nonatomic, strong) NSMutableDictionary      *lstCachedImages;

@property(nonatomic, strong) NSMutableArray      *lstContactAlreadyGetContactURL;


@property(nonatomic, strong) NSMutableArray      *listFilters;
//@property(nonatomic, strong) NSString              *strElemID;
//@property(nonatomic, strong) NSString              *strElemName;
@property(nonatomic, strong) NSString              *strOptID;
@property(nonatomic, strong) NSString              *strOptName;


@property BOOL isFiendView;
@property BOOL canBackFromFiendView;

- (NSMutableArray*) getEmotionIconsList;
- (NSString*)getUserNamePU;
- (long)getRegistrationID;
- (void)setFriendInfo:(CredentialInfo *) credential :(long) idx;


- (long)getFriendRegistrationID;
- (NSString*)getFriendName;
- (NSString*)getFriendName;
- (NSString*)getFriendInterested;
- (NSString*)getFriendAvatarURL;
- (void)getDefaultUser;
- (void)storeDefaultUser;


////// Web services function
- (long)registrationCreate:(CredentialInfo *) credential;
- (BOOL)checkUsername:(NSString*) userName;
- (NSMutableArray*)listInterests;
- (int)registrationAddInterest :(long) interestTypeID;
- (NSMutableArray*) listContacts:(long) idRegistraion;
//- (NSMutableArray*) listContacts2:(long)LatitudeLocation :(long)LongitudeLocation;
- (long)registrationLogin:(NSString *)userName :(NSString *)password;
- (int)registrationSignIn;
- (int)registrationSignOut;
- (int)registrationChangeStatus:(long) newRegistrationStatusTypeID;
- (NSMutableArray*) listRegistrationStatuses;
- (int)addContact:(long) toClientID :(NSString*) txtMessage;
//acceptContact 			
//DeclineContact 			
- (int)changeContactType:(long) toClientID :(int)contactTypeID;

- (int)RemoveContact: (long) toClientID :(NSString*) txtMessage;
- (int)blockContact: (long) toClientID :(NSString*) txtMessage;
- (int)giftContact:(long) toClientID :(long) giftTypeID  :(NSString*) txtMessage;
//==============ListGift=======
- (void)listGifts;
- (NSMutableArray*)getListGift;
//=============================
- (int)registrationChangePassword:(NSString*) txtMessage;
- (int)registrationRemoveInterest:(long) interestTypeID;
- (int)registrationRemoveAllInterests;
- (int)registrationUpdateLocation;
- (int)registrationUpdateAvatar:(NSString*) newAvatarURL;
- (int)inviteFacebookFriends:(NSString*) username :(NSString*) password :(NSString*) message;
- (int)inviteHotmailFriends:(NSString*) username :(NSString*) password :(NSString*) message;
- (int)inviteYahooFriends:(NSString*) username :(NSString*) password :(NSString*) message;
- (int)inviteGmailFriends:(NSString*) username :(NSString*) password :(NSString*) message;
- (int)inviteAOLFriends:(NSString*) username :(NSString*) password :(NSString*) message;
- (long)sendChatMessage:(long) toId :(NSString*) msg;
- (NSMutableArray*) OutputMessages;
- (int)CronProcessWorkQueue;
- (NSMutableArray*) getProfile;
//////////////////////////////////////////
- (int)loginETAccount;
- (int)loginFBAccount;
- (int)loginGoogleAccount;
- (int)registrationResetPassword;
- (NSMutableArray*)get50RandomOnlineAvatars;
- (NSMutableArray*)listRelationshipType;
- (long)uploadSoundClip:(long)toRegID :(NSString*) strVoice;
- (long)sendPhoto:(long)toRegID :(NSString*) strImage;
- (NSMutableArray*)getUserProfilePhotos;
- (long)getRandomOnlineUserID;
- (NSString*)uploadData:(NSData*)data fileName:(NSString*)strFileName;
//=================ListEmoticons=====
- (void)initListEmoticons;
- (void)listEmoticons;
/* ListEmoticons
 UploadPhotoToProfile */
- (NSMutableArray*)searchContactByMask:(NSString*) searchStr;
- (int)usersAvailable;

- (int)listContacts2;
- (long)shareContact:(long)toRegistrationID :(int)contactID;
- (long)shareMusic:(long)toRegistrationID :(NSString*)path :(NSString*)title;
- (void)listProfileElements;

- (void)parserDataReturn;

- (void) getFullProfile;
- (int) EditProfile;
- (NSString*) getValueOfTag: (NSString*)tag fromString:(NSString *)source withSubTag:(BOOL) flag;
- (NSString*) getProperty:(NSString*)property fromString:(NSString *)source;
- (NSDate*) dateFromString: (NSString*) source;
- (int) removeProfileElementWithOption: (NSString*)option;
- (int) addProfileElementWithOption: (NSString*)option;
- (NSString*) getProfileElementOptionNamebyId: (int) index;

- (BOOL) isConnectToWeb;
- (int) likes:(long) toRegistrationID;
- (long)sendCalendarEvent:(long)toRegistrationID :(NSString*)evtTilte :(long) startTime :(long) endTime;
- (long)sendLocation:(long)toRegistrationID :(float)longitude :(float) latitude;
- (long)forwardMessages:(long)toRegistrationID :(long)msgId;
- (void) showAlertWithMessage: (NSString*) msg andTitle: (NSString*) title;

#pragma mark -
#pragma Mtk

//- (UIView*) drawPostAdvertTopMenu;
//- (UIView*) drawPostAdvertMainMenu;


@end
