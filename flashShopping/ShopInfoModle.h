//
//  ShopInfoModle.h
//  flashShopping
//
//  Created by Width on 14-1-11.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//
/*
orderitemId	String	主键
name	String	商品名称
goodsCode	String	商品编码
productcss	String	商品样式
unitprice	String	单价
quantity	Integer	数量
viewUrl	String	缩略图路径
 */
#import <Foundation/Foundation.h>

@interface ShopInfoModle : NSObject

@property (nonatomic , copy)NSString     *orderitemId;              //主键
@property (nonatomic , copy)NSString     *name;                         //商品名称
@property (nonatomic , copy)NSString     *goodsCode;               //商品编码
@property (nonatomic , copy)NSString     *productcss;               //商品样式
@property (nonatomic , copy)NSString     *unitprice;                   //单价
@property (nonatomic , copy)NSString     *quantity;                     //数量
@property (nonatomic , copy)NSString     *viewUrl;                      //缩略图路径

@end
