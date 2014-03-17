//
//  OrderManagementViewController.m
//  flashShopping
//
//  Created by Width on 14-1-12.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "OrderManagementViewController.h"
#import "KxMenu.h"
//#import "OrderDetailViewController.h"
//#import "ShipOrderViewController.h"
//#import "ShippedShopViewController.h"
//#import "RefundViewController.h"
//#import "AllShopViewController.h"
//#import "DetailViewController.h"
#import "OrderManagerDetailViewController.h"

@interface OrderManagementViewController ()

@end

@implementation OrderManagementViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithQueryTypeIsWait4Shipments:(BOOL)isWait4Shipments{
    
    self = [super init];
    if (self) {
        self.isWait4Shipments = isWait4Shipments;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor redColor];
    self.isBack = YES ;
    self.isAddRefreshButton = YES;
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT - 64)];
    _webView.delegate = self;
//    _webView.userInteractionEnabled = YES;
     [self.view addSubview:_webView];
    _request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.16:8080/Assistant/appWeb/order.jsp?companyId=&userId="]];
     [_webView loadRequest:_request];
     controlJSActionInfoDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    
    
    if (IOS_VERSION < 7.0) {
        [_bobyView setFrame:CGRectMake(0, 10, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT-20-44-10)];
    }

    //自定义导航标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 100, 34)];
    titleLabel.text = @"订单管理" ;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.userInteractionEnabled = YES;
    
    UIButton *pulldownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pulldownButton setBackgroundImage:[UIImage imageNamed:@"pulldown"] forState:UIControlStateNormal];
    [pulldownButton setFrame:CGRectMake(85, 14, 11, 8)];
    [pulldownButton addTarget:self action:@selector(pulldownMore:) forControlEvents:UIControlEventTouchUpInside];
    [titleLabel addSubview:pulldownButton];
    
    self.navigationItem.titleView = titleLabel ;
}


#pragma mark -
#pragma mark UIWebViewDelegate Method
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlString = [[request URL] absoluteString];
    NSLog(@"urlString is %@",urlString);
    
    /*
     http://192.168.1.16:8080/Assistant/20140304143724671150%7Chttp://192.168.1.16:8080/Assistant/appWeb/orderGuanbi.jsp
     
     */
    
    NSArray *strItem = [urlString componentsSeparatedByString:@"%7C"];

        
        if (strItem.count == 2) {
            
            forwordURL = [strItem objectAtIndex:1];
            
            NSString *tempStr = [strItem objectAtIndex:0];
           NSArray *tempArr = [tempStr componentsSeparatedByString:@"/"];
            if (tempStr) {
                orderNumber = [tempArr lastObject];
                
                
                if (forwordURL && orderNumber) {
                    
                    NSLog(@"forwordurl is %@           orderNumber is  %@",forwordURL,orderNumber);
                    
                    NSString *finalForwordURL = [NSString stringWithFormat:@"%@?orderCode=%@&companyId=%@&userId=%@",forwordURL,orderNumber,@"00000000",@"000000"];
//                    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:finalForwordURL]]];
                    
                    OrderManagerDetailViewController *orderDetailVC = [[OrderManagerDetailViewController alloc] initWithRequestURLStr:finalForwordURL];
                    [self.navigationController pushViewController:orderDetailVC animated:YES];
                    
                    return NO;
                    
                }
            }
            
        }
    
    
    
    return YES;
    
}

- (void)refreshView
{
    if (_webView) {
        [_webView reload];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    [controlJSActionInfoDic setObject:@"00000000" forKey:@"companyId"];
    [controlJSActionInfoDic setObject:@"1" forKey:@"pageRequest"];
    [controlJSActionInfoDic setObject:@"" forKey:@"query"];
    
    if (self.isWait4Shipments) {
        [controlJSActionInfoDic setObject:@"7" forKey:@"orderState"];
        [self performSelectorOnMainThread:@selector(createJSActionCodeWithInfoDictionary:) withObject:controlJSActionInfoDic waitUntilDone:NO];
        
    }else{
        [controlJSActionInfoDic setObject:@"" forKey:@"orderState"];
        [self performSelectorOnMainThread:@selector(createJSActionCodeWithInfoDictionary:) withObject:controlJSActionInfoDic waitUntilDone:NO];
        
    }

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
    
}


- (void)pulldownMore:(UIButton*)button{
    
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"所有订单"
                     image:nil
                    target:nil
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"待付款订单"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"待发货订单"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"已发货订单"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"已取消订单"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"已成功订单"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      [KxMenuItem menuItem:@"已关闭订单"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)]
      ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    
    if (IOS_VERSION < 7.0) {
        [KxMenu showMenuInView:self.view
                      fromRect:CGRectMake(100, -100, 100, 100)
                     menuItems:menuItems];
    }else{
        [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(100, -38, 100, 100)
                 menuItems:menuItems];

    }
        
    

}

- (void)pushMenuItem:(KxMenuItem*)menuItem{
    NSLog(@"%@",menuItem.title);
    
    [self performSelectorOnMainThread:@selector(createJSActionCodeWithState:) withObject:@"10086" waitUntilDone:NO];
     [controlJSActionInfoDic removeAllObjects];
    
    [controlJSActionInfoDic setObject:@"00000000" forKey:@"companyId"];
    [controlJSActionInfoDic setObject:@"1" forKey:@"pageRequest"];
    [controlJSActionInfoDic setObject:@"" forKey:@"query"];
    
    
    
    
    if ([menuItem.title isEqualToString:@"所有订单"]) {
        
        [controlJSActionInfoDic setObject:@"" forKey:@"orderState"];
        [self performSelectorOnMainThread:@selector(createJSActionCodeWithInfoDictionary:) withObject:controlJSActionInfoDic waitUntilDone:NO];
    }else if ([menuItem.title isEqualToString:@"待付款订单"]){
        
        [controlJSActionInfoDic setObject:@"12" forKey:@"orderState"];
        [self performSelectorOnMainThread:@selector(createJSActionCodeWithInfoDictionary:) withObject:controlJSActionInfoDic waitUntilDone:NO];
    }

    else if ([menuItem.title isEqualToString:@"待发货订单"]) {
       
        [controlJSActionInfoDic setObject:@"7" forKey:@"orderState"];
        [self performSelectorOnMainThread:@selector(createJSActionCodeWithInfoDictionary:) withObject:controlJSActionInfoDic waitUntilDone:NO];
    }
    else if ([menuItem.title isEqualToString:@"已发货订单"]){
        
        [controlJSActionInfoDic setObject:@"8_21_22" forKey:@"orderState"];
        [self performSelectorOnMainThread:@selector(createJSActionCodeWithInfoDictionary:) withObject:controlJSActionInfoDic waitUntilDone:NO];
    }
    else if ([menuItem.title isEqualToString:@"已取消订单"]){
        
        [controlJSActionInfoDic setObject:@"3" forKey:@"orderState"];
        [self performSelectorOnMainThread:@selector(createJSActionCodeWithInfoDictionary:) withObject:controlJSActionInfoDic waitUntilDone:NO];
    }
    else if ([menuItem.title isEqualToString:@"已成功订单"]){
        
        [controlJSActionInfoDic setObject:@"9" forKey:@"orderState"];
        [self performSelectorOnMainThread:@selector(createJSActionCodeWithInfoDictionary:) withObject:controlJSActionInfoDic waitUntilDone:NO];
        
    }


}
- (void)createJSActionCodeWithState:(NSString *)aState{
    
    
    NSString *jsFounctionStr = [NSString stringWithFormat:@"queryOrderByState('%@')",aState];
    //    NSLog(@"jsfounctionstr is %@",jsFounctionStr);
    [_webView stringByEvaluatingJavaScriptFromString:jsFounctionStr];
}


- (void)createJSActionCodeWithInfoDictionary:(NSDictionary *)infoDic{
    
    //    NSLog(@"%@",infoDic);
    NSString *aCompanyId = [infoDic objectForKey:@"companyId"];
    NSString *aPageRequest = [infoDic objectForKey:@"pageRequest"];
    NSString *aQuery = [infoDic objectForKey:@"query"];
    NSString *aOrderState = [infoDic objectForKey:@"orderState"];
    
    NSString *jsFounctionStr = [NSString stringWithFormat:@"orderRequest('%@','%@','%@','%@')",aCompanyId,aPageRequest,aQuery,aOrderState];
    
    
    [_webView stringByEvaluatingJavaScriptFromString:jsFounctionStr];
    
//    NSLog(@"%@",[_webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]);
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickTodetail:(id)sender {
    
//    DetailViewController *detailView = [[DetailViewController alloc]init];
//    [self.navigationController pushViewController:detailView animated:YES];
//   
}
@end
