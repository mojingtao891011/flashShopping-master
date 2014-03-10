//
//  GoodInfoModle.h
//  flashShopping
//
//  Created by Width on 14-2-25.
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
#import <Foundation/Foundation.h>

@interface GoodInfoModle : NSObject

@property ( nonatomic , copy )NSString      *Id ;                           //商品ID
@property ( nonatomic , copy )NSString      *goodsId ;                //货品ID
@property ( nonatomic , copy )NSString      *name ;                     //商品名称
@property ( nonatomic , copy )NSString      *goodsCode ;           //商品编号
@property ( nonatomic , copy )NSString      *viewUrl ;                  //缩略图路径
@property ( nonatomic , copy )NSString      *price ;                      //闪购价
@property ( nonatomic , copy )NSString      *num ;                       //库存 如果为0则为缺货商品
@property ( nonatomic , assign )BOOL          isUp ;                        //是否上架、0 未上架、1 已上架

//@property ( nonatomic , copy )NSString      *hasNext ;                  //是否有下一页
@end
