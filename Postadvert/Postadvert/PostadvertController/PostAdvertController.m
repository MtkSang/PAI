

#import "PostAdvertController.h"
#import "CredentialInfo.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Constants.h"

@implementation ImageCachedModel

@synthesize  imageUrl, imageData;


@end

@implementation PostAdvertController

@synthesize progressInit, timer4UpdLstCont2;
@synthesize listContact2, listContact2Items, strContactID, strContactTypeID;
@synthesize strAvatarURL, strContactType, strContactName, strStatus, strMiles, strCreateDT;

@synthesize emotionIconsList, strEmoticonsID, strReplacementText, strImageURL, strDisplayName;
@synthesize listGift, strGiftID, strGiftName, strGiftImgURL;

@synthesize functionName;
@synthesize resultStr;
@synthesize myProfile;
@synthesize friend01;
@synthesize lstCachedImages;
@synthesize lstContactAlreadyGetContactURL;
@synthesize isFiendView, canBackFromFiendView;
@synthesize listFilters, /*strElemID, strElemName,*/ strOptID, strOptName;
@synthesize timer4Location, currentLocation, locationManager;


//
//- (void)initPalUpControl
//{
//    if (self) {
//        progressInit = 0.1;
//        myProfile = [[CredentialInfo alloc] init];
//        friend01 = [[CredentialInfo alloc] init];
//        //        listContact2Items = [[NSMutableArray alloc] init];
//        lstCachedImages = [[NSMutableDictionary alloc] init];
//        lstContactAlreadyGetContactURL = [[NSMutableArray alloc] init];
//        listFilters = [[NSMutableArray alloc] init];
//        
//        if(![self isConnectToWeb]){
//            [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        }
//        [self getDefaultUser];
//        progressInit = 0.2;
//        
//        [self initListEmoticons];
//        progressInit = 0.4;        
//        NSLog(@"emotionIconsList len= %d", [emotionIconsList count]);
//        
//        [self initListGift];
//        progressInit = 0.6;
//        NSLog(@"listGift len =%d", [listGift count]);
//        
//        [self listProfileElements];
//        progressInit = 0.8;        
//        
//        [self initLocation];
//        progressInit = 1.0;        
//    }
//    
//}

//
//- (void)initLocation
//{
//#if TARGET_IPHONE_SIMULATOR
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:10.832911 longitude:106.685276];
//    self.currentLocation = location;
//#elif TARGET_OS_IPHONE
//    self.currentLocation = nil;
//#endif
//    
//    CLLocationManager *lm = [[CLLocationManager alloc] init];
//    lm.delegate = self;
//    lm.distanceFilter = kCLDistanceFilterNone; // whenever we move
//    lm.desiredAccuracy = kCLLocationAccuracyNearestTenMeters; // 10 m
//    [lm startUpdatingLocation];
//    self.locationManager = lm;
//    
//}
//
//
//- (void)locationManager:(CLLocationManager *)manager
//    didUpdateToLocation:(CLLocation *)newLocation
//           fromLocation:(CLLocation *)oldLocation
//{
//    /*    int degrees = newLocation.coordinate.latitude;
//     double decimal = fabs(newLocation.coordinate.latitude - degrees);
//     int minutes = decimal * 60;
//     double seconds = decimal * 3600 - minutes * 60;
//     NSString *lat = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
//     degrees, minutes, seconds];
//     
//     degrees = newLocation.coordinate.longitude;
//     decimal = fabs(newLocation.coordinate.longitude - degrees);
//     minutes = decimal * 60;
//     seconds = decimal * 3600 - minutes * 60;
//     NSString *longt = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
//     degrees, minutes, seconds];*/
//    
//#if TARGET_IPHONE_SIMULATOR
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:10.832911 longitude:106.685276];
//    self.currentLocation = location;
//#elif TARGET_OS_IPHONE
//    self.currentLocation = newLocation;
//#endif
//}
//
//
//- (void)onTickUpdate:(NSTimer *)timer
//{
//    if (timer == timer4UpdLstCont2) {
//        int r = [self listContacts2];
//        if (r) {
//            
//        }
//    } else if (timer == timer4Location) {
//        NSLog(@"timer4Location");
//        [self registrationUpdateLocation];
//    }
//}
//
//
//- (void)createThread4ListContact2
//{
//    if (timer4UpdLstCont2) {
//        timer4UpdLstCont2 = nil;
//    }
//    
//    self.timer4UpdLstCont2 = [NSTimer scheduledTimerWithTimeInterval:cTick2UpdLstCont2
//                                                              target:self
//                                                            selector:@selector(onTickUpdate:)
//                                                            userInfo:nil
//                                                             repeats:YES];
//    
//    self.timer4Location = [NSTimer scheduledTimerWithTimeInterval:cTick4Location
//                                                           target:self
//                                                         selector:@selector(onTickUpdate:)
//                                                         userInfo:nil
//                                                          repeats:YES];
//    
//    //    [timer4UpdLstCont2 fire];
//    //    NSRunLoop* myRunLoop = [NSRunLoop currentRunLoop];
//    //    [myRunLoop addTimer:timer4UpdLstCont2 forMode:NSDefaultRunLoopMode];
//    //    [myRunLoop run];
//    
//    BOOL shouldKeepRunning = YES;        // global
//    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
//    [theRL addTimer:timer4Location forMode:NSDefaultRunLoopMode];
//    [theRL addTimer:timer4UpdLstCont2 forMode:NSDefaultRunLoopMode];
//    while (shouldKeepRunning && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
//    
//    
//}
//
//
//- (void)initUpdateListContact2
//{
//    [NSThread detachNewThreadSelector:@selector(createThread4ListContact2)
//                             toTarget:self
//                           withObject:nil];
//}
//
//
-(BOOL) isConnectToWeb
{
    BOOL connected;
    
    NSString *hostGoogle = @"www.google.com";
    SCNetworkReachabilityRef reachabilityGoogle = SCNetworkReachabilityCreateWithName(NULL, [hostGoogle UTF8String]);
    SCNetworkReachabilityFlags flags;
    connected = SCNetworkReachabilityGetFlags(reachabilityGoogle, &flags);
    BOOL isConnected = connected && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);    
    CFRelease(reachabilityGoogle);
    
    if (!isConnected) {
        NSString *hostApple = @"www.apple.com";
        SCNetworkReachabilityRef reachabilityApple = SCNetworkReachabilityCreateWithName(NULL, [hostApple UTF8String]);
        SCNetworkReachabilityFlags appleFlags;
        connected = SCNetworkReachabilityGetFlags(reachabilityApple, &appleFlags);
        isConnected = connected && (appleFlags & kSCNetworkFlagsReachable) && !(appleFlags & kSCNetworkFlagsConnectionRequired);    
        CFRelease(reachabilityApple);
    }
    
    return isConnected;
}
//
//
//
//- (long) getRegistrationID
//{
//    return myProfile.registrationID;
//}
//
//- (NSString*) getUserNamePU
//{
//    return myProfile.usernamePU;
//}
//
//- (void) setFriendInfo:(CredentialInfo *) credential :(long) idx
//{
//    friend01.registrationID = credential.registrationID;
//    friend01.avatarUrl = credential.avatarUrl;
//    friend01.lastName = credential.lastName; 
//    friend01.email = credential.email; 
//    friend01.phone = credential.phone; 
//    friend01.zipcode = credential.zipcode; 
//    friend01.gender = credential.gender; 
//    //friend01.birthday; 
//    friend01.timeZone = credential.timeZone; 
//    friend01.usernamePU = credential.usernamePU; 
//    friend01.passwordPU = credential.passwordPU;
//    friend01.usernameFB = credential.usernameFB; 
//    friend01.passwordFB = credential.passwordFB;
//    friend01.usernameET = credential.usernameET;  
//    friend01.passwordET = credential.passwordET;
//}
//
//- (long)getFriendRegistrationID
//{
//    return friend01.registrationID;
//}
//
//- (NSString*)getFriendName
//{
//    return friend01.usernamePU;
//}
//
//- (NSString*)getFriendInterested
//{
//    return friend01.interest;
//}
//
//- (NSString*)getFriendAvatarURL
//{
//    return friend01.avatarUrl;
//}
//
////==========EmotionIconsList
//- (void)initListEmoticons
//{
//    if (emotionIconsList) {
//        [emotionIconsList removeAllObjects];
//    }
//    
//    emotionIconsList = [[NSMutableArray alloc] init];
//    [self listEmoticons];
//}
//
//- (NSMutableArray*) getEmotionIconsList
//{
//    return emotionIconsList;
//}
//
////========= ListGift ================
//- (void)initListGift
//{
//    if (listGift) {
//        [listGift removeAllObjects];
//    }
//    
//    listGift = [[NSMutableArray alloc] init];
//    [self listGifts];
//}
//
//
//- (NSMutableArray*)getListGift
//{
//    return listGift;
//}
//
//- (void)getDefaultUser
//{
//    // get the handle
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    // Get the result
//    //myProfile.registrationID = [defaults integerForKey:@"UserID"];
//    myProfile.avatarUrl = [defaults stringForKey:@"avaURLPU"];
//    myProfile.lastName = [defaults stringForKey:@"lastNamePU"];
//    myProfile.email = [defaults stringForKey:@"emailPU"];
//    myProfile.phone = [defaults stringForKey:@"phonePU"];
//    myProfile.zipcode = [defaults stringForKey:@"zipcodePU"];
//    myProfile.gender = [defaults stringForKey:@"genderPU"];
//    //myProfile.birthday; 
//    //    myProfile.timeZone = credential.timeZone; 
//    myProfile.usernamePU = [defaults stringForKey:@"usrPU"];
//    myProfile.passwordPU = [defaults stringForKey:@"pwdPU"];
//    myProfile.usernameFB = [defaults stringForKey:@"usrFB"];
//    myProfile.passwordFB = [defaults stringForKey:@"pwdFB"];
//    myProfile.usernameET = [defaults stringForKey:@"usrET"]; 
//    myProfile.passwordET = [defaults stringForKey:@"pwdET"];
//}
//
//
//- (void)storeDefaultUser
//{
//    // get the handle
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    // set the value
//    //[defaults setInteger:myProfile.registrationID forKey:@"UserID"];
//    [defaults setObject:myProfile.avatarUrl forKey:@"avaURLPU"];
//    [defaults setObject:myProfile.lastName forKey:@"lastNamePU"];
//    [defaults setObject:myProfile.email forKey:@"emailPU"];
//    [defaults setObject:myProfile.phone forKey:@"phonePU"];
//    [defaults setObject:myProfile.zipcode forKey:@"zipcodePU"];
//    [defaults setObject:myProfile.gender forKey:@"genderPU"];
//    [defaults setObject:myProfile.usernamePU forKey:@"usrPU"];
//    [defaults setObject:myProfile.passwordPU forKey:@"pwdPU"];
//    [defaults setObject:myProfile.usernameFB forKey:@"usrFB"];
//    [defaults setObject:myProfile.passwordFB forKey:@"pwdFB"];
//    [defaults setObject:myProfile.usernameET forKey:@"usrET"];
//    [defaults setObject:myProfile.passwordET forKey:@"pwdET"];
//    
//    // save it
//    [defaults synchronize];
//}
//
//-(void) showAlertWithMessage: (NSString*) msg andTitle: (NSString*) title{
//    UIAlertView *baseAlert = [[UIAlertView alloc] initWithTitle: title
//                                                        message: msg
//                                                       delegate:self
//                                              cancelButtonTitle:nil
//                                              otherButtonTitles:@"OK", nil];
//    [baseAlert show];
//    
//}
//
//
//////////////////////
//
//- (NSString*)uploadData:(NSData*)data fileName:(NSString*)strFileName
//{
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return nil;
//    }
//    
//	CFUUIDRef uuid = CFUUIDCreate(nil);
//	NSString *uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuid);
//	CFRelease(uuid);
//    NSLog(@"uuidString = %@", uuidString);
//	NSString *stringBoundary = [NSString stringWithFormat:@"0xKhTmLbOuNdArY-%@",uuidString];
//    
//    NSMutableURLRequest *postRequest = [[NSMutableURLRequest alloc] init];    
//    [postRequest setURL:[NSURL URLWithString:@"http://50.19.216.234/upload.php"]];    
//    [postRequest setHTTPMethod:@"POST"];    
//    NSMutableData *body = [[NSMutableData data] init];
//    
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; charset=utf-8; boundary=%@", stringBoundary];
//    [postRequest setValue:contentType forHTTPHeaderField:@"Content-Type"];
//	
//    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
//	
//	// Adds post data
//	NSString *endItemBoundary = [NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary];
//    
//    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"token"]
//                      dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[@"128c1246cd8b11889e97bb3df28f0d84" dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [body appendData:[endItemBoundary dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    /*    NSString *strFileName = nil; [NSString stringWithFormat:@"%@.png", uuidString];
//     if (formatData == 1) {
//     strFileName = [NSString stringWithFormat:@"%@.png", uuidString];
//     } else if (formatData ==2) {
//     strFileName = [NSString stringWithFormat:@"%@.m4a", uuidString];
//     }*/
//    
//    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", 
//                       @"data", strFileName] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [body appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", @"application/octet-stream"]
//                      dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [body appendData:data];
//    
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", stringBoundary]
//                      dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [postRequest setHTTPBody:body];
//    
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:postRequest returningResponse:nil error:nil];    
//    NSString *retString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    NSLog(@"returnString = %@", retString);
//    
//    return retString;
//}
//
//
//
//
//-(long) registrationCreate:(CredentialInfo *) credential
//{
//    NSLog(@"registrationCreate");
//    
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    functionName = nil;
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<RegistrationCreate xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<userName>%@</userName>"
//                      "<password>%@</password>"
//                      "<email>%@</email>"
//                      "</RegistrationCreate>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", credential.usernamePU, credential.passwordPU, credential.email];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"RegistrationCreate"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    long logInId = myProfile.registrationID;
//    if (logInId) {
//        myProfile.usernamePU = credential.usernamePU;
//        myProfile.email = credential.email;
//        myProfile.passwordPU = credential.passwordPU;
//    }
//    
//    return logInId;
//}
//
//- (BOOL) checkUsername:(NSString*) userName
//{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return false;
//    }
//    
//    BOOL result = YES;
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<CheckUsername xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<userName>%@</userName>"
//                      "</CheckUsername>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", userName];
//	
//	//NSLog(post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"CheckUsername"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    return result;
//}
//
//
//- (NSMutableArray*) listInterests
//{
//    NSLog(@"listInterests");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:
//                      @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<ListInterests xmlns='http://50.19.216.234/palup/server.php'>"
//                      "</ListInterests>"
//                      "</soap:Body>"
//					  "</soap:Envelope>"];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"ListInterests"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    return nil;
//}
//
//- (int) registrationAddInterest :(long) interestTypeID
//{
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"listInterests");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<RegistrationAddInterest xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "<interestTypeID>%ld</interestTypeID>"
//                      "</RegistrationAddInterest>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, interestTypeID];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"RegistrationAddInterest"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    return 0;
//}
//
//- (NSMutableArray*) listContacts:(long) idRegistraion
//{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return nil;
//    }
//    
//    NSLog(@"registrationCreate");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<ListContacts xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<fromRegistrationID>%ld</fromRegistrationID>"
//                      "</ListContacts>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", idRegistraion];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"ListContacts"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSLog(@"=====================");
//    NSString *encodeData=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//    NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;" withString:@""];
//    
//    data1 = [data1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//    data1 = [data1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//    
//	NSLog(@"%@", data1);
//    NSLog(@"=====================");
//    
//    NSXMLParser* parser = [[NSXMLParser alloc] initWithData: [data1 dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [parser setDelegate:self];
//    if (![parser parse]) {
//        NSLog(@"Error while parsing data!");
//    }
//    
//    return contactList;
//}
//
//
//- (int)listContacts2
//{
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        return 0;
//    }
//    
//    self.functionName = nil;
//    //    [listContact2Items removeAllObjects];
//    self.listContact2 = [[NSMutableArray alloc] init];
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<ListContacts2 xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%d</registrationID>"
//                      "</ListContacts2>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", [myProfile registrationID]];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, cListContacts2Func]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error = nil;
//	NSURLResponse *response = nil;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request
//                                          returningResponse:&response
//                                                      error:&error];
//    
//    //    NSLog(@"=====================");
//    NSString *encodeData=[[NSString alloc]initWithData:urlData
//                                              encoding:NSUTF8StringEncoding];	
//    NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;"
//                                                            withString:@""];
//    
//    data1 = [data1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//    data1 = [data1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//    
//    //	NSLog(@"%@", data1);
//    //    NSLog(@"=====================");
//    
//    NSXMLParser* parser = [[NSXMLParser alloc] initWithData: [data1 dataUsingEncoding:NSUTF8StringEncoding]];
//    [parser setShouldResolveExternalEntities:YES];
//    [parser setDelegate:self];
//    if (![parser parse]) {
//        NSLog(@"Error while parsing data!");
//    }
//    
//    return 1;
//}
//
//

- (long) registrationLogin:(NSString *)userName :(NSString *)password
{    
    
    if(![self isConnectToWeb]){
        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PostAdvert"];
        
        return 0;
    }
    
    functionName = nil;
    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                      "<soap:Body>"
                      "<RegistrationLogin xmlns='http://50.19.216.234/palup/server.php'>"
                      "<userName>%@</userName>"
                      "<password>%@</password>"
                      "</RegistrationLogin>"
                      "</soap:Body>"
					  "</soap:Envelope>", userName, password];
	
	NSLog(@"%@",post);
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"RegistrationLogin"]]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
    
	NSError *error;
	NSURLResponse *response;
	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    /*	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
     [parser setDelegate:self];
     [parser setShouldResolveExternalEntities:YES];
     [parser parse];
     
	 
	 */
    
    NSString *encodeData=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
    NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;"
                                                            withString:@""];
    
    data1 = [data1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    data1 = [data1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
	NSLog(@"%@", data1);
    
    NSScanner *scanner = [NSScanner scannerWithString:data1];
    NSString *strResult = nil;
    
    //    while (![scanner isAtEnd]){
    [scanner scanUpToString:@"<return xsi:type=\"xsd:int\">" intoString:nil];
    [scanner scanString:@"<return xsi:type=\"xsd:int\">" intoString:nil];
    [scanner scanUpToString:@"</return>" intoString:&strResult];
    
    NSLog(@"result ID: %@", strResult);
    //	}
    
    long logInId = [strResult longLongValue];
    if (logInId) {
        myProfile.registrationID = logInId;
        myProfile.usernamePU = userName;
        myProfile.passwordPU = password;
    }
    
    return logInId;
}

//-(int) registrationSignIn
//{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"registrationSignIn");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<RegistrationSignIn xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "</RegistrationSignIn>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"RegistrationSignIn"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    
//    
//    return 0;
//}
//
//-(int) registrationSignOut
//{
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"registrationSignOut");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<RegistrationSignOut xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "</RegistrationSignOut>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"RegistrationSignOut"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    NSScanner*scaner = [[NSScanner alloc] initWithString:data];
//    
//    NSString*result = nil;
//    [scaner scanUpToString:@"<return" intoString:nil];
//    [scaner scanString:@"<return" intoString:nil];
//    [scaner scanUpToString:@">" intoString:nil];
//    [scaner scanString:@">" intoString:nil];
//    [scaner scanUpToString:@"</return>" intoString:&result];
//    
//    NSLog(@"add contact result: %@", result);
//    
//    
//	/*NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//     [parser setDelegate:self];
//     [parser setShouldResolveExternalEntities:YES];
//     [parser parse];
//     */
//    
//    if([result intValue] > 0){
//        myProfile.registrationID = 0;
//        myProfile.avatarUrl = nil;
//        myProfile.firstName = nil;
//        myProfile.lastName = nil;
//    }
//	
//    
//    return [result intValue];
//}
//
//-(int) registrationChangeStatus:(long) newRegistrationStatusTypeID
//{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"registrationChangeStatus");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<RegistrationChangeStatus xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "<newRegistrationStatusTypeID>%ld</newRegistrationStatusTypeID>"
//                      "</RegistrationChangeStatus>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, newRegistrationStatusTypeID];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"RegistrationChangeStatus"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    return 0;
//}
//
//-(NSMutableArray*) listRegistrationStatuses
//{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return nil;
//    }
//    
//    NSLog(@"listRegistrationStatuses");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<ListRegistrationStatuses xmlns='http://50.19.216.234/palup/server.php'>"
//                      "</ListRegistrationStatuses>"
//                      "</soap:Body>"
//					  "</soap:Envelope>"];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"ListRegistrationStatuses"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    
//    return nil;
//}
//
//-(int) addContact:(long) toClientID :(NSString*) txtMessage
//{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"addContact");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<AddContact xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<fromClientID>%ld</fromClientID>"
//                      "<toClientID>%ld</toClientID>"
//                      "<txtMessage>%@</txtMessage>"
//                      "</AddContact>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, toClientID, txtMessage];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"AddContact"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    NSScanner*scaner = [[NSScanner alloc] initWithString:data];
//    
//    NSString*result = nil;
//    [scaner scanUpToString:@"<return" intoString:nil];
//    [scaner scanString:@"<return" intoString:nil];
//    [scaner scanUpToString:@">" intoString:nil];
//    [scaner scanString:@">" intoString:nil];
//    [scaner scanUpToString:@"</return>" intoString:&result];
//    
//    NSLog(@"add contact result: %@", result);
//    
//    
//    
//    
//	/*NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//     [parser setDelegate:self];
//     [parser setShouldResolveExternalEntities:YES];
//     [parser parse];
//     
//	 
//	 */
//    return [result intValue];
//}
//
//
//- (int)changeContactType:(long) toClientID :(int)contactTypeID
//{
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<ChangeContactType xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<fromClientID>%d</fromClientID>"
//                      "<toClientID>%d</toClientID>"
//                      "<contactTypeID>%d</contactTypeID>"
//                      "</ChangeContactType>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, toClientID, contactTypeID];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, cChangeContactType]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSLog(@"=====================");
//    NSString *encodeData=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//    NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;" withString:@""];
//    
//    data1 = [data1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//    data1 = [data1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//    
//	NSLog(@"%@", data1);
//    NSLog(@"=====================");
//    
//    NSXMLParser* parser = [[NSXMLParser alloc] initWithData: [data1 dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [parser setDelegate:self];
//    if (![parser parse]) {
//        NSLog(@"Error while parsing data!");
//    }
//    
//    
//    int retVal = 1;
//    return retVal;
//}
//
//
//-(int) RemoveContact: (long) toClientID :(NSString*) txtMessage
//{
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"RemoveContact");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<RemoveContact xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<fromClientID>%ld</fromClientID>"
//                      "<toClientID>%ld</toClientID>"
//                      "<txtMessage>%@</txtMessage>"
//                      "</RemoveContact>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, toClientID, txtMessage];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"RemoveContact"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    NSScanner*scaner = [[NSScanner alloc] initWithString:data];
//    
//    NSString*result = nil;
//    [scaner scanUpToString:@"<return" intoString:nil];
//    [scaner scanString:@"<return" intoString:nil];
//    [scaner scanUpToString:@">" intoString:nil];
//    [scaner scanString:@">" intoString:nil];
//    [scaner scanUpToString:@"</return>" intoString:&result];
//    
//    NSLog(@"remove contact result: %@", result);
//    
//    
//    
//    
//	/*NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//     [parser setDelegate:self];
//     [parser setShouldResolveExternalEntities:YES];
//     [parser parse];
//     
//	 
//	 */
//    return [result intValue];
//}
//
//-(int) blockContact: (long) toClientID :(NSString*) txtMessage
//{
//    NSLog(@"blockContact");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<BlockContact xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<fromClientID>%ld</fromClientID>"
//                      "<toClientID>%ld</toClientID>"
//                      "<txtMessage>%@</txtMessage>"
//                      "</BlockContact>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, toClientID, txtMessage];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"BlockContact"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    return 0;
//}
//
//-(int) giftContact:(long) toClientID :(long) giftTypeID  :(NSString*) txtMessage
//{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"giftContact");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<GiftContact xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<fromClientID>%ld</fromClientID>"
//                      "<toClientID>%ld</toClientID>"
//                      "<giftTypeID>%ld</giftTypeID>"
//                      "<txtMessage>%@</txtMessage>"
//                      "</GiftContact>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, toClientID, giftTypeID, txtMessage];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"GiftContact"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    return 0;
//}
//
//-(void)listGifts
//{
//    NSLog(@"listGifts");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<ListGifts xmlns='http://50.19.216.234/palup/server.php'>"
//                      "</ListGifts>"
//                      "</soap:Body>"
//					  "</soap:Envelope>"];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, cListGiftsFunc]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSLog(@"=====================");
//    NSString *encodeData=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//    NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;" withString:@""];
//    data1 = [data1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//    data1 = [data1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//    
//	NSLog(@"%@", data1);
//    NSLog(@"=====================");
//    
//    NSXMLParser* parser = [[NSXMLParser alloc] initWithData: [data1 dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [parser setDelegate:self];
//    if (![parser parse]) {
//        NSLog(@"Error while parsing data!");
//    }
//}
//
//-(int) registrationChangePassword:(NSString*) txtMessage
//{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"registrationChangePassword");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<RegistrationChangePassword xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "<txtMessage>%@</txtMessage>"
//                      "</RegistrationChangePassword>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, txtMessage];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"RegistrationChangePassword"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    return 0;
//}
//
//-(int) registrationRemoveInterest:(long) interestTypeID
//{
//    NSLog(@"registrationRemoveInterest");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<RegistrationRemoveInterest xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "<interestTypeID>%ld</interestTypeID>"
//                      "</RegistrationRemoveInterest>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, interestTypeID];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"RegistrationRemoveInterest"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    
//    return 0;
//}
//
//-(int) registrationRemoveAllInterests
//{
//    NSLog(@"registrationRemoveAllInterests");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<RegistrationRemoveAllInterests xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "</RegistrationRemoveAllInterests>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"RegistrationRemoveAllInterests"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    return 0;
//}
//
//-(int) registrationUpdateLocation
//{
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"registrationUpdateLocation");
//    self.functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<RegistrationUpdateLocation xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%d</registrationID>"
//                      "<latitude>%lf</latitude>"
//                      "<longitude>%lf</longitude>"
//                      "</RegistrationUpdateLocation>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
//	
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"RegistrationUpdateLocation"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request
//                                          returningResponse:&response 
//                                                      error:&error];
//    
//    NSString *encodeData=[[NSString alloc]initWithData:urlData
//                                              encoding:NSUTF8StringEncoding];
//    NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;"
//                                                            withString:@""];
//    
//    
//    NSScanner *scanner = [NSScanner scannerWithString:data1];
//    NSString *startTag = [NSString stringWithFormat:@"<return xsi:type=\"xsd:int\">"];
//    NSString *strResult= nil;
//    
//    [scanner scanUpToString:startTag intoString:nil];
//    [scanner scanString:startTag intoString:nil];
//    [scanner scanUpToString:@"</return>" intoString:&strResult];
//    
//    NSLog(@"return value: %@", strResult);
//    int retVal = 0; //OffLine status as default
//    if (strResult) {
//        retVal = [strResult longLongValue];
//    }
//    
//    return retVal;
//}
//
//-(int) registrationUpdateAvatar:(NSString*) newAvatarURL
//{
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"registrationUpdateAvatar");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<RegistrationUpdateAvatar xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "<newAvatarURL>%@</newAvatarURL>"
//                      "</RegistrationUpdateAvatar>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, newAvatarURL];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"RegistrationUpdateAvatar"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    return 0;
//}
//
//-(int) inviteFacebookFriends:(NSString*) username :(NSString*) password :(NSString*) message
//{
//    NSLog(@"inviteFacebookFriends");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<InviteFacebookFriends xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "<userName>%@</userName>"
//                      "<password>%@</password>"
//                      "<message>%@</message>"
//                      "</InviteFacebookFriends>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, username, password, message];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"InviteFacebookFriends"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    return 0;
//}
//
//-(int) inviteHotmailFriends:(NSString*) username :(NSString*) password :(NSString*) message
//{
//    NSLog(@"inviteHotmailFriends");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<InviteHotmailFriends xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "<userName>%@</userName>"
//                      "<password>%@</password>"
//                      "<message>%@</message>"
//                      "</InviteHotmailFriends>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, username, password, message];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"InviteHotmailFriends"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    return 0;
//}
//
//-(int) inviteYahooFriends:(NSString*) username :(NSString*) password :(NSString*) message
//{
//    NSLog(@"inviteYahooFriends");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<InviteHotmailFriends xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "<userName>%@</userName>"
//                      "<password>%@</password>"
//                      "<message>%@</message>"
//                      "</InviteHotmailFriends>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, username, password, message];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"InviteYahooFriends"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    return 0;
//}
//
//-(int) inviteGmailFriends:(NSString*) username :(NSString*) password :(NSString*) message
//{
//    NSLog(@"inviteGmailFriends");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<InviteGmailFriends xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "<userName>%@</userName>"
//                      "<password>%@</password>"
//                      "<message>%@</message>"
//                      "</InviteGmailFriends>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, username, password, message];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"InviteGmailFriends"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    return 0;
//}
//
//-(int) inviteAOLFriends:(NSString*) username :(NSString*) password :(NSString*) message
//{
//    NSLog(@"inviteAOLFriends");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<InviteAOLFriends xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "<userName>%@</userName>"
//                      "<password>%@</password>"
//                      "<message>%@</message>"
//                      "</InviteAOLFriends>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, username, password, message];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"InviteAOLFriends"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//    
//    
//    
//    return 0;
//}
//
//- (long) sendChatMessage:(long) toId :(NSString*) msg
//{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<SendChatMessage xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<fromRegistrationID>%d</fromRegistrationID>"
//                      "<toRegistrationID>%d</toRegistrationID>"
//                      "<message>%@</message>"
//                      "</SendChatMessage>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, toId, msg];
//	
//	//NSLog(post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"SendChatMessage"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error = nil;
//	NSURLResponse *response = nil;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request
//                                          returningResponse:&response
//                                                      error:&error];
//    
//    NSString *encodeData=[[NSString alloc]initWithData:urlData
//                                              encoding:NSUTF8StringEncoding];
//    
//    NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;"
//                                                            withString:@""];
//    
//    
//    NSScanner *scanner = [NSScanner scannerWithString:data1];
//    NSString *startTag = [NSString stringWithFormat:@"<return xsi:type=\"xsd:int\">"];
//    NSString *strResult= nil;
//    
//    [scanner scanUpToString:startTag intoString:nil];
//    [scanner scanString:startTag intoString:nil];
//    [scanner scanUpToString:@"</return>" intoString:&strResult];
//    
//    NSLog(@"return value: %@", strResult);
//    long retVal = 0; //OffLine status as default
//    if (strResult) {
//        retVal = [strResult longLongValue];
//    }
//    
//    return retVal;
//}
//
//
//
//-(NSMutableArray*) OutputMessages
//{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return nil;
//    }
//    
//    NSLog(@"outputMessages");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<OutputMessages xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "</OutputMessages>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"OutputMessages"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    return 0;
//}
//
//-(int) CronProcessWorkQueue
//{
//    NSLog(@"cronProcessWorkQueue");
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<CronProcessWorkQueue xmlns='http://50.19.216.234/palup/server.php'>"
//                      "</CronProcessWorkQueue>"
//                      "</soap:Body>"
//					  "</soap:Envelope>"];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"CronProcessWorkQueue"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    return 0;
//}
//
//-(NSMutableArray*) getProfile
//{
//    NSLog(@"getProfile");
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<GetProfile xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "</GetProfile>"
//                      "</soap:Body>"
//					  "</soap:Envelope>"];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"GetProfile"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    return nil;
//}
//
//
//#pragma GetFullProfile
//
//-(void) getFullProfile{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return;
//    }
//    
//    NSLog(@"getFullProfile");
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<GetFullProfile xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "</GetFullProfile>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID];
//	
//	//NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"GetFullProfile"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *encodeData=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//    NSString *data = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;" withString:@""];
//    
//    data = [data stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//    data = [data stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//    
//	NSLog(@"%@", data);
//    
//    myProfile.firstName = [self getValueOfTag:@"Firstname" fromString:data withSubTag: NO] ;
//    myProfile.lastName = [self getValueOfTag:@"Lastname" fromString:data withSubTag: NO] ;
//    myProfile.avatarUrl = [self getValueOfTag:@"avatarURL" fromString:data withSubTag: NO];
//    myProfile.gender = [self getValueOfTag:@"Gender" fromString:data withSubTag: NO];
//    //myProfile.interest = [self getValueOfTag:@"Interest" fromString:data withSubTag: YES];
//    myProfile.registrationStatusTypeID = [self getProperty:@"RegistrationStatusTypeID" fromString:data];
//    myProfile.email = [self getValueOfTag:@"Email" fromString:data withSubTag: NO];
//    myProfile.phone = [self getValueOfTag:@"Phone" fromString:data withSubTag: NO];
//    myProfile.zipcode = [self getValueOfTag:@"Zipcode" fromString:data withSubTag: NO];
//    NSString* bd =  [self getValueOfTag:@"Birthday" fromString:data withSubTag: NO];
//    
//    if(![bd isEqualToString:@" "]){
//        NSDateFormatter*df = [[NSDateFormatter alloc] init];
//        [df setDateFormat:@"yyyy-MM-dd"];
//        myProfile.birthday = [df dateFromString:bd];
//        
//    }
//    else{
//        myProfile.birthday = [NSDate date];
//    }
//    
//    myProfile.statusMessage = [self getValueOfTag:@"SocialNetworkStatus" fromString:data withSubTag: NO];
//    
//    
//    //NSLog(@"%@", myProfile.birthday);
//    //myProfile.relationshipTypeID = [self getProperty:@"RelationshipTypeID" fromString:data];
//	//myProfile.relationshipText = [self getValueOfTag:@"Relationship" fromString:data withSubTag: YES];
//    //myProfile.interestTypeID = [self getProperty:@"InterestTypeID" fromString:data];
//    /*
//     myProfile.appearance = [self getValueOfTag:@"Appearance" fromString:data withSubTag: YES];
//     myProfile.children = [self getValueOfTag:@"Children" fromString:data withSubTag: YES];
//     myProfile.smoking = [self getValueOfTag:@"Smoking" fromString:data withSubTag: YES];
//     myProfile.drinking = [self getValueOfTag:@"Drinking" fromString:data withSubTag: YES];
//     myProfile.education = [self getValueOfTag:@"Education" fromString:data withSubTag: YES];
//     myProfile.book = [self getValueOfTag:@"Books" fromString:data withSubTag: NO];
//     myProfile.music = [self getValueOfTag:@"Music" fromString:data withSubTag: NO];
//     
//     myProfile.appearanceTypeID = [self getProperty:@"AppearanceID" fromString:data];
//     myProfile.childrenTypeID = [self getProperty:@"ChildrenID" fromString:data];
//     myProfile.smokingTypeID = [self getProperty:@"SmokingID" fromString:data];
//     myProfile.drinkingTypeID = [self getProperty:@"DrinkingID" fromString:data];
//     myProfile.educationTypeID = [self getProperty:@"EducationID" fromString:data];
//     */
//    data = nil;
//}
//
//-(NSString*)getValueOfTag:(NSString *)tag fromString:(NSString *)source withSubTag:(BOOL) flag{
//    NSScanner* scaner = [[NSScanner alloc] initWithString:source];
//    NSString* startTag = [NSString stringWithFormat:@"<%@>", tag];
//    NSString* endTag = [NSString stringWithFormat:@"</%@>", tag];
//    NSString* str = nil;
//    
//    if(flag){
//        startTag = [NSString stringWithFormat:@"<%@", tag];
//        [scaner scanUpToString:startTag intoString:nil];
//        [scaner scanString:startTag intoString:nil];
//        [scaner scanUpToString:@"<Name>" intoString:nil];
//        [scaner scanString:@"<Name>" intoString:nil];
//        [scaner scanUpToString:@"</Name>" intoString:&str];
//    }
//    else{
//        [scaner scanUpToString:startTag intoString:nil];
//        [scaner scanString:startTag intoString:nil];
//        [scaner scanUpToString:endTag intoString:&str];
//    }
//    
//    
//    if(str == nil && ![tag isEqualToString:@"avatarURL"] ) str = @" ";
//    NSLog(@"tag %@: %@", tag, str);
//    return str;
//}
//
//
//-(NSString*) getProperty:(NSString*)property fromString:(NSString *)source{
//    NSScanner* scaner = [[NSScanner alloc] initWithString:source];
//    NSString* startTag = [NSString stringWithFormat:@"%@=\"", property];
//    NSString* str = nil;
//    [scaner scanUpToString:startTag intoString:nil];
//    [scaner scanString:startTag intoString:nil];
//    [scaner scanUpToString:@"\"" intoString:&str];
//    
//    
//    if(str == nil) str = @"1";
//    NSLog(@"%@", str);
//    return str;
//}
//
//-(NSDate*) dateFromString: (NSString*) source{
//    NSDateFormatter* df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    return [df dateFromString:source];
//}
//
//
//-(int) EditProfile{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSString *strBirthday = @"";
//    if (myProfile.birthday) {
//        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//        [dateFormat setDateFormat:@"yyyy-MM-dd"];
//        //NSString *strBirthday = [dateFormat stringFromDate:myProfile.birthday];
//        
//    }
//    
//    functionName = cEditProfileFunc;
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<EditProfile xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "<userName>%@</userName>"
//                      "<email>%@</email>"
//                      "<firstName>%@</firstName>"
//                      "<lastName>%@</lastName>"
//                      "<phone>%@</phone>"
//                      "<zipCode>%@</zipCode>"
//                      "<gender>%@</gender>"
//                      "<birthday>%@</birthday>"
//                      "<status>%@</status>"
//                      "</EditProfile>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, myProfile.usernamePU, myProfile.email, myProfile.firstName, myProfile.lastName, myProfile.phone, myProfile.zipcode, myProfile.gender, strBirthday, myProfile.registrationStatusTypeID];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"EditProfile"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//    NSLog(@"%@",data);
//    
//    
//    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:urlData];
//    [parser setDelegate:self];
//    [parser setShouldResolveExternalEntities:YES];
//    [parser parse];
//    
//    
//    
//    return parseResult;
//}
//
//-(int) removeProfileElementWithOption: (NSString*)option{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    functionName = cRemoveRegistrationProfileElement;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<RemoveRegistrationProfileElement xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "<profileElementOptionID>%@</profileElementOptionID>"
//                      "</RemoveRegistrationProfileElement>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, option];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"RemoveRegistrationProfileElement"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:urlData];
//    [parser setDelegate:self];
//    [parser setShouldResolveExternalEntities:YES];
//    [parser parse];
//    
//    
//    
//    return parseResult;
//}
//
//
//-(int) addProfileElementWithOption: (NSString*)option{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    functionName = cAddRegistrationProfileElement;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<AddRegistrationProfileElement xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<registrationID>%ld</registrationID>"
//                      "<profileElementOptionID>%@</profileElementOptionID>"
//                      "</AddRegistrationProfileElement>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, option];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"AddRegistrationProfileElement"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:urlData];
//    [parser setDelegate:self];
//    [parser setShouldResolveExternalEntities:YES];
//    [parser parse];
//    
//    
//    
//    return parseResult;
//    
//}
//
//-(NSString*) getProfileElementOptionNamebyId: (int) index{
//    NSString*result = @"";
//    
//    if(index == 1 || index == 4){
//        result = @"Never";
//    }
//    else if(index == 2 || index == 5){
//        result = @"Sometimes";
//    }
//    else if(index == 3 || index == 6 || index == 10){
//        result = @"Yes";
//    }
//    else if(index == 7){
//        result = @"No";
//    }
//    else if(index == 8){
//        result = @"Not yet";
//    }
//    else if(index == 9){
//        result = @"Someday";
//    }
//    else if(index == 11){
//        result = @"Hip Hop";
//    }
//    else if(index == 12){
//        result = @"Rock";
//    }
//    else if(index == 13){
//        result = @"Pop";
//    }
//    else if(index == 14){
//        result = @"Jazz";
//    }
//    else if(index == 15){
//        result = @"Classical";
//    }
//    else if(index == 16){
//        result = @"Action";
//    }
//    else if(index == 17){
//        result = @"Comedy";
//    }
//    else if(index == 18){
//        result = @"Romance";
//    }
//    else if(index == 19){
//        result = @"Slim";
//    }
//    else if(index == 20){
//        result = @"Athletic";
//    }
//    else if(index == 21){
//        result = @"Average";
//    }
//    else if(index == 22){
//        result = @"Heavy";
//    }
//    
//    return result;
//    
//}
//
////////////////////////////////////////////
//-(int) loginETAccount
//{
//    NSLog(@"loginETAccount");
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<LoginETAccount xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<ETUsername></ETUsername>"
//                      "<ETPassword></ETPassword>"
//                      "<username></username>"
//                      "<password></password>"
//                      "<email></email>"
//                      "</LoginETAccount>"
//                      "</soap:Body>"
//					  "</soap:Envelope>"];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"LoginETAccount"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    return 0;
//}
//
//-(int) loginFBAccount
//{
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"loginFBAccount");
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<LoginFBAccount xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<FBUsername></FBUsername>"
//                      "<FBPassword></FBPassword>"
//                      "<username></username>"
//                      "<password></password>"
//                      "<email></email>"
//                      "</LoginFBAccount>"
//                      "</soap:Body>"
//					  "</soap:Envelope>"];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"LoginFBAccount"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    return 0;
//}
//
//-(int) loginGoogleAccount
//{
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"loginGoogleAccount");
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<LoginGoogleAccount xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<GoogleUsername></GoogleUsername>"
//                      "<GooglePassword></GooglePassword>"
//                      "<username></username>"
//                      "<password></password>"
//                      "<email></email>"
//                      "</LoginGoogleAccount>"
//                      "</soap:Body>"
//					  "</soap:Envelope>"];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"LoginGoogleAccount"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    return 0;
//}
//
//-(int) registrationResetPassword
//{
//    
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"registrationResetPassword");
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<RegistrationResetPassword xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<userName></userName>"
//                      "</RegistrationResetPassword>"
//                      "</soap:Body>"
//					  "</soap:Envelope>"];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"RegistrationResetPassword"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    return 0;
//}
//
//-(NSMutableArray*) get50RandomOnlineAvatars
//{
//    NSLog(@"get50RandomOnlineAvatars");
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<Get50RandomOnlineAvatars xmlns='http://50.19.216.234/palup/server.php'>"
//                      "</Get50RandomOnlineAvatars>"
//                      "</soap:Body>"
//					  "</soap:Envelope>"];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"Get50RandomOnlineAvatars"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    return nil;
//}
//
//
//-(NSMutableArray*) listRelationshipType
//{
//    NSLog(@"listRelationshipType");
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<ListRelationshipType xmlns='http://50.19.216.234/palup/server.php'>"
//                      "</ListRelationshipType>"
//                      "</soap:Body>"
//					  "</soap:Envelope>"];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"ListRelationshipType"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    return nil;
//}
//
//
//- (long)uploadSoundClip:(long)toRegID :(NSString*) strVoice
//{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"uploadSoundClip");
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<UploadSoundClip xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<fromRegistrationID>%ld</fromRegistrationID>"
//                      "<toRegistrationID>%ld</toRegistrationID>"
//                      "<fileURL>%@</fileURL>"
//                      "</UploadSoundClip>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, toRegID, strVoice];
//    
//  	NSLog(@"%@", post);
//    NSLog(@"=====================");
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"UploadSoundClip"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *encodeData=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//    NSString *data = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;" withString:@""];
//    
//    data = [data stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//    data = [data stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//    
//    NSLog(@"%@", data);
//    NSLog(@"=====================");
//    
//    NSScanner *scanner = [NSScanner scannerWithString:data];
//    NSString *startTag = [NSString stringWithFormat:@"<return xsi:type=\"xsd:int\">"];
//    NSString *strResult= nil;
//    
//    [scanner scanUpToString:startTag intoString:nil];
//    [scanner scanString:startTag intoString:nil];
//    [scanner scanUpToString:@"</return>" intoString:&strResult];
//    
//    NSLog(@"UsersAvailable: %@", strResult);
//    long retVal = 0; //OffLine status as default
//    if (strResult) {
//        retVal = [strResult longLongValue];
//    }
//    
//    return retVal;
//}
//
//- (long)sendPhoto:(long)toRegID :(NSString*) strImage
//{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"sendPhoto");
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<SendPhoto xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<fromRegistrationID>%ld</fromRegistrationID>"
//                      "<toRegistrationID>%ld</toRegistrationID>"
//                      "<fileURL>%@</fileURL>"
//                      "</SendPhoto>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, toRegID, strImage];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"SendPhoto"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *encodeData=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//    NSString *data = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;" withString:@""];
//    
//    data = [data stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//    data = [data stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//    
//    NSLog(@"%@", data);
//    NSLog(@"=====================");
//    
//    NSScanner *scanner = [NSScanner scannerWithString:data];
//    NSString *startTag = [NSString stringWithFormat:@"<return xsi:type=\"xsd:int\">"];
//    NSString *strResult= nil;
//    
//    [scanner scanUpToString:startTag intoString:nil];
//    [scanner scanString:startTag intoString:nil];
//    [scanner scanUpToString:@"</return>" intoString:&strResult];
//    
//    NSLog(@"UsersAvailable: %@", strResult);
//    long retVal = 0; //OffLine status as default
//    if (strResult) {
//        retVal = [strResult longLongValue];
//    }
//    
//    return retVal;
//}
//
//-(NSMutableArray*) getUserProfilePhotos
//{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return nil;
//    }
//    
//    NSLog(@"getUserProfilePhotos");
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<GetUserProfilePhotos xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<RegistrationID>%ld</RegistrationID>"
//                      "</GetUserProfilePhotos>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"GetUserProfilePhotos"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    return nil;
//}
//
//-(long) getRandomOnlineUserID
//{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"getRandomOnlineUserID");
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<GetRandomOnlineUserID xmlns='http://50.19.216.234/palup/server.php'>"
//                      "</GetRandomOnlineUserID>"
//                      "</soap:Body>"
//					  "</soap:Envelope>"];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"GetRandomOnlineUserID"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//	[parser parse];
//    
//    
//    return 0;
//}
//
//
//
//-(NSString*)getTagValue:(NSString *)tag fromString:(NSString *)source 
//{
//    NSScanner* scaner = [[NSScanner alloc] initWithString:source];
//    NSString* startTag = [NSString stringWithFormat:@"<%@>", tag];
//    NSString* endTag = [NSString stringWithFormat:@"</%@>", tag];
//    NSString* str = nil;
//    
//    if([tag isEqualToString:@"RelationshipName"]){
//        [scaner scanUpToString:@"<Relationship" intoString:nil];
//        [scaner scanString:@"<Relationship" intoString:nil];
//        [scaner scanUpToString:@"<Name>" intoString:nil];
//        [scaner scanString:@"<Name>" intoString:nil];
//        [scaner scanUpToString:@"</Name>" intoString:&str];
//    }
//    else{
//        [scaner scanUpToString:startTag intoString:nil];
//        [scaner scanString:startTag intoString:nil];
//        [scaner scanUpToString:endTag intoString:&str];
//    }
//    
//    if(str == nil && ![tag isEqualToString:@"avatarURL"] ) str = @" ";
//    NSLog(@"tag %@: %@", tag, str);
//    return str;
//}
//
//
//-(NSString*) getAttribute:(NSString*)property fromString:(NSString *)source;
//{
//    NSScanner* scaner = [[NSScanner alloc] initWithString:source];
//    NSString* startTag = [NSString stringWithFormat:@"%@=\"", property];
//    NSString* str = nil;
//    [scaner scanUpToString:startTag intoString:nil];
//    [scaner scanString:startTag intoString:nil];
//    [scaner scanUpToString:@"\"" intoString:&str];
//    
//    if(str == nil) str = @" ";
//    NSLog(@"%@", str);
//    return str;
//}
///*
// -(NSDate*) dateFromString: (NSString*) source{
// NSDateFormatter* df = [[[NSDateFormatter alloc] init] autorelease];
// [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
// return [df dateFromString:source];
// }*/
//
//- (void)listEmoticons
//{
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//    }
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<ListEmoticons xmlns='http://50.19.216.234/palup/server.php'>"
//                      "</ListEmoticons>"
//                      "</soap:Body>"
//					  "</soap:Envelope>"];
//	
//    //	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//    
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, cListEmoticonsFunc]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error= nil;
//	NSURLResponse *response= nil;
//	NSData *data=[NSURLConnection sendSynchronousRequest:request
//                                       returningResponse:&response
//                                                   error:&error];
//    
//    NSLog(@"=====================");
//    NSString *encodeData=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];	
//    NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;" withString:@""];
//    
//    data1 = [data1 stringByReplacingOccurrencesOfString:@"&amp;lt;" withString:@"<"];
//    //    data1 = [data1 stringByReplacingOccurrencesOfString:@"&amp;gt;" withString:@">"];
//    data1 = [data1 stringByReplacingOccurrencesOfString:@"&amp;amp;" withString:@"&"];
//    data1 = [data1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//    data1 = [data1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//    
//	NSLog(@"%@", data1);
//    NSLog(@"=====================");
//    
//    NSScanner *scanner = [NSScanner scannerWithString:data1];
//    NSString *strEmotID, *strRepTxt, *strImgURL, *strDispName;
//    
//    while (![scanner isAtEnd]){
//        strEmotID   = nil;
//        strRepTxt   = nil;
//        strImgURL   = nil;
//        strDispName = nil;
//        //        NSLog(@"=============================");
//        [scanner scanUpToString:@"<EmoticonsID>" intoString:nil];
//        [scanner scanString:@"<EmoticonsID>" intoString:nil];
//        [scanner scanUpToString:@"</EmoticonsID>" intoString:&strEmotID];
//        //        NSLog(@"EmoticonsID: %@", strEmotID);
//        
//        [scanner scanUpToString:@"<ReplacementText>" intoString:nil];
//        [scanner scanString:@"<ReplacementText>" intoString:nil];
//        [scanner scanUpToString:@"</ReplacementText>" intoString:&strRepTxt];
//        //        NSLog(@"ReplacementText: %@", strRepTxt);
//        
//        [scanner scanUpToString:@"<ImageURL>" intoString:nil];
//        [scanner scanString:@"<ImageURL>" intoString:nil];
//        [scanner scanUpToString:@"</ImageURL>" intoString:&strImgURL];
//        //        NSLog(@"ImageURL: %@", strImgURL);
//        
//        [scanner scanUpToString:@"<DisplayName>" intoString:nil];
//        [scanner scanString:@"<DisplayName>" intoString:nil];
//        [scanner scanUpToString:@"</DisplayName>" intoString:&strDispName];
//        //        NSLog(@"DisplayName: %@", strDispName);
//        
//        if (strEmotID) {
//            [emotionIconsList addObject: 
//             [NSDictionary dictionaryWithObjectsAndKeys:
//              strEmotID, cEmoticonsID,
//              strRepTxt, cReplacementText,
//              strImgURL, cImageURL,                                                         
//              strDispName, cDisplayName, nil]];
//        }
//        
//	}
//}
//
///*
// UploadPhotoToProfile
// {
// }
// */
//
//
//
//- (int)likes: (long) toRegistrationID
//{
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"Likes");
//    functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<Like xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<fromRegistrationID>%ld</fromRegistrationID>"
//                      "<toRegistrationID>%ld</toRegistrationID>"
//                      "</Like>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", myProfile.registrationID, toRegistrationID];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"Like"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//	NSLog(@"%@", data);
//    
//    NSScanner*scaner = [[NSScanner alloc] initWithString:data];
//    
//    NSString*result = nil;
//    [scaner scanUpToString:@"<return" intoString:nil];
//    [scaner scanString:@"<return" intoString:nil];
//    [scaner scanUpToString:@">" intoString:nil];
//    [scaner scanString:@">" intoString:nil];
//    [scaner scanUpToString:@"</return>" intoString:&result];
//    
//    NSLog(@"remove contact result: %@", result);
//    
//    
//    
//    
//	/*NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//     [parser setDelegate:self];
//     [parser setShouldResolveExternalEntities:YES];
//     [parser parse];
//     
//     
//     */
//    return [result intValue];
//}
//
//
//- (NSMutableArray*) searchContactByMask:(NSString*) searchStr
//{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return nil;
//    }
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<SearchContactByMask xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<searchString>%</searchString>"
//                      "</SearchContactByMask>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", searchStr];
//	
//	NSLog(@"%@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"SearchContactByMask"]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    NSString *data = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];	
//    
//	NSLog(@"%@", data);
//    
//    
//	NSXMLParser *parser = [[NSXMLParser alloc] initWithData: urlData];
//	[parser setDelegate:self];
//	[parser setShouldResolveExternalEntities:YES];
//    //	[parser parse];
//    
//    
//    
//    
//    return contactList;
//}
//
//- (int)usersAvailable
//{
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return 0;
//    }
//    
//    NSLog(@"usersAvailable");
//    self.functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<UsersAvailable xmlns='http://50.19.216.234/palup/server.php'>"
//                      "</UsersAvailable>"
//                      "</soap:Body>"
//					  "</soap:Envelope>"];
//	
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, cUsersAvailable]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request
//                                          returningResponse:&response 
//                                                      error:&error];
//    
//    NSLog(@"=====================");
//    NSString *encodeData=[[NSString alloc]initWithData:urlData
//                                              encoding:NSUTF8StringEncoding];
//    NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;"
//                                                            withString:@""];
//    
//    //    data1 = [data1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//    //    data1 = [data1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//    
//	NSLog(@"%@", data1);
//    NSLog(@"=====================");
//    
//    NSScanner *scanner = [NSScanner scannerWithString:data1];
//    NSString *startTag = [NSString stringWithFormat:@"<return xsi:type=\"xsd:int\">"];
//    NSString *strResult= nil;
//    
//    [scanner scanUpToString:startTag intoString:nil];
//    [scanner scanString:startTag intoString:nil];
//    [scanner scanUpToString:@"</return>" intoString:&strResult];
//    
//    NSLog(@"return value: %@", strResult);
//    int retVal = 0; //OffLine status as default
//    if (strResult) {
//        retVal = [strResult longLongValue];
//    }
//    
//    return retVal;
//}
//
//
//- (long)shareContact:(long)toRegistrationID :(int)contactID
//{   
//    long retVal = 0;
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//    } else {
//        NSLog(@"ShareContact");
//        self.functionName = nil;
//        
//        NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                          "<soap:Body>"
//                          "<ShareContact xmlns='http://50.19.216.234/palup/server.php'>"
//                          "<fromRegistrationID>%ld</fromRegistrationID>"
//                          "<toRegistrationID>%ld</toRegistrationID>"
//                          "<contactID>%ld</contactID>"
//                          "</ShareContact>"
//                          "</soap:Body>"
//                          "</soap:Envelope>", myProfile.registrationID, toRegistrationID, contactID];
//        
//        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//        
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"ShareContact"]]];
//        [request setHTTPMethod:@"POST"];
//        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        [request setHTTPBody:postData];
//        
//        NSError *error = nil;
//        NSURLResponse *response = nil;
//        NSData *urlData=[NSURLConnection sendSynchronousRequest:request
//                                              returningResponse:&response 
//                                                          error:&error];
//        
//        NSLog(@"=====================");
//        NSString *encodeData=[[NSString alloc]initWithData:urlData
//                                                  encoding:NSUTF8StringEncoding];
//        NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;"
//                                                                withString:@""];
//        
//        //    data1 = [data1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//        //    data1 = [data1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//        
//        NSLog(@"%@", data1);
//        NSLog(@"=====================");
//        
//        NSScanner *scanner = [NSScanner scannerWithString:data1];
//        NSString *startTag = [NSString stringWithFormat:@"<return xsi:type=\"xsd:int\">"];
//        NSString *strResult= nil;
//        
//        [scanner scanUpToString:startTag intoString:nil];
//        [scanner scanString:startTag intoString:nil];
//        [scanner scanUpToString:@"</return>" intoString:&strResult];
//        
//        NSLog(@"return value: %@", strResult);
//        if (strResult) {
//            retVal = [strResult longLongValue];
//        }
//    }
//    return retVal;
//}
//
//
//- (long)shareMusic:(long)toRegistrationID :(NSString*)path :(NSString*)title
//{    
//    long retVal = 0; //OffLine status as default
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//    } else {
//        NSLog(@"usersAvailable");
//        self.functionName = nil;
//        
//        NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                          "<soap:Body>"
//                          "<ShareMusic xmlns='http://50.19.216.234/palup/server.php'>"
//                          "<fromRegistrationID>%ld</fromRegistrationID>"
//                          "<toRegistrationID>%ld</toRegistrationID>"
//                          "<fileURL>%@</fileURL>"
//                          "<name>%@</name>"
//                          "</ShareMusic>"
//                          "</soap:Body>"
//                          "</soap:Envelope>", myProfile.registrationID, toRegistrationID, path, title];
//        
//        NSLog(@"post = %@", post);
//        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//        
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, cShareMusic]]];
//        [request setHTTPMethod:@"POST"];
//        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        [request setHTTPBody:postData];
//        
//        NSError *error;
//        NSURLResponse *response;
//        NSData *urlData=[NSURLConnection sendSynchronousRequest:request
//                                              returningResponse:&response 
//                                                          error:&error];
//        
//        NSLog(@"=====================");
//        NSString *encodeData=[[NSString alloc]initWithData:urlData
//                                                  encoding:NSUTF8StringEncoding];
//        NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;"
//                                                                withString:@""];
//        
//        //    data1 = [data1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//        //    data1 = [data1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//        
//        NSLog(@"%@", data1);
//        NSLog(@"=====================");
//        
//        NSScanner *scanner = [NSScanner scannerWithString:data1];
//        NSString *startTag = [NSString stringWithFormat:@"<return xsi:type=\"xsd:int\">"];
//        NSString *strResult= nil;
//        
//        [scanner scanUpToString:startTag intoString:nil];
//        [scanner scanString:startTag intoString:nil];
//        [scanner scanUpToString:@"</return>" intoString:&strResult];
//        
//        NSLog(@"return value: %@", strResult);
//        if (strResult) {
//            retVal = [strResult longLongValue];
//        }
//    }
//    return retVal;
//}
//
//- (long)sendCalendarEvent:(long)toRegistrationID :(NSString*)evtTilte :(long) startTime :(long) endTime
//{    
//    long retVal = 0;
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//    } else {
//        NSLog(@"usersAvailable");
//        self.functionName = nil;
//        
//        NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                          "<soap:Body>"
//                          "<SendCalendarEvent xmlns='http://50.19.216.234/palup/server.php'>"
//                          "<fromRegistrationID>%ld</fromRegistrationID>"
//                          "<toRegistrationID>%ld</toRegistrationID>"
//                          "<eventTitle>%@</eventTitle>"
//                          "<eventStartTime>%ld</eventStartTime>"
//                          "<eventEndTime>%ld</eventEndTime>"
//                          "</SendCalendarEvent>"
//                          " </soap:Body>"
//                          "</soap:Envelope>", myProfile.registrationID, toRegistrationID, evtTilte, startTime, endTime];
//        
//        NSLog(@"post = %@", post);
//        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//        
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, cSendCalendarEvent]]];
//        [request setHTTPMethod:@"POST"];
//        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        [request setHTTPBody:postData];
//        
//        NSError *error;
//        NSURLResponse *response;
//        NSData *urlData=[NSURLConnection sendSynchronousRequest:request
//                                              returningResponse:&response 
//                                                          error:&error];
//        
//        NSLog(@"=====================");
//        NSString *encodeData=[[NSString alloc]initWithData:urlData
//                                                  encoding:NSUTF8StringEncoding];
//        NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;"
//                                                                withString:@""];
//        
//        //    data1 = [data1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//        //    data1 = [data1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//        
//        NSLog(@"%@", data1);
//        NSLog(@"=====================");
//        
//        NSScanner *scanner = [NSScanner scannerWithString:data1];
//        NSString *startTag = [NSString stringWithFormat:@"<return xsi:type=\"xsd:int\">"];
//        NSString *strResult= nil;
//        
//        [scanner scanUpToString:startTag intoString:nil];
//        [scanner scanString:startTag intoString:nil];
//        [scanner scanUpToString:@"</return>" intoString:&strResult];
//        
//        NSLog(@"return value: %@", strResult);
//        if (strResult) {
//            retVal = [strResult longLongValue];
//        }
//    }
//    return retVal;
//}
//
//
//- (long)sendLocation:(long)toRegistrationID :(float)longitude :(float) latitude
//{    
//    long retVal = 0; 
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//    } else {
//        NSLog(@"sendLocation");
//        self.functionName = nil;
//        
//        NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                          "<soap:Body>"
//                          "<SendLocation xmlns='http://50.19.216.234/palup/server.php'>"
//                          "<fromRegistrationID>%ld</fromRegistrationID>"
//                          "<toRegistrationID>%ld</toRegistrationID>"
//                          "<longitude>%f</longitude>"
//                          "<latitude>%f</latitude>"
//                          "</SendLocation>"
//                          " </soap:Body>"
//                          "</soap:Envelope>", myProfile.registrationID, toRegistrationID, longitude, latitude];
//        
//        NSLog(@"post = %@", post);
//        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//        
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, cSendLocation]]];
//        [request setHTTPMethod:@"POST"];
//        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        [request setHTTPBody:postData];
//        
//        NSError *error;
//        NSURLResponse *response;
//        NSData *urlData=[NSURLConnection sendSynchronousRequest:request
//                                              returningResponse:&response 
//                                                          error:&error];
//        
//        NSLog(@"=====================");
//        NSString *encodeData=[[NSString alloc]initWithData:urlData
//                                                  encoding:NSUTF8StringEncoding];
//        NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;"
//                                                                withString:@""];
//        
//        //    data1 = [data1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//        //    data1 = [data1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//        
//        NSLog(@"%@", data1);
//        NSLog(@"=====================");
//        
//        NSScanner *scanner = [NSScanner scannerWithString:data1];
//        NSString *startTag = [NSString stringWithFormat:@"<return xsi:type=\"xsd:int\">"];
//        NSString *strResult= nil;
//        
//        [scanner scanUpToString:startTag intoString:nil];
//        [scanner scanString:startTag intoString:nil];
//        [scanner scanUpToString:@"</return>" intoString:&strResult];
//        
//        NSLog(@"return value: %@", strResult);
//        
//        if (strResult) {
//            retVal = [strResult longLongValue];
//        }
//    }
//    
//    return retVal;
//}
//
//
//- (long)forwardMessages:(long)toRegistrationID :(long)msgId
//{    
//    long retVal = 0;
//    
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//    } else {
//        NSLog(@"forwardMessages");
//        self.functionName = nil;
//        
//        NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                          "<soap:Body>"
//                          "<ForwardMessages xmlns='http://50.19.216.234/palup/server.php'>"
//                          "<fromRegistrationID>%ld</fromRegistrationID>"
//                          "<toRegistrationID>%ld</toRegistrationID>"
//                          "<messages>%ld</messages>"
//                          "</ForwardMessages>"
//                          " </soap:Body>"
//                          "</soap:Envelope>", myProfile.registrationID, toRegistrationID, msgId];
//        
//        NSLog(@"post = %@", post);
//        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//        
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, @"ForwardMessages"]]];
//        [request setHTTPMethod:@"POST"];
//        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        [request setHTTPBody:postData];
//        
//        NSError *error;
//        NSURLResponse *response;
//        NSData *urlData=[NSURLConnection sendSynchronousRequest:request
//                                              returningResponse:&response 
//                                                          error:&error];
//        
//        NSLog(@"=====================");
//        NSString *encodeData=[[NSString alloc]initWithData:urlData
//                                                  encoding:NSUTF8StringEncoding];
//        NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;"
//                                                                withString:@""];
//        
//        //data1 = [data1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//        //data1 = [data1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//        
//        NSLog(@"%@", data1);
//        NSLog(@"=====================");
//        
//        NSScanner *scanner = [NSScanner scannerWithString:data1];
//        NSString *startTag = [NSString stringWithFormat:@"<return xsi:type=\"xsd:int\">"];
//        NSString *strResult= nil;
//        
//        [scanner scanUpToString:startTag intoString:nil];
//        [scanner scanString:startTag intoString:nil];
//        [scanner scanUpToString:@"</return>" intoString:&strResult];
//        
//        NSLog(@"return value: %@", strResult);
//        
//        if (strResult) {
//            retVal = [strResult longLongValue];
//        }
//    }
//    return retVal;
//}
//
//-(NSMutableArray*)getOptionElements:(int) iElemID
//{
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet." andTitle:@"PalUp"];
//        
//        return nil;
//    }
//    
//    NSLog(@"usersAvailable");
//    self.functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<ListProfileElementOptions xmlns='http://50.19.216.234/palup/server.php'>"
//                      "<profileElementID>%d</profileElementID>"
//                      "</ListProfileElementOptions>"
//                      "</soap:Body>"
//					  "</soap:Envelope>", iElemID];
//	
//    //    NSLog(@"post = %@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, cListProfileElementOptions]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request
//                                          returningResponse:&response 
//                                                      error:&error];
//    
//    NSLog(@"=====================");
//    NSString *encodeData=[[NSString alloc]initWithData:urlData
//                                              encoding:NSUTF8StringEncoding];
//    NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;"
//                                                            withString:@""];
//    
//    data1 = [data1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//    data1 = [data1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//    
//    //	NSLog(@"%@", data1);
//    NSLog(@"=====================");
//    
//    NSScanner *scanner = [NSScanner scannerWithString:data1];
//    NSString  *strOptElemID = nil;
//    NSString  *strOptElemName = nil;
//    NSMutableArray *optionsArray = [[NSMutableArray alloc] init];
//    
//    while (![scanner isAtEnd]){
//        strOptElemID = nil;
//        strOptElemName = nil;
//        
//        //        NSLog(@"=============================");
//        [scanner scanUpToString:@"<option id=\"" intoString:nil];
//        [scanner scanString:@"<option id=\"" intoString:nil];
//        [scanner scanUpToString:@"\"" intoString:&strOptElemID];
//        //        NSLog(@"EmoticonsID: %@", strEmotID);
//        
//        [scanner scanUpToString:@">" intoString:nil];
//        [scanner scanString:@">" intoString:nil];
//        [scanner scanUpToString:@"</option>" intoString:&strOptElemName];
//        //        NSLog(@"ReplacementText: %@", strRepTxt);
//        
//        if (strOptElemID) {
//            [optionsArray addObject: 
//             [NSMutableDictionary dictionaryWithObjectsAndKeys:
//              strOptElemID, cOptElemID,
//              strOptElemName, cOptElemName, 
//              @"N", cOptElemSel, nil]];
//        }
//	}
//    
//    return optionsArray;
//}
//
//
//- (void)listProfileElements
//{
//    if(![self isConnectToWeb]){
//        [self showAlertWithMessage:@"This device does not connect to Internet."
//                          andTitle:@"PalUp"];
//        
//    }
//    
//    NSLog(@"usersAvailable");
//    self.functionName = nil;
//    
//    NSString *post = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//					  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                      "<soap:Body>"
//                      "<ListProfileElements xmlns='http://50.19.216.234/palup/server.php'>"
//                      "</ListProfileElements>"
//                      "</soap:Body>"
//					  "</soap:Envelope>"];
//	
//    NSLog(@"post = %@", post);
//	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//	
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
//	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@#%@", cServiceLinks, cListProfileElements]]];
//	[request setHTTPMethod:@"POST"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
//    
//	NSError *error;
//	NSURLResponse *response;
//	NSData *urlData=[NSURLConnection sendSynchronousRequest:request
//                                          returningResponse:&response 
//                                                      error:&error];
//    
//    NSLog(@"=====================");
//    NSString *encodeData=[[NSString alloc]initWithData:urlData
//                                              encoding:NSUTF8StringEncoding];
//    NSString *data1 = [encodeData stringByReplacingOccurrencesOfString:@"&lt;?xml version=\"1.0\" encoding=\"utf-8\"?&gt;"
//                                                            withString:@""];
//    
//    data1 = [data1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//    data1 = [data1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//    
//    //	NSLog(@"%@", data1);
//    NSLog(@"=====================");
//    
//    [listFilters removeAllObjects];
//    NSScanner *scanner = [NSScanner scannerWithString:data1];
//    NSString  *strElemID;
//    NSString  *strElemName;
//    NSMutableArray *optArr;
//    
//    while (![scanner isAtEnd]){
//        optArr = nil;
//        strElemID = nil;
//        strElemName = nil;        //        NSLog(@"=============================");
//        [scanner scanUpToString:@"element id=\"" intoString:nil];
//        [scanner scanString:@"element id=\"" intoString:nil];
//        [scanner scanUpToString:@"\">" intoString:&strElemID];
//        //        NSLog(@"EmoticonsID: %@", strEmotID);
//        
//        [scanner scanUpToString:@"<name>" intoString:nil];
//        [scanner scanString:@"<name>" intoString:nil];
//        [scanner scanUpToString:@"</name>" intoString:&strElemName];
//        //        NSLog(@"ReplacementText: %@", strRepTxt);
//        
//        if (strElemID) {
//            optArr =  [self getOptionElements:[strElemID intValue]]; 
//            
//            [listFilters addObject: 
//             [NSMutableDictionary dictionaryWithObjectsAndKeys:
//              strElemID, cElemID,
//              strElemName, cElemName,
//              optArr, cOptElemArr, nil]];
//        }
//        
//	}
//}
//
//
//// Parsing the XML message list
//
//-(void) parserDataReturn
//{
//    NSXMLParser* parser = [[NSXMLParser alloc] initWithData: receivedData];
//    
//    [parser setDelegate:self];
//    if (![parser parse]) {
//        NSLog(@"Error while parsing data!");
//    }
//    
//}
//
//
//- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
//  namespaceURI:(NSString *)namespaceURI 
// qualifiedName:(NSString *)qName 
//    attributes:(NSDictionary *)attributeDict 
//{
//    //    NSLog(@"didStartElement: %@", elementName);
//	if (functionName) {
//        if ( [functionName isEqualToString:cgetQuoteFunc] ) {
//            if ([elementName isEqualToString:cResultTag]) {
//                isResultTag = YES;
//            }
//            NSLog(@"%@", elementName);
//        } else if ( [functionName isEqualToString:cCheckForMessagesFunc] ) {
//            if ([elementName isEqualToString:@"message"]) {
//                self.resultStr = [NSString stringWithString:[attributeDict valueForKey:@"message"] ];
//            }
//        } else if ( [functionName isEqualToString:cWorkQueueFunc] ) {
//            
//        } else if ( [functionName isEqualToString:cRegistrationCreateFunc] ) {
//            if ([elementName isEqualToString:cReturnTag]) {
//                isResultTag = YES;
//            }
//        } else if ( [functionName isEqualToString:cListInterestsFunc] ) {
//            
//        } else if ( [functionName isEqualToString:cRegistrationAddInterestFunc] ) {
//            
//        } else if ( [functionName isEqualToString:cListContacts2Func] ) {
//            if ( [elementName isEqualToString:@"contact"] ) {
//                isContentMsgs = YES;
//                self.strContactID = [attributeDict valueForKey:@"id"];
//            } else if ( [elementName isEqualToString:cCL2ContactTypeID] ) {
//                idxMsg = 1;
//                self.strContactTypeID = @"";
//            } else if ( [elementName isEqualToString:cCL2AvatarURL] ) {
//                idxMsg = 2;
//                self.strAvatarURL = @"";
//            } else if ( [elementName isEqualToString:cCL2ContactType] ) {
//                idxMsg = 3;
//                self.strContactType = @"";
//            } else if ( [elementName isEqualToString:cCL2ContactName] ) {
//                idxMsg = 4;
//                self.strContactName = @"";
//            } else if ( [elementName isEqualToString:cCL2CreateDT] ) {
//                idxMsg = 5;
//                //                self.strCreateDT = @"";
//            } else if ( [elementName isEqualToString:cCL2OnlineStatus] ) {
//                idxMsg = 6;
//                self.strStatus = @"";
//            }  else if ( [elementName isEqualToString:cCL2WithinMiles] ) {
//                idxMsg = 7;
//                self.strMiles = @"";
//            } 
//        } else if ( [functionName isEqualToString:cRegistrationLoginFunc] ) {
//            if ([elementName isEqualToString:cReturnTag]) {
//                isResultTag = YES;
//            }
//        } else if ( [functionName isEqualToString:cRegistrationStatusFunc] ) {
//            
//        } else if ( [functionName isEqualToString:cRegistrationSignOutFunc] ) {
//            
//        } else if ( [functionName isEqualToString:cRegistrationChangeStatusFunc] ) {
//            
//        } else if ( [functionName isEqualToString:cListRegistrationStatusesFunc] ) {
//            
//        } else if ( [functionName isEqualToString:cListGiftsFunc] ) {
//            if ( [elementName isEqualToString:cGifts] ) {
//                isContentMsgs = YES;
//            } else if ( [elementName isEqualToString:cGift] ) {
//                idxMsg = 1;
//                self.strGiftID = [attributeDict valueForKey:cGiftID];          
//            } else if ( [elementName isEqualToString:cGiftName] ) {
//                idxMsg = 2;
//                self.strGiftName = nil;      
//            } else if ( [elementName isEqualToString:cGiftImgURL] ) {
//                idxMsg = 3;
//                self.strGiftImgURL = nil;
//            }
//        } else if ( [functionName isEqualToString:cSendMessageFunc] ) {
//            
//        } else if ( [functionName isEqualToString:cAddContactFunc] ) {
//            
//        } else if ( [functionName isEqualToString:cRemoveContactFunc] ) {
//            
//        } else if ( [functionName isEqualToString:cBlockContactFunc] ) {
//            
//        } else if ( [functionName isEqualToString:cGiftContactFunc] ) {
//            
//        } else if ( [functionName isEqualToString:cEditProfileFunc] ) {
//            if ([elementName isEqualToString:cReturnTag]) {
//                isResultTag = YES;
//            }
//        }
//        else if ( [functionName isEqualToString:cRemoveRegistrationProfileElement] ) {
//            if ([elementName isEqualToString:cReturnTag]) {
//                isResultTag = YES;
//            }
//        }
//        else if ( [functionName isEqualToString:cAddRegistrationProfileElement] ) {
//            if ([elementName isEqualToString:cReturnTag]) {
//                isResultTag = YES;
//            }
//        }
//        /*else if ( [functionName isEqualToString:cListEmoticonsFunc] ) {
//         if ( [elementName isEqualToString:cEmoticon] ) {
//         isContentMsgs = YES;
//         } else if ( [elementName isEqualToString:cEmoticonsID] ) {
//         idxMsg = 1;
//         self.strEmoticonsID = nil;          
//         } else if ( [elementName isEqualToString:cReplacementText] ) {
//         idxMsg = 2;
//         self.strReplacementText = nil;      
//         } else if ( [elementName isEqualToString:cImageURL] ) {
//         idxMsg = 3;
//         self.strImageURL = nil;
//         } else if ( [elementName isEqualToString:cDisplayName] ) {
//         idxMsg = 4;
//         self.strDisplayName = nil;
//         } 
//         }*/
//    } else {
//        if ( [elementName isEqualToString:cgetQuoteResp] ) {
//            functionName = cgetQuoteFunc;
//        } /*else if ( [elementName isEqualToString:cCheckForMessagesResp] ) {
//           functionName = cCheckForMessagesFunc;
//           } */else if ( [elementName isEqualToString:cWorkQueueResp] ) {
//               functionName = cWorkQueueFunc;
//           } else if ( [elementName isEqualToString:cRegistrationCreateResp] ) {
//               functionName = cRegistrationCreateFunc;
//           } else if ( [elementName isEqualToString:cListInterestsResp] ) {
//               functionName = cListInterestsFunc;
//           } else if ( [elementName isEqualToString:cRegistrationAddInterestResp] ) {
//               functionName = cRegistrationAddInterestFunc;
//           } else if ( [elementName isEqualToString:cListContacts2Resp] ) {
//               functionName = cListContacts2Func;
//           } else if ( [elementName isEqualToString:cRegistrationLoginResp] ) {
//               functionName = cRegistrationLoginFunc;
//           } else if ( [elementName isEqualToString:cRegistrationStatusResp] ) {
//               functionName = cRegistrationStatusFunc;
//           } else if ( [elementName isEqualToString:cRegistrationSignOutResp] ) {
//               functionName = cRegistrationSignOutFunc;
//           } else if ( [elementName isEqualToString:cRegistrationChangeStatusResp] ) {
//               functionName = cRegistrationChangeStatusFunc;
//           } else if ( [elementName isEqualToString:cListRegistrationStatusesResp] ) {
//               functionName = cListRegistrationStatusesFunc;
//           } else if ( [elementName isEqualToString:cListGiftsResp] ) {
//               functionName = cListGiftsFunc;
//           } else if ( [elementName isEqualToString:cSendMessageResp] ) {
//               functionName = cSendMessageFunc;
//           } else if ( [elementName isEqualToString:cAddContactResp] ) {
//               functionName = cAddContactFunc;
//           } else if ( [elementName isEqualToString:cRemoveContactResp] ) {
//               functionName = cRemoveContactFunc;
//           } else if ( [elementName isEqualToString:cBlockContactResp] ) {
//               functionName = cBlockContactFunc;
//           } else if ( [elementName isEqualToString:cGiftContactResp] ) {
//               functionName = cGiftContactFunc;
//           } /*else if ( [elementName isEqualToString:cListEmoticonsResp] ){
//              functionName = cListEmoticonsFunc;
//              }*/
//        
//    }
//    
//}
//
//// parser for results which they return from server. Please see more help from Apple
//- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
//{
//    //    NSLog(@"foundCharacters: %@", string);
//    if ( [functionName isEqualToString:cgetQuoteFunc] ) {
//        
//    } /*else if ( [functionName isEqualToString:cCheckForMessagesFunc] ) {
//       if (isResultTag) {
//       self.resultStr = [[NSString alloc] initWithString: string];
//       } 
//       NSLog(@"%@", string);
//       }*/ else if ( [functionName isEqualToString:cWorkQueueFunc] ) {
//           
//       } else if ( [functionName isEqualToString:cRegistrationCreateFunc] ) {
//           if (isResultTag) {
//               myProfile.registrationID = [string longLongValue]; 
//           }
//       } else if ( [functionName isEqualToString:cListInterestsFunc] ) {
//           
//       } else if ( [functionName isEqualToString:cRegistrationAddInterestFunc] ) {
//           
//       } else if ( [functionName isEqualToString:cListContacts2Func] ) {
//           if (idxMsg == 1) {
//               self.strContactTypeID = string;          
//           } else if (idxMsg == 2) {
//               self.strAvatarURL = string;      
//           } else if (idxMsg == 3) {
//               self.strContactType = string;
//           } else if (idxMsg == 4) {
//               self.strContactName = string;
//           } else if (idxMsg == 5) {
//               //            self.strCreateDT = string;
//           } else if (idxMsg == 6) {
//               self.strStatus = string;
//           } else if (idxMsg == 7) {
//               self.strMiles = string;
//           }
//       } else if ( [functionName isEqualToString:cRegistrationLoginFunc] ) {
//           if (isResultTag) {
//               //myProfile.registrationID = [string longLongValue];
//               myProfile.registrationID = [string longLongValue];
//           }        
//       } else if ( [functionName isEqualToString:cRegistrationStatusFunc] ) {
//           
//       } else if ( [functionName isEqualToString:cRegistrationSignOutFunc] ) {
//           
//       } else if ( [functionName isEqualToString:cRegistrationChangeStatusFunc] ) {
//           
//       } else if ( [functionName isEqualToString:cListRegistrationStatusesFunc] ) {
//           
//       } else if ( [functionName isEqualToString:cListGiftsFunc] ) {
//           if (idxMsg == 2) {
//               self.strGiftName = string;          
//           } else if (idxMsg == 3) {
//               self.strGiftImgURL = string;      
//           }
//       } else if ( [functionName isEqualToString:cSendMessageFunc] ) {
//           
//       } else if ( [functionName isEqualToString:cAddContactFunc] ) {
//           
//       } else if ( [functionName isEqualToString:cRemoveContactFunc] ) {
//           
//       } else if ( [functionName isEqualToString:cBlockContactFunc] ) {
//           
//       } else if ( [functionName isEqualToString:cGiftContactFunc] ) {
//           
//       }
//       else if ( [functionName isEqualToString:cEditProfileFunc] ) {
//           if (isResultTag) {
//               parseResult = [string longLongValue]; 
//               NSLog(@"parseResult: %d", parseResult);
//           }
//       }
//       else if ( [functionName isEqualToString:cRemoveRegistrationProfileElement] ) {
//           if (isResultTag) {
//               parseResult = [string longLongValue]; 
//               NSLog(@"parseResult: %d", parseResult);
//           }
//       }
//       else if ( [functionName isEqualToString:cAddRegistrationProfileElement] ) {
//           if (isResultTag) {
//               parseResult = [string longLongValue]; 
//               NSLog(@"parseResult: %d", parseResult);
//           }
//       }
//    /*else if ( [functionName isEqualToString:cListEmoticonsFunc] ){
//     if (idxMsg == 1) {
//     self.strEmoticonsID = string;          
//     } else if (idxMsg == 2) {
//     self.strReplacementText = string;      
//     } else if (idxMsg == 3) {
//     self.strImageURL = string;
//     } else if (idxMsg == 4) {
//     self.strDisplayName = string;
//     }        
//     }*/
//}
//
//// parser for results which they return from server. Please see more help from Apple
//- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
//{
//    //    NSLog(@"didEndElement: %@", elementName);
//    if ( [elementName isEqualToString:cgetQuoteFunc] ) {
//	} else if ( [functionName isEqualToString:cCheckForMessagesFunc] ) {
//	} else if ( [functionName isEqualToString:cWorkQueueFunc] ) {
//	} else if ( [functionName isEqualToString:cRegistrationCreateFunc] ) {
//	} else if ( [functionName isEqualToString:cListInterestsFunc] ) {
//	} else if ( [functionName isEqualToString:cRegistrationAddInterestFunc] ) {
//	} else if ( [functionName isEqualToString:cListContacts2Func] ) {
//        if ( [elementName isEqualToString:@"contact"] ) {
//            isContentMsgs = NO;
//            if(myProfile.registrationID != [strContactID longLongValue]){
//                int contactTypeID = [strContactTypeID intValue];
//                if ( (contactTypeID != 4) && 
//                    (contactTypeID != 5) ) {
//                    [listContact2 addObject: 
//                     [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                      strContactID, cCL2ID,
//                      strContactTypeID, cCL2ContactTypeID,
//                      strAvatarURL, cCL2AvatarURL, 
//                      strContactType, cCL2ContactType, 
//                      strContactName, cCL2ContactName, 
//                      //                      strCreateDT, cCL2CreateDT,
//                      strStatus, cCL2OnlineStatus,
//                      strMiles, cCL2WithinMiles,
//                      nil]];
//                }
//            }
//        } else if ([elementName isEqualToString:@"listContacts"]) {
//            // Notify that did to parse for data of ListContacts2
//            self.listContact2Items = listContact2;
//            [[NSNotificationCenter defaultCenter] postNotificationName:cListContacts2Func object:nil]; 
//        }
//	} else if ( [functionName isEqualToString:cRegistrationLoginFunc] ) {
//	} else if ( [functionName isEqualToString:cRegistrationStatusFunc] ) {
//	} else if ( [functionName isEqualToString:cRegistrationSignOutFunc] ) {
//	} else if ( [functionName isEqualToString:cRegistrationChangeStatusFunc] ) {
//	} else if ( [functionName isEqualToString:cListRegistrationStatusesFunc] ) {
//	} else if ( [functionName isEqualToString:cListGiftsFunc] ) {        
//        if ( [elementName isEqualToString:cGift] ) {
//            NSLog(@"strGiftID=%@, strGiftName=%@, strGiftImgURL=%@", strGiftID, strGiftName, strGiftImgURL);
//            isContentMsgs = NO;
//            [listGift addObject: 
//             [NSDictionary dictionaryWithObjectsAndKeys: strGiftID, cGiftID,
//              strGiftName, cGiftName,
//              strGiftImgURL, cGiftImgURL, nil]];
//        }
//	} else if ( [functionName isEqualToString:cSendMessageFunc] ) {
//	} else if ( [functionName isEqualToString:cAddContactFunc] ) {
//	} else if ( [functionName isEqualToString:cRemoveContactFunc] ) {
//	} else if ( [functionName isEqualToString:cBlockContactFunc] ) {
//	} else if ( [functionName isEqualToString:cGiftContactFunc] ) {
//	} /*else if ( [functionName isEqualToString:cListEmoticonsFunc] ){
//       if ( [elementName isEqualToString:cEmoticon] ) {
//       isContentMsgs = NO;
//       [emotionIconsList addObject: 
//       [NSDictionary dictionaryWithObjectsAndKeys: strEmoticonsID, cEmoticonsID,
//       strReplacementText, cReplacementText,
//       strImageURL, cImageURL,                                                         
//       strDisplayName, cDisplayName, nil]];
//       } //else if ([elementName isEqualToString:cEmoticons]) {
//       // Notify that did to parse for data of CheckForMessagesFunc
//       [[NSNotificationCenter defaultCenter] postNotificationName:cSearchContactByMaskFunc object:nil]; 
//       } //
//       }*/
//}
//
@end
