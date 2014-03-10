//
//  LogisticManagerViewController.m
//  flashShopping
//
//  Created by 莫景涛 on 14-3-4.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "LogisticManagerViewController.h"
#import "SGDataService.h"

@interface LogisticManagerViewController ()

@end

@implementation LogisticManagerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"物流管理" ;
    //刷新按钮
    CustomUIBarButtonItem *barButton = [[CustomUIBarButtonItem alloc]initWithFrame:CGRectMake(0, 0, 20, 20) andSetdelegate:self andImageName:@"refresh"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:barButton];
    [self startLoadNet];
}
- (void)startLoadNet
{
    NSDictionary *dict = @{@"actionCode":@"421" , @"appType":@"json" , @"companyId":@"00000101" , @"billNo":@"112" , @"orderCode":@"21"};
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    [SGDataService requestWithUrl:BASEURL dictParams:mutableDict httpMethod:@"post" completeBlock:^(id result){
        NSLog(@"%@",result[@"content"]);
    }];
        
}
#pragma mark----barButtonProtocol
- (void)actions:(id)sender
{
    NSLog(@"刷新………………");
}
#pragma mark----MemoryManager
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
