//
//  GoodsInfoModel.h
//  flashShopping
//
//  Created by 莫景涛 on 14-3-12.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//
/*
 Id                        Long            商品ID
 goodsId             Long            货品ID
 name                String          商品名称
 goodsCode       String          商品编号
 viewUrl             String          缩略图路径
 price                   Double      闪购价
 num                 Integer           库存
 */

#import "WXBaseModel.h"

@interface GoodsInfoModel : WXBaseModel

@property ( nonatomic , retain )NSNumber            *Id ;                           //商品ID
@property ( nonatomic , retain )NSNumber            *goodsId ;                //货品ID
@property ( nonatomic , copy )NSString                  *name ;                     //商品名称
@property ( nonatomic , copy )NSString                  *goodsCode ;           //商品编号
@property ( nonatomic , copy )NSString                  *viewUrl ;                  //缩略图路径
@property ( nonatomic , retain)NSNumber              *price ;                      //闪购价
@property ( nonatomic , retain )NSNumber             *num ;                       //库存 如果为0则为缺货商品
@property ( nonatomic , copy )NSString                  *isUp ;                        //是否上架、0 未上架、1 已上架

@end
