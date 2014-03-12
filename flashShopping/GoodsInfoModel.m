//
//  GoodsInfoModel.m
//  flashShopping
//
//  Created by 莫景涛 on 14-3-12.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//
/*
@property ( nonatomic , assign )long            Id ;                           //商品ID
@property ( nonatomic , assign )long            goodsId ;                //货品ID
@property ( nonatomic , copy )NSString        *name ;                     //商品名称
@property ( nonatomic , copy )NSString        *goodsCode ;           //商品编号
@property ( nonatomic , copy )NSString        *viewUrl ;                  //缩略图路径
@property ( nonatomic , assign)double          price ;                      //闪购价
@property ( nonatomic , assign )int                 num ;                       //库存 如果为0则为缺货商品
@property ( nonatomic , copy )NSString       *isUp ;                        //是否上架、0 未上架、1 已上架
 
 */
#import "GoodsInfoModel.h"

@implementation GoodsInfoModel
- (NSDictionary*)attributeMapDictionary
{
    NSDictionary *dict = @{
                
                           @"Id" : @"id" ,
                           @"goodsId" : @"goodsId" ,
                           @"name" : @"name" ,
                           @"goodsCode" : @"goodsCode" ,
                           @"viewUrl" : @"viewUrl" ,
                           @"price" : @"price" ,
                           @"num" : @"num" ,
                           @"isUp" : @"isUp" ,

                
        };
    return dict ;
}
- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
}
@end
