//
//  OrderManagementViewController.m
//  flashShopping
//
//  Created by Width on 14-1-12.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "OrderManagementViewController.h"
#import "OrderManagerDetailViewController.h"


@interface OrderManagementViewController ()

@end

typedef enum {
    kAllOrder = 0,
    kWait4PaymentOrder,
    kWait4ShipmentOrder,
    kAlreadyShipmentOrder,
    kAlreadyCancelOrder,
    kAlreadySucceedOrder,
    kAlreadyClosedOrder
    
}kOrderManagerType;

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
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor redColor];
    self.isBack = YES ;
    self.isAddRefreshButton = YES;
    self.view.backgroundColor = [UIColor blackColor];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT - 64)];
    _webView.delegate = self;
//    _webView.userInteractionEnabled = YES;
     [self.view addSubview:_webView];
    _request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.16:8080/Assistant/appWeb/order.jsp?companyId=&userId="]];
     [_webView loadRequest:_request];
     controlJSActionInfoDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    //自定义导航
//    navigationBar = [[CustomNavigationBar alloc]initWithFrame:CGRectMake(0, 20, SCREENMAIN_WIDTH, 44) andTitleArr:[NSArray arrayWithObjects:@"所有商品",@"橱窗中商品",@"出售中商品",@"仓库中商品",@"已下架商品", nil] andSetBarButtonDelegate:self andSetPullNenuDelegate:self ];
    
    titleArr = @[@"所有订单",@"待付款订单",@"待发货订单",@"已发货订单",@"已取消订单",@"已成功订单",@"已关闭订单",];
    navigationBar = [[CustomNavigationBar alloc] initWithFrame:CGRectMake(0.0f, 20.0f, SCREENMAIN_WIDTH, 44.0f) andTitleArr:titleArr andSetBarButtonDelegate:self andSetPullNenuDelegate:self];
    [self.view addSubview:navigationBar];
    
    if (IOS_VERSION < 7.0) {
        [_bobyView setFrame:CGRectMake(0, 10, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT-20-44-10)];
    }

    //自定义导航标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 100, 34)];
    titleLabel.text = @"订单管理" ;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.userInteractionEnabled = YES;
    
//    UIButton *pulldownButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [pulldownButton setBackgroundImage:[UIImage imageNamed:@"pulldown"] forState:UIControlStateNormal];
//    [pulldownButton setFrame:CGRectMake(85, 14, 11, 8)];
//    [pulldownButton addTarget:self action:@selector(pulldownMore:) forControlEvents:UIControlEventTouchUpInside];
//    [titleLabel addSubview:pulldownButton];
    
    self.navigationItem.titleView = titleLabel ;
}
- (void)actions:(id)sender{
    UIButton *b = (UIButton*)sender ;
    if (b.tag == 10) {
//        navigationBar.flag = !navigationBar.flag;
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSLog(@"刷新…………"  );
    }
    
}


#pragma mark---ChangeHeightProtocol
//选中下拉行的标题
- (void)changeTitles:(NSString *)title{
    [navigationBar pullDwonAction];
    navigationBar.pullNenu.hidden = YES;
    
    [self performSelectorOnMainThread:@selector(createJSActionCodeWithState:) withObject:@"10086" waitUntilDone:NO];
    [controlJSActionInfoDic removeAllObjects];
# warning companyId
    [controlJSActionInfoDic setObject:@"00000000" forKey:@"companyId"];
    [controlJSActionInfoDic setObject:@"1" forKey:@"pageRequest"];
    [controlJSActionInfoDic setObject:@"" forKey:@"query"];
    
    
    switch ([titleArr indexOfObject:title]) {
        case kAllOrder:
        {
            [controlJSActionInfoDic setObject:@"" forKey:@"orderState"];
            [self performSelectorOnMainThread:@selector(createJSActionCodeWithInfoDictionary:) withObject:controlJSActionInfoDic waitUntilDone:NO];
            
        }
            break;
        case kWait4PaymentOrder:
        {
            [controlJSActionInfoDic setObject:@"12" forKey:@"orderState"];
            [self performSelectorOnMainThread:@selector(createJSActionCodeWithInfoDictionary:) withObject:controlJSActionInfoDic waitUntilDone:NO];
            
        }
            break;
            
        case kWait4ShipmentOrder:
        {
            [controlJSActionInfoDic setObject:@"7" forKey:@"orderState"];
            [self performSelectorOnMainThread:@selector(createJSActionCodeWithInfoDictionary:) withObject:controlJSActionInfoDic waitUntilDone:NO];
            
        }
            break;
        case kAlreadyShipmentOrder:
        {
            [controlJSActionInfoDic setObject:@"8_21_22" forKey:@"orderState"];
            [self performSelectorOnMainThread:@selector(createJSActionCodeWithInfoDictionary:) withObject:controlJSActionInfoDic waitUntilDone:NO];
            
        }
            break;
        case kAlreadyCancelOrder:
        {
            [controlJSActionInfoDic setObject:@"3" forKey:@"orderState"];
            [self performSelectorOnMainThread:@selector(createJSActionCodeWithInfoDictionary:) withObject:controlJSActionInfoDic waitUntilDone:NO];
            
        }
            break;
        case kAlreadySucceedOrder:
        {
            [controlJSActionInfoDic setObject:@"9" forKey:@"orderState"];
            [self performSelectorOnMainThread:@selector(createJSActionCodeWithInfoDictionary:) withObject:controlJSActionInfoDic waitUntilDone:NO];
            
        }
            break;
        case kAlreadyClosedOrder:
        {
            
            
        }
            break;
            
            
        default:
            break;
    }
    
    
    
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

# warning companyId
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
    
    UIImageView *view = [[UIImageView alloc] init];
    UIButton *btn = [[UIButton alloc] init];
    [view addSubview:btn];
    
    
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
