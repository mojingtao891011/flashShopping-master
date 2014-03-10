//
//  SGDataService.m
//  ASIService
//
//  Created by Width on 14-2-28.
//  Copyright (c) 2014年 mojingtao. All rights reserved.
//

#import "SGDataService.h"
#import "NSString+URLEncoding.h"
#import "NSNumber+Message.h"
#import "SBJsonWriter.h"

@implementation SGDataService

+(ASIHTTPRequest*)requestWithUrl:(NSString *)urlString dictParams:(NSMutableDictionary *)dictparams httpMethod:(NSString *)httpMethod completeBlock:(requestFinishBlock)block
{
    NSURL *url = [NSURL URLWithString:[urlString URLEncodedString]];
    __unsafe_unretained ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setTimeOutSeconds:60];
    [request setRequestMethod:httpMethod];
    NSComparisonResult comparRet = [httpMethod caseInsensitiveCompare:@"POST"];
    if (comparRet == NSOrderedSame) {
        SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
        NSString *jsonStr = [jsonWriter stringWithObject:dictparams];
        [request appendPostData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];

    }
    //请求完成的block
    [request setCompletionBlock:^{
        NSData *data = [request responseData];
        //json解析（ios5以后NSJSONSerialization）
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",result);
        if (block != nil) {
            block(result);
        }
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        block([error localizedDescription]);
    }];
    [request startAsynchronous];
    return nil ;
}

@end
