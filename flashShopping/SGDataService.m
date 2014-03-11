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
        NSString *jsonStr = [[jsonWriter stringWithObject:dictparams]URLEncodedString];
        
        NSMutableString *mutableStr =[NSMutableString stringWithString:jsonStr];
        NSRange range = NSMakeRange(0, [mutableStr length]);
        [mutableStr replaceOccurrencesOfString:@"%20" withString:@"+" options:NSCaseInsensitiveSearch range:range];
        
        [request appendPostData:[mutableStr dataUsingEncoding:NSUTF8StringEncoding ]];
        
        
    }
    //请求完成的block
    [request setCompletionBlock:^{
        NSString *getStr = [[request responseString] URLDecodedString];
        //json解析（ios5以后NSJSONSerialization）
        id result = [NSJSONSerialization JSONObjectWithData:[getStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
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
