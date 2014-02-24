//
//  RequestNetwork.h
//  flashShopping
//
//  Created by Width on 14-1-22.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@interface RequestNetwork : NSObject < ASIHTTPRequestDelegate , NSURLConnectionDataDelegate>

@property ( nonatomic , retain ) NSMutableData *receiveData ;

+ (RequestNetwork*)shareManager;                    //单例
- (void)requestNetwork:(NSString*)postString ;    //post 参数

@end
