//
//  ChatViewController.m
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "ChatViewController.h"
#import "PullNenu.h"


@interface ChatViewController ()<NSURLConnectionDelegate>
{
    UITableView *testView ;
    NSMutableData *receiveData ;
}
@end

@implementation ChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = @"闪聊";

    [self post];
    
   
}
- (void)post
{
   // http://192.168.1.16:8080/Assistant/app
   // NSString *postString =@"{\"companyId\":\"\",\"createDate\":\"\",\"descs\":\"\",\"goodsCode\":\"\",\"id\":\"\",\"limit\":10,\"marketPrice\":\"\",\"merchantCode\":\"\",\"name\":\"\",\"num\":\"\",\"page\":1,\"price\":\"\",\"productId\":\"\",\"sellCount\":\"\",\"state\":\"\"}";
    NSString *postString =@"{\"actionCode\":\"21\",\"appType\":\"json\",\"companyId\":\"00000101\",\"username\":\"shanghu2\",\"password\":\"ak47\"}";
    
    NSURL *url = [NSURL URLWithString:
                  @"http://192.168.1.83:9000/Assistant/app"];//http://192.168.1.83:9000
                  NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
                  NSString *msgLength = [NSString stringWithFormat:@"%d", [postString length]];
                  [req addValue:@"application/html"
             forHTTPHeaderField:@"Content-Type"];
                  [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
                  [req setHTTPMethod:@"POST"];
                  [req setHTTPBody: [postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
                NSURLConnection  *conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
                  if (conn) {    
                      receiveData = [NSMutableData new];
                  }
}
//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    NSLog(@"%@",[res allHeaderFields]);
    
    
}
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receiveData appendData:data];
}
//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *receiveStr = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",receiveStr);
}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection
 didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGRect frame = testView.frame ;
    frame.size.height = 10;
    testView.tableHeaderView = [[UIView alloc]initWithFrame:frame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
