//
//  RequestNetwork.m
//  flashShopping
//
//  Created by Width on 14-1-22.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "RequestNetwork.h"
#import "ASIFormDataRequest.h"

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
- (void)requestNetwork:(NSString*)postString
{
   
    NSURL *url = [NSURL URLWithString:
                  @"http://192.168.1.83:9000/Assistant/app"];
    ASIFormDataRequest  *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    
     NSString *msgLength = [NSString stringWithFormat:@"%d", [postString length]];
    [request addRequestHeader:@"application/json" value:@"Content-Type"];
    [request addRequestHeader:@"Content-Length" value: msgLength];
    [request setRequestMethod:@"POST"];
    [request appendPostData:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [request startSynchronous];
    

}
- (void)requestStarted:(ASIHTTPRequest *)request
{
     receiveData = [NSMutableData new];
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
   // NSString *receiveStr = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"getData" object:receiveData];
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
