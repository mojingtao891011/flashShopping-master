//
//  ChatViewController.m
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "ChatViewController.h"
#import "PullNenu.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJsonWriter.h"

@interface ChatViewController ()<NSURLConnectionDelegate , ASIHTTPRequestDelegate>
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
    
    
     //NSString *postString =@"{\"actionCode\":\"441\",\"appType\":\"json\",\"companyId\":\"00000101\"}";
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"441",@"actionCode",@"json",@"appType",@"00000101",@"companyId", nil];
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    
    NSString *postString = [jsonWriter stringWithObject:dic];

    [self post:postString];
    
   
}
- (void)post:(NSString*)postString
{
   // http://192.168.1.16:8080/Assistant/app
   // NSString *postString =@"{\"companyId\":\"\",\"createDate\":\"\",\"descs\":\"\",\"goodsCode\":\"\",\"id\":\"\",\"limit\":10,\"marketPrice\":\"\",\"merchantCode\":\"\",\"name\":\"\",\"num\":\"\",\"page\":1,\"price\":\"\",\"productId\":\"\",\"sellCount\":\"\",\"state\":\"\"}";
    //NSString *postString = @"{\"actionCode\":\"441\" , \"appType\":\"json\",\"companyId\":\"00000101\"}";
    
    NSURL *url = [NSURL URLWithString:
                  @"http://192.168.1.83:9000/Assistant/app"];//http://192.168.1.83:9000
                  NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
                [req addValue:@"application/json"
             forHTTPHeaderField:@"Content-Type"];
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
   // NSString *receiveStr = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:receiveData options: NSJSONReadingMutableContainers error:Nil];
    NSLog(@">>%@",json);
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

- (IBAction)edition:(id)sender {
    
}
@end
