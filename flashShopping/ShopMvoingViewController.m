//
//  ShopMvoingViewController.m
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "ShopMvoingViewController.h"
#import "BaseTableView.h"
//#import "ShopManagerViewController.h"
//#import "RefundViewController.h"
#import "NoGoodViewController.h"
#import "GoodInfoViewController.h"
#import "OrderManagementViewController.h"
#import "BaseNavViewController.h"
#import "LogisticManagerViewController.h"
#import "NSString+URLEncoding.h"
#import "SBJsonWriter.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
//#import "NSObject+SBJson.h"


@interface ShopMvoingViewController ()<
UITableViewDataSource,
UITableViewDelegate,
UIScrollViewDelegate,
ASIHTTPRequestDelegate>

@end

@implementation ShopMvoingViewController{
    UITableView *testView;
    UIImageView *topImageView;
    UIImageView *processedImage;
    UIImageView *shopManagerView;
    
    NSMutableArray *showImgArr;
    NSInteger _curPage;
    NSMutableArray *allArr;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //        self.title = @"店铺动态";
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //判断ios版本号通过版本号来布坐标
    testView = [[UITableView alloc]initWithFrame:CGRectMake(0, IOS7?0:20, SCREENMAIN_WIDTH,iPhone5?568:480) style:UITableViewStylePlain];
    testView.backgroundColor = [UIColor blackColor];
    //    testView.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
    testView.delegate = self;
    testView.dataSource = self;
    testView.scrollEnabled = NO;//禁止滑动
    testView.separatorStyle = NO;//去除分割线
    [self.view addSubview:testView];
    
    
    //开启另一个线程来获取网络数据
    [NSThread detachNewThreadSelector:@selector(startLoadNet) toTarget:self withObject:nil];
    
}
#pragma mark---获取网络数据
- (void)startLoadNet
{
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.83:9000/Assistant/app"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:60];
    NSString *postString = @"{\"actionCode\":\"81\",\"companyId\":\"\",\"orderState\":\"\",\"ENTID\":\"\",\"USERID\":\"\"}";
    [request appendPostData:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request startAsynchronous];
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //    NSDictionary *dic = [[[request responseString] URLDecodedString] JSONValue];
    //    NSLog(@"nsksfdslf====%@",dic);
    
    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"请求失败");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
//顶部view
- (void)currentTopView
{
    topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT == 480?110:138)];
    topImageView.image = [UIImage imageNamed:@"topView_background"];
    UIImageView *septwolvesImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, SCREENMAIN_HEIGHT == 480? 13:25, 90, 90)];
    septwolvesImageView.image = [UIImage imageNamed:@"topView_01"];
    [topImageView addSubview:septwolvesImageView];
    
    topImageView.userInteractionEnabled = YES;//打开点出事件
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(107, SCREENMAIN_HEIGHT == 480? 20:28, 160, 40)];
//    name.text = NAME;
    name.textColor = [UIColor whiteColor];
    name.backgroundColor = [UIColor clearColor];
    name.font = [UIFont systemFontOfSize:20];
    [topImageView addSubview:name];
    
    UILabel *shopMvoingName = [[UILabel alloc] initWithFrame:CGRectMake(140, SCREENMAIN_HEIGHT == 480? 65:81.5f, 130, 23)];
    shopMvoingName.text = @"查看店铺首页";
    shopMvoingName.textColor = [UIColor colorWithRed:136/255.0 green:34/255.0 blue:48/255.0 alpha:1.0];//#882230
    shopMvoingName.font = [UIFont systemFontOfSize:18];
    [topImageView addSubview:shopMvoingName];
    
    //店铺首页
    UIButton *storeViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [storeViewBtn setFrame:CGRectMake(110, SCREENMAIN_HEIGHT == 480? 65:81.5f, 23, 23)];
    [storeViewBtn setBackgroundImage:[UIImage imageNamed:@"topView_02_2"] forState:UIControlStateNormal];
    storeViewBtn.showsTouchWhenHighlighted = YES ;
    storeViewBtn.tag = 101;
    [storeViewBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:storeViewBtn];
    
    //信息
    UIButton *lettersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lettersBtn.frame = CGRectMake(275, SCREENMAIN_HEIGHT == 480? 30:38.0f, 30, 20);
    [lettersBtn setBackgroundImage:[UIImage imageNamed:@"topView_03"] forState:UIControlStateNormal];
    [lettersBtn addTarget:self action:@selector(myTapClick) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:lettersBtn];
    
    //小红圈
    UIImageView *loopsView = [[UIImageView alloc] initWithFrame:CGRectMake(295, SCREENMAIN_HEIGHT == 480? 22:27.5f, 20, 20)];
    loopsView.image = [UIImage imageNamed:@"topView_13"];
    [topImageView addSubview:loopsView];
    
    //圈中的数字
    UILabel *loopsLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, SCREENMAIN_HEIGHT == 480? 1:1.25f, 17, 17)];
    loopsLabel.text = @"5";
    //因为系统6.0时，背景色默认为白色
    loopsLabel.backgroundColor = [UIColor clearColor];
    loopsLabel.font = [UIFont systemFontOfSize:14];
    loopsLabel.textColor = [UIColor whiteColor];
    [loopsView addSubview:loopsLabel];
    
    //    [topView addSubview:topImageView];
}
- (void)click:(UIButton *)b
{
    NSLog(@"===========店铺首页");
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"pull" object:b];
    
}
- (void)myTapClick
{
    NSLog(@"进入聊天页面");
}
//商品详情View
- (void)currentGoodsDetailsView
{
    processedImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT == 480? 150:180)];
    processedImage.image = [UIImage imageNamed:@"HomePagebackground"];
    processedImage.userInteractionEnabled = YES;
    
    NSArray *imgArr = @[@"processedImage_1",@"processedImage_2"];
    NSArray *titleArr = @[@"待发货订单",@"待退款订单"];
    NSMutableArray *digitalArr = [NSMutableArray arrayWithObjects:@"8",@"0", nil];
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(i, SCREENMAIN_HEIGHT == 480? 45:55.0f, 100,20)];
        titleLabel.text = titleArr[i];
        titleLabel.textColor = [UIColor whiteColor];//#FFFFFF
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        //数字
        UILabel *digitalLabel = [[UILabel alloc]initWithFrame:CGRectMake(i, 0-7, 100, 60)];
        digitalLabel.text = digitalArr[i];
        digitalLabel.font = [UIFont systemFontOfSize:40];
        
        if ([digitalLabel.text isEqualToString:@"0"]) {
            digitalLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1];
        }else{
            digitalLabel.textColor = [UIColor whiteColor];
        }
        digitalLabel.backgroundColor = [UIColor clearColor];
        digitalLabel.textAlignment = NSTextAlignmentCenter;
        
        UIButton *processedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [processedButton setFrame:CGRectMake(10+105*i, 10, 100, SCREENMAIN_HEIGHT == 480? 70:82.0f)];
        [processedButton setBackgroundImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        processedButton.tag = 510 + i;
        
        //为菜单添加事件
        [processedButton addTarget:self action:@selector(processedOrderView:) forControlEvents:UIControlEventTouchUpInside];
        
        [processedButton addSubview:digitalLabel];
        [processedButton addSubview:titleLabel];
        [processedImage addSubview:processedButton];
        
    }
    //button3
    UIButton *processedButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    processedButton3.frame = CGRectMake(220, 10, 90, SCREENMAIN_HEIGHT == 480? 135:168);
    [processedButton3 setBackgroundImage:[UIImage imageNamed:@"processedImage_3"] forState:UIControlStateNormal];
    processedButton3.tag = 512;
    [processedButton3 addTarget:self action:@selector(processedOrderView:) forControlEvents:UIControlEventTouchUpInside];
    //label3
    UILabel *titleLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREENMAIN_HEIGHT == 480? 95:110.0f, 90, 20)];
    titleLabel3.text = @"缺货商品";
    titleLabel3.textColor = [UIColor whiteColor];//#FFFFFF
    titleLabel3.backgroundColor = [UIColor clearColor];
    titleLabel3.textAlignment = NSTextAlignmentCenter;
    //数字3
    UILabel *digitalLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0-5, 0-7, 100, 60)];
    digitalLabel3.text = @"2";
    digitalLabel3.font = [UIFont systemFontOfSize:40];
    
    if ([digitalLabel3.text isEqualToString:@"0"]) {
        digitalLabel3.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1];
    }else{
        digitalLabel3.textColor = [UIColor whiteColor];
    }
    digitalLabel3.backgroundColor = [UIColor clearColor];
    digitalLabel3.textAlignment = NSTextAlignmentCenter;
    
    [processedButton3 addSubview:digitalLabel3];
    [processedButton3 addSubview:titleLabel3];
    [processedImage addSubview:processedButton3];
    
    //button4
    UIButton *processedButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
    processedButton4.frame = CGRectMake(10, SCREENMAIN_HEIGHT == 480? 85:98.0f, 205, SCREENMAIN_HEIGHT == 480? 60:80.0f);
    [processedButton4 setBackgroundImage:[UIImage imageNamed:@"processedImage_4"] forState:UIControlStateNormal];
    processedButton4.tag = 513;
    [processedButton4 addTarget:self action:@selector(processedOrderView:) forControlEvents:UIControlEventTouchUpInside];
    //label4
    UILabel *titleLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(5, SCREENMAIN_HEIGHT == 480? 20:25.0f, 100, 20)];
    titleLabel4.text = @"待支付订单";
    titleLabel4.textColor = [UIColor whiteColor];//#FFFFFF
    titleLabel4.backgroundColor = [UIColor clearColor];
    titleLabel4.textAlignment = NSTextAlignmentCenter;
    //数字4
    UILabel *digitalLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(105, SCREENMAIN_HEIGHT == 480? 0:5.0f, 100, 60)];
    digitalLabel4.text = @"2";
    digitalLabel4.font = [UIFont systemFontOfSize:40];
    
    if ([digitalLabel4.text isEqualToString:@"0"]) {
        digitalLabel4.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1];
    }else{
        digitalLabel4.textColor = [UIColor whiteColor];
    }
    digitalLabel4.backgroundColor = [UIColor clearColor];
    digitalLabel4.textAlignment = NSTextAlignmentCenter;
    
    [processedButton4 addSubview:digitalLabel4];
    [processedButton4 addSubview:titleLabel4];
    [processedImage addSubview:processedButton4];
    
}
#pragma mark-----Action
- (void)processedOrderView:(UIButton* )button{
    NSLog(@"%d",button.tag );
    
    if (button.tag == 510) {
        OrderManagementViewController *OrderManagementView = [[OrderManagementViewController alloc]initWithQueryTypeIsWait4Shipments:YES];
        [self.navigationController pushViewController:OrderManagementView animated:YES];
        
    }else if (button.tag == 511){
        
//        RefundViewController *refundViewCtl = [[RefundViewController alloc] init];
//        [self.navigationController pushViewController:refundViewCtl animated:YES];
        
    }else if (button.tag == 512){
        
//        OrderManagementViewController *OrderManagementView = [[OrderManagementViewController alloc]init];
//        [self.navigationController pushViewController:OrderManagementView animated:YES];
        
    }else if (button.tag == 513){
        
        NoGoodViewController *noGoodViewCtl = [[NoGoodViewController alloc] init];
        [self.navigationController pushViewController:noGoodViewCtl animated:YES];
    }
}
//店铺管理菜单
- (void)creatShopManagerButton{
    shopManagerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT == 480? 150:180)];
    shopManagerView.userInteractionEnabled = YES;
    shopManagerView.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
    NSArray *imgNormalArr = @[@"function1-1",@"function2-1",@"function3-1",@"function4-1",@"function5-1",@"function6-1"];
    NSArray *imgSelectArr = @[@"function1-2",@"function2-2",@"function3-2",@"function4-2",@"function5-2",@"function6-2"];
    
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            int temp = j + i*3;
            UIButton *managerButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [managerButton setFrame:CGRectMake(10+100*j, 10+(SCREENMAIN_HEIGHT == 480? 65:82)*i, 100, SCREENMAIN_HEIGHT == 480? 65:82)];
            
            [managerButton setBackgroundImage:[UIImage imageNamed:imgNormalArr[temp]] forState:UIControlStateNormal];
            [managerButton setBackgroundImage:[UIImage imageNamed:imgSelectArr[temp]] forState:UIControlStateSelected ];
            managerButton.tag = 120+temp;
            
            //为菜单添加事件
            [managerButton addTarget:self action:@selector(jumpMenuView:) forControlEvents:UIControlEventTouchUpInside];
            
            [shopManagerView addSubview:managerButton];
            
        }
    }
}

#pragma mark-----Action
- (void)jumpMenuView:(UIButton *)button{
    NSLog(@"%d",button.tag-120);
    
    if (button.tag == 120) {
        OrderManagementViewController *OrderManagementView = [[OrderManagementViewController alloc]init];
        [self.navigationController pushViewController:OrderManagementView animated:YES];
    }
    else if (button.tag == 121) {
        LogisticManagerViewController *logisticsView = [[LogisticManagerViewController alloc] init];
        [self.navigationController pushViewController:logisticsView animated:YES];
    }
    else if (button.tag == 122) {
//        RefundViewController *refundView = [[RefundViewController alloc]init];
//        [self.navigationController pushViewController:refundView animated:YES];
    }
    else if (button.tag == 123) {
        GoodInfoViewController *goodInfoView = [[GoodInfoViewController alloc]init];
        [self.navigationController pushViewController:goodInfoView animated:YES];
    }
    else if (button.tag == 124) {
        NoGoodViewController *noGoodView = [[NoGoodViewController alloc]init];
        [self.navigationController pushViewController:noGoodView animated:YES];
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (indexPath.row == 0) {
        
        [self currentTopView];
        [cell.contentView addSubview:topImageView];
        //取消的点中事件
        cell.selectionStyle = UITableViewScrollPositionNone;
        
    }else if (indexPath.row == 1){
        [self currentGoodsDetailsView];
        [cell.contentView addSubview:processedImage];
        cell.selectionStyle = UITableViewScrollPositionNone;
    }else if (indexPath.row == 2){
        [self creatShopManagerButton];
        [cell.contentView addSubview:shopManagerView];
        cell.selectionStyle = UITableViewScrollPositionNone;
    }
    
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return SCREENMAIN_HEIGHT == 480? 110:138;
    }else if (indexPath.row == 1){
        return SCREENMAIN_HEIGHT == 480? 150:180;
    }else if (indexPath.row == 2){
        return SCREENMAIN_HEIGHT == 480? 150:180;
    }else{
        return 0;
    }
}

@end
