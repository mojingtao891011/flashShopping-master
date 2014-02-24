//
//  GoodsCell.h
//  flashShopping
//
//  Created by Width on 14-1-20.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//
/*key	type	directions
 Id	Long	商品ID
 goodsId	Long	货品ID
 name	String	商品名称
 goodsCode	String	商品编号
 viewUrl	String	缩略图路径
 price	Double	闪购价
 num	Integer	库存
 */

#import <UIKit/UIKit.h>
#import "ShopInfoModle.h"

@interface GoodsCell : UITableViewCell

@property ( nonatomic , retain )UIImageView         *goodsImgView;                      //商品图片
@property ( nonatomic , retain )UILabel                   *sellStatusLabel;                      //出售状态
@property ( nonatomic , retain )UILabel                   *directionsLabel;                     //商品描述
@property ( nonatomic , retain ) UILabel                   *priceLabel;                             //价格（字体）
@property ( nonatomic , retain ) UILabel                   *priceMoneyLabel;                  //价格
@property ( nonatomic , retain ) UILabel                   *numLabel;                               //库存 （字体）
@property ( nonatomic , retain ) UILabel                   *numNumberabel;                   //库存
@property (nonatomic , retain )ShopInfoModle        *goodsModel ;                   //数据模型

@end
