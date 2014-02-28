//
//  RequestNetwork.m
//  flashShopping
//
//  Created by Width on 14-1-22.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "RequestNetwork.h"
#import "ASIFormDataRequest.h"
#import "NSString+URLEncoding.h"
#import "NSNumber+Message.h"

#define BASEURL @"http://192.168.1.83:9000/Assistant/app"
@implementation RequestNetwork
@synthesize receiveData = receiveData ;


+ (RequestNetwork*)shareManager
{
    static RequestNetwork *requestNetwork = nil ;
    dispatch_once ;
    static dispatch_once_t  onceToken ;
    dispatch_once ( & onceToken,^{
        if (requestNetwork == nil) {
            requestNetwork = [[ RequestNetwork alloc]init];
        }
    });
    return requestNetwork ;
}
- (void)requestNetwork:(NSString*)postString noteName:(NSString *)n_name
{
    noteName = n_name ;
    NSURL *url = [NSURL URLWithString:[BASEURL URLEncodedString]];
    ASIFormDataRequest  *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    
     NSString *msgLength = [NSString stringWithFormat:@"%d", [postString length]];
    [request addRequestHeader:@"application/json;charset=utf-8 " value:@"Content-Type"];
    [request addRequestHeader:@"Content-Length" value: msgLength];
    [request setRequestMethod:@"POST"];
    [request setResponseEncoding:NSUTF8StringEncoding];
    [request appendPostData:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [request startSynchronous];

}
- (void)requestStarted:(ASIHTTPRequest *)request
{
     receiveData = [NSMutableData new];
  
    
}
- (void)requestFinished:(ASIHTTPRequest *)request ;
{
   // NSString *receiveStr = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:noteName object:receiveData];
  // NSLog(@"%@",receiveStr);
    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"%s",__func__);
   
}
- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
{
    [receiveData appendData:data];
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
