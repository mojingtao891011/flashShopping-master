//
//  GoodsDetailViewController.m
//  flashShopping
//
//  Created by Width on 14-1-23.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodsCell.h"
#import "ModifyInfoViewController.h"
#import "LogisticViewController.h"

@interface GoodsDetailViewController ()
{
    UITableView *_tableView ;
}
@end

@implementation GoodsDetailViewController

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
    self.titleLabel.text = @"商品详情";
    self.view.backgroundColor = [UIColor clearColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.dataSource = self ;
    _tableView.delegate = self ;
    UIView *tableView_bg = [[UIView alloc]init];
    tableView_bg.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = tableView_bg ;
    [self.view addSubview:_tableView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden= NO  ;
    
}
#pragma mark---UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2 ;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2 ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return _customCell ;
    }else if (indexPath.section == 0 && indexPath.row == 1){
        GoodsCell *goodsCell = [[GoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        goodsCell.goodsModel = _goodsModel ;
        goodsCell.goodsCodeLabel.text = [NSString stringWithFormat:@"编号:%@",_goodsModel.goodsCode];
        return goodsCell ;
    }else if (indexPath.section == 1 && indexPath.row == 0){
        return _customCell2 ;
    }else if (indexPath.section == 1 && indexPath.row == 1){
        return _edInfoCell ;
    }
       return nil ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [_goodsModel.name sizeWithFont:[UIFont systemFontOfSize:16.0] constrainedToSize:CGSizeMake(200, 100) lineBreakMode:NSLineBreakByWordWrapping];
    if (indexPath.section == 0 && indexPath.row == 1) {
        return 100 + size.height - 20 ;
    }
    return 44 ;
}
#pragma mark---MemoryManager
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---customModth
- (IBAction)ModifyInfoButton:(id)sender {
    ModifyInfoViewController *ModifyInfoView = [[ModifyInfoViewController alloc]init];
    ModifyInfoView.Id = _goodsModel.Id ;
    [self.navigationController pushViewController:ModifyInfoView animated:YES];
}

- (IBAction)logisticInfo:(id)sender {
    LogisticViewController *logisticInfoView = [[LogisticViewController alloc]init];
    [self.navigationController pushViewController:logisticInfoView animated:YES];
}
@end
