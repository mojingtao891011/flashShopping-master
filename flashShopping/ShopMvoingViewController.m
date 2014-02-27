//
//  ShopMvoingViewController.m
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "ShopMvoingViewController.h"
#import "BaseTableView.h"
#import "BaseNavViewController.h"
#import "RequestNetwork.h"

@interface ShopMvoingViewController ()
@end

@implementation ShopMvoingViewController

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
    self.titleLabel.text = @"店铺动态";
   
    [NSThread detachNewThreadSelector:@selector(startLoadNet) toTarget:self withObject:nil]; //开启另一个线程来获取网络数据
        
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark---获取网络数据
- (void)startLoadNet
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getData:) name:@"getData" object:nil];
       NSString *postString =@"{\"actionCode\":\"71\",\"appType\":\"json\",\"companyId\":\"00000101\"}";

   // [[RequestNetwork shareManager] requestNetwork:postString];
}
#pragma mark---NSNotificationCenter
- (void)getData:(NSNotification*)note
{
    //NSLog(@"%@",[note object]);
    
}
@end
