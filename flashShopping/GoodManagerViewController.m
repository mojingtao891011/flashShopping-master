//
//  ShopManagerViewController.m
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "GoodManagerViewController.h"
#import "GoodInfoViewController.h"

@interface GoodManagerViewController ()
//店铺管理菜单
- (void)creatShopManagerButton;

@end

@implementation GoodManagerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      //  self.title=@"店铺管理";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = @"店铺管理";
    [self creatShopManagerButton];//店铺管理菜单
    
  
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden= NO ;
}

//店铺管理菜单
- (void)creatShopManagerButton{
    
    NSArray *imgArr=@[@"order_Manager",@"logistics_Manager",@"refund_manager",@"shop_manager",@"noShop_manger",@"dimensional code"];
    NSArray *titleArr=@[@"订单管理",@"物流管理",@"退款管理",@"商品管理",@"缺货商品",@"扫码购"];
    int version_H = POINT_Y ;
    int point_Y = version_H + 40 ;
    for (int i=0; i<imgArr.count; i++) {
        UIButton *managerButton=[UIButton buttonWithType:UIButtonTypeCustom];
        static int row=0;
        if (i%3 == 0 && i != 0) {
            point_Y = point_Y + 150;
            row=0;
        }
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20+row*100, point_Y+80, 80, 30)];
        titleLabel.text=titleArr[i];
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        
        [managerButton setFrame:CGRectMake(20+row*100, point_Y, 80, 80)];
        [managerButton setBackgroundImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        managerButton.tag=120+i;
        
        //为菜单添加事件
        [managerButton addTarget:self action:@selector(jumpMenuView:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:titleLabel];
        [self.view addSubview:managerButton];
        row++;
    }
}

#pragma mark-----Action
- (void)jumpMenuView:(UIButton*)button{
    NSLog(@"%d",button.tag);
    if (button.tag == 120) {
      
    }
    else if (button.tag == 123)
    {
        GoodInfoViewController *goodsManamentView = [[GoodInfoViewController alloc]init];
        [self.navigationController pushViewController:goodsManamentView animated:YES];
    }
}
#pragma mark-----Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
