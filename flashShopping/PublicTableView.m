//
//  PublicTableView.m
//  flashShopping
//
//  Created by Width on 14-1-16.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "PublicTableView.h"
#import "OrderManagerDataModle.h"
#import "ShopInfoModle.h"

@implementation PublicTableView
{
    NSArray *keysArr ;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andDataDic:(NSMutableDictionary *)DataDic
{
    self = [super initWithFrame:frame style:style];
    if (self) {
       
        self.itemDict = [DataDic copy];
        [self loadData];
        
       
    }
    return self;
}
- (void)loadData
{
    self.dataSource = self;
    self.delegate = self ;
    keysArr = [NSArray arrayWithArray:[_itemDict allKeys]];
   
}
#pragma mark---UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_itemDict allKeys].count ;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    OrderManagerDataModle *orderDataModel = _itemDict[keysArr[section]];
    return orderDataModel.itemArr.count ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    OrderManagerDataModle *orderDataModel = self.itemDict[keysArr[indexPath.section]];
    ShopInfoModle *shopInfoModel = orderDataModel.itemArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:shopInfoModel.viewUrl];
    cell.textLabel.text = shopInfoModel.name;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PublicTableView *headView = [[NSBundle mainBundle]loadNibNamed:@"PublicTableView" owner:nil options:nil][0];
    OrderManagerDataModle *orderDataModel = self.itemDict[keysArr[section]];
    headView.orderCode.text = orderDataModel.orderCode;
    if (orderDataModel.orderState % 2 == 0) {
         headView.orderState.text = @"待付款订单" ;
    }else{
        headView.orderState.text = @"已付款订单" ;
    }
   
        return headView ;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[NSBundle mainBundle]loadNibNamed:@"PublicTableView" owner:nil options:nil][1];
    return footerView ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70 ;
}
@end
