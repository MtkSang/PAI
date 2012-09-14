//
//  StatusUpdatesViewController.m
//  Postadvert
//
//  Created by Mtk Ray on 7/4/12.
//  Copyright (c) 2012 Futureworkz. All rights reserved.
//

#import "StatusUpdatesViewController.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "TouchXML.h"
#import "UserPAInfo.h"
#import "NSData+Base64.h"
@interface StatusUpdatesViewController ()

@end

@implementation StatusUpdatesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self performSelectorInBackground:@selector(getData) withObject:nil];
    //[self performSelectorInBackground:@selector(getdataFromLink) withObject:nil];
    [self performSelectorInBackground:@selector(sendDataFromWS2) withObject:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void) getdataFromLink
{
    NSLog(@"get data from Link");
    NSMutableData *data = [NSMutableData dataWithContentsOfURL:[NSURL URLWithString:@"http://postadvert.com/Webservice/Client_Soap.php"]];
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    
    jsonStringData = [[NSString alloc]init];
    NSLog(@"DATALink :%@", doc);
    NSArray *nodes = NULL;
    //  searching for return nodes (return from WS)
    nodes = [doc nodesForXPath:@"//STR_Revert" error:nil];
    
    for (CXMLElement *node in nodes) {
        jsonStringData = [node.stringValue copy];
        NSLog(@"node %@", node.stringValue);
        
    }        
}

-(void) getData
{
   // NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://postadvert.com/Webservice/Client_Soap.php"]];
    //NSLog(@"data :%@",data.description);
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://postadvert.com/Webservice/Client_Soap.php"]];
    NSURLConnection *connect = [[NSURLConnection alloc]initWithRequest:theRequest delegate:self];
    if (connect) {
        NSLog(@"Connection OK");
        webData = [[NSMutableData alloc]init];
        
    }
    else {
        NSLog(@"No Connection established");
    }    
}

/*
"http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tns="urn:fwzserverwsdl" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns="http://schemas.xmlsoap.org/wsdl/" targetNamespace="urn:fwzserverwsdl"
*/

/*
 [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
 "<soap:Body>"
 "<RegistrationCreate xmlns='http://50.19.216.234/palup/server.php'>"
 "<userName>%@</userName>"
 "<password>%@</password>"
 "<email>%@</email>"
 "</RegistrationCreate>"
 "</soap:Body>"
 "</soap:Envelope>",
 
 */



/*
 POST /fwz_service/fwz_server_wsdl.php HTTP/1.0
 Host: jmobile.futureworkz.com.sg
 User-Agent: NuSOAP/0.9.5 (1.123)
 Content-Type: text/xml; charset=ISO-8859-1
 SOAPAction: "urn:http://jmobile.futureworkz.com.sg/fwz_service/#hello"
 Content-Length: 555
 
 <?xml version="1.0" encoding="ISO-8859-1"?>
 <SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" 
 xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
 xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
 xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" 
 xmlns:tns="urn:fwzserverwsdl">
 <SOAP-ENV:Body>
 <tns:hello xmlns:tns="urn:fwzserverwsdl">
 <name xsi:type="xsd:string">Scott</name>
 <age xsi:type="xsd:string">25</age>
 </tns:hello>
 </SOAP-ENV:Body>
 </SOAP-ENV:Envelope>

 
 //////
 
 POST /iptocountry.asmx HTTP/1.1
 Host: www.ecubicle.net
 Content-Type: text/xml; charset=utf-8
 Content-Length: length
 SOAPAction: "http://www.ecubicle.net/webservices/FindCountryAsXml"
 <?xml version="1.0" encoding="utf-8"?>
 <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
 <soap:Body>
 <FindCountryAsXml xmlns="http://www.ecubicle.net/webservices/">
 <V4IPAddress>string</V4IPAddress>
 </FindCountryAsXml>
 </soap:Body>
 </soap:Envelope>
 
 //////
 The URL for the web service is http://www.ecubicle.net/iptocountry.asmx.
 The URL for the SOAPAction attribute is http://www.ecubicle.net/webservices/FindCountryAsXml.
 The Content-Type for the request is text/xml; charset=utf-8.
 The HTTP method is POST.
 The SOAP request is shown below:

 NSString *soapMsg =
 [NSString stringWithFormat:
 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
 "<soap:Envelope
 xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
 xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"
 xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
 "<soap:Body>"
 "<FindCountryAsXml
 xmlns=\"http://www.ecubicle.net/webservices/\">"
 "<V4IPAddress>%@</V4IPAddress>"
 "</FindCountryAsXml>"
 "</soap:Body>"
 "</soap:Envelope>", ipAddress.text
 ];
 Next, you create a URL load request object using instances of the NSMutableURLRequest and NSURL objects:
 
 NSURL *url = [NSURL URLWithString:
 @"http://www.ecubicle.net/iptocountry.asmx"];
 NSMutableURLRequest *req =
 [NSMutableURLRequest requestWithURL:url];
 You then populate the request object with the various headers, such as Content-Type, SOAPAction, and Content-Length. You also set the HTTP method and HTTP body:
 
 NSString *msgLength =
 [NSString stringWithFormat:@"%d", [soapMsg length]];
 [req addValue:@"text/xml; charset=utf-8"
 forHTTPHeaderField:@"Content-Type"];
 [req addValue:@"http://www.ecubicle.net/webservices/FindCountryAsXml"
 forHTTPHeaderField:@"SOAPAction"];
 [req addValue:msgLength
 forHTTPHeaderField:@"Content-Length"];
 [req setHTTPMethod:@"POST"];
 [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
 urn:fwzserverwsdl
 
 
 <?xml version="1.0" encoding="utf-8"?>
 <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
 <soap:Body>
 <hello xmlns="http://jmobile.futureworkz.com.sg/fwz_service/">
 <name>Anthony</name><
 age>25</age>
 </hello>
 </soap:Body>
 </soap:Envelope>
 
 
 <?xml version="1.0" encoding="utf-8"?>
 <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
 <soap:Body>
 <hello xmlns="http://jmobile.futureworkz.com.sg/fwz_service/">
 <name>Anthony</name>
 <age>25</age>
 </hello>
 </soap:Envelope>
 */
-(void) getDataFromWS{
    NSString *soapFormat = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                            @"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                            @"<soap:Body>"
                            @"<hello xmlns=\"http://jmobile.futureworkz.com.sg/fwz_service/\">"
                            @"<name>%@</name><"
                            @"age>%@</age>"
                            @"</hello>"
                            @"</soap:Body>"
                            @"</soap:Envelope>",@"Ray", @"25"];
                                                

        
                            
                            
    NSLog(@"The request format is: \n%@",soapFormat); 
    
    NSURL *locationOfWebService = [NSURL URLWithString:@"http://jmobile.futureworkz.com.sg/fwz_service/fwz_server_wsdl.php"];//http://jmobile.futureworkz.com.sg/fwz_service/fwz_server_wsdl.php?wsdl
    
    NSLog(@"web url = %@",locationOfWebService);
    
    theRequest = [[NSMutableURLRequest alloc]initWithURL:locationOfWebService];// cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4];
                                    
    NSString *msgLength = [NSString stringWithFormat:@"%d",[soapFormat length]];
    
    
    [theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:@"http://jmobile.futureworkz.com.sg/fwz_service/hello" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    //the below encoding is used to send data over the net
    [theRequest setHTTPBody:[soapFormat dataUsingEncoding:NSUTF8StringEncoding]];
    
    myConnect = [[NSURLConnection alloc]initWithRequest:theRequest delegate:self startImmediately:YES];

    if (myConnect) {
        NSLog(@"Connection OK");
        webData = [[NSMutableData alloc]init];
        
    }
    else {
        NSLog(@"No Connection established");
    }   
    
    NSURLResponse *response;
    NSError *error;	
    NSData *data = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    
    NSLog(@"data : %@ ;respond: %@ ;error %@; data:%@",data.description, response.description, error, [data JSONRepresentation]);
    NSString *results = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]; 
    NSLog(@"%@",results);
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    NSLog(@"DATA :%@", doc);
    NSArray *nodes = NULL;
    //  searching for return nodes (return from WS)
    nodes = [doc nodesForXPath:@"//return" error:nil];
    
    for (CXMLElement *node in nodes) {
        jsonStringData = [node.stringValue copy];
        NSLog(@"node %@", node.stringValue);
        
    }
}
/*
 login_type = email or username
 login_name
 login_password
 */
-(void) getDataFromWS2{
    NSString *soapFormat = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                            @"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                            @"<soap:Body>"
                            @"<login xmlns=\"http://postadvert.com/ws/server_side/\">"
                            @"<login_name>%@</login_name>"
                            @"<login_password>%@</login_password>"
                            @"</login>"
                            @"</soap:Body>"
                            @"</soap:Envelope>",@"thomas", @"123456"];
    
    
    
    
    
    NSLog(@"The request format is: \n%@",soapFormat); 
    
    NSURL *locationOfWebService = [NSURL URLWithString:@"http://postadvert.com/ws/server_side/user_wsdl.php"];//http://jmobile.futureworkz.com.sg/fwz_service/fwz_server_wsdl.php?wsdl
    
    NSLog(@"web url = %@",locationOfWebService);
    
    theRequest = [[NSMutableURLRequest alloc]initWithURL:locationOfWebService];// cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d",[soapFormat length]];
    
    
    [theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:@"" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    //the below encoding is used to send data over the net
    [theRequest setHTTPBody:[soapFormat dataUsingEncoding:NSUTF8StringEncoding]];
    
    myConnect = [[NSURLConnection alloc]initWithRequest:theRequest delegate:self startImmediately:YES];
    
    if (myConnect) {
        NSLog(@"Connection OK");
        webData = [[NSMutableData alloc]init];
        
    }
    else {
        NSLog(@"No Connection established");
    }   
    
    NSURLResponse *response;
    NSError *error;	
    NSData *data = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    
    NSLog(@"data : %@ ;respond: %@ ;error %@; data:%@",data.description, response.description, error, [data JSONRepresentation]);
    NSString *results = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]; 
    NSLog(@"%@",results);
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    NSLog(@"DATA :%@", doc);
    NSArray *nodes = NULL;
    //  searching for return nodes (return from WS)
    nodes = [doc nodesForXPath:@"//return" error:nil];
    
    for (CXMLElement *node in nodes) {
        jsonStringData = [node.stringValue copy];
        NSLog(@"node %@", jsonStringData);
        
    }
    NSLog(@"Json %@", [jsonStringData JSONRepresentation]);
    //Get info
    SBJsonParser *jsonParser = [[SBJsonParser alloc]init];    
    id vendors = [jsonParser objectWithString:jsonStringData];
    NSDictionary *info;
    if ([vendors isKindOfClass:[NSDictionary class]])
    {
        NSLog(@"Dictionary %@", vendors);
        info = [NSDictionary dictionaryWithDictionary: vendors];
    }
    else if ([vendors isKindOfClass:[NSArray class]])  
    {
        NSLog(@"Array %@", vendors);        
    }
        
    NSString *base64Str = [[info objectForKey:@"info"] objectForKey:@"thumb"];
    NSData *imageData = [NSData dataFromBase64String:base64Str];
                         
    UIImage *image = [UIImage imageWithData:imageData];
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:imgView];
                           
}
-(void) sendDataFromWS2{
    
    UIImage *image = [UIImage imageNamed:@"temp1.jpg"];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    NSString *encodedImage = [imageData base64EncodedString];
    
    NSString *soapFormat = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                            @"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                            @"<soap:Body>"
                            @"<getImageFromDevices xmlns=\"http://postadvert.com/ws/server_side/\">"
                            @"<image_string>%@</image_string>"
                            @"</getImageFromDevices>"
                            @"</soap:Body>"
                            @"</soap:Envelope>",encodedImage];
    
    
    
    
    
    NSLog(@"The request format is: \n%@",soapFormat); 
    
    NSURL *locationOfWebService = [NSURL URLWithString:@"http://postadvert.com/ws/server_side/user_wsdl.php"];//http://jmobile.futureworkz.com.sg/fwz_service/fwz_server_wsdl.php?wsdl
    
    NSLog(@"web url = %@",locationOfWebService);
    
    theRequest = [[NSMutableURLRequest alloc]initWithURL:locationOfWebService];// cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d",[soapFormat length]];
    
    
    [theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:@"" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    //the below encoding is used to send data over the net
    [theRequest setHTTPBody:[soapFormat dataUsingEncoding:NSUTF8StringEncoding]];
    
    myConnect = [[NSURLConnection alloc]initWithRequest:theRequest delegate:self startImmediately:YES];
    
    if (myConnect) {
        NSLog(@"Connection OK");
        webData = [[NSMutableData alloc]init];
        
    }
    else {
        NSLog(@"No Connection established");
    }   
    
    NSURLResponse *response;
    NSError *error;	
    NSData *data = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    
    NSLog(@"data : %@ ;respond: %@ ;error %@; data:%@",data.description, response.description, error, [data JSONRepresentation]);
    NSString *results = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]; 
    NSLog(@"%@",results);
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    NSLog(@"DATA :%@", doc);
    NSArray *nodes = NULL;
    //  searching for return nodes (return from WS)
    nodes = [doc nodesForXPath:@"//return" error:nil];
    
    for (CXMLElement *node in nodes) {
        jsonStringData = [node.stringValue copy];
        NSLog(@"node %@", jsonStringData);
        
    }
}


-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response {
    [webData setLength: 0];
}

-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data 
{ 
   [webData appendData:data];
}

-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *) error {
    webData = nil;
    connection = nil;
}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection 
{ 
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:webData options:0 error:nil];
    jsonStringData = [[NSString alloc]init];
    NSLog(@"DATA :%@", doc);
    NSArray *nodes = NULL;
    //  searching for return nodes (return from WS)
    nodes = [doc nodesForXPath:@"//return" error:nil];
    
    for (CXMLElement *node in nodes) {
        jsonStringData = [node.stringValue copy];
        NSLog(@"node %@", node.stringValue);
        
    }                                                                               
    //  [activityIndicator stopAnimating];                                                                                                                                        
    
//    
//    SBJsonParser *jsonParser = [[SBJsonParser alloc]init];    
//    NSMutableArray *pos = [jsonParser objectWithString:jsonStringData];
//    [jsonParser release];
//    
//    [listContent removeAllObjects];
//    [listPOsID removeAllObjects];
//    for (NSDictionary *po in pos) {
//        NSLog(@"ID :%@ NAME: %@", [po objectForKey:@"id"], [po objectForKey:@"po_number"]);
//        [listContent addObject:[po objectForKey:@"po_number"]];
//        [listPOsID addObject:[po objectForKey:@"id"]];
//        
//    }
//    [myTable reloadData];
//    NSLog(@"Count %d", listContent.count);
    
    
    
}


@end
