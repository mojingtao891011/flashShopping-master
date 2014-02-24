//
//  TestData.m
//  flashShopping
//
//  Created by Width on 14-1-16.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "TestData.h"
#import "OrderManagerDataModle.h"
#import "ShopInfoModle.h"

@implementation TestData
- (id)init
{
    self = [super init];
    if (self) {
        [self _initTestData];
    }
    return self;
}
- (void)_initTestData
{
    for (int i = 0; i < 5; i++) {
        
        OrderManagerDataModle *orderDataModel = [[OrderManagerDataModle alloc]init];
        orderDataModel.orderId = [NSString stringWithFormat:@"00%d",i];
        orderDataModel.orderCode = [NSString stringWithFormat:@"000000000%d",i];
        orderDataModel.orderState = i ;
        orderDataModel.orderDate = [NSString stringWithFormat:@"2014:01:16 15:30:3%d",i];
        orderDataModel.amount = [NSString stringWithFormat:@"00%d",i];
        orderDataModel.fastmailfee = @"12";
        orderDataModel.linkman = [NSString stringWithFormat:@"李四%d",i];
        orderDataModel.phone1 = @"13345678900";
        orderDataModel.address1 = @"深圳市南山区";
        orderDataModel.city = @"深圳市";
        orderDataModel.county =@"南山区";
        
        for (int j = 0; j < 4; j++) {
            ShopInfoModle *shopItem = [[ShopInfoModle alloc]init];
            shopItem.name = [NSString stringWithFormat:@"商品%d",j];
            shopItem.goodsCode = [NSString stringWithFormat:@"SB10000020%d",j];
            shopItem.productcss = @"红色";
            shopItem.unitprice = @"699.00";
            shopItem.quantity = @"100";
            shopItem.viewUrl = @"testImg1";
            if (orderDataModel.itemArr == nil) {
                orderDataModel.itemArr = [NSMutableArray new];
            }
            [orderDataModel.itemArr addObject:shopItem];
        }
        
        if (_itemDic == nil) {
            _itemDic = [NSMutableDictionary new];
        }
        [_itemDic setObject:orderDataModel forKey:orderDataModel.orderCode];
        
    }
}

@end
