//
//  OrderManagerDataModle.h
//  flashShopping
//
//  Created by Width on 14-1-7.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//
///////////////////////////订单所有信息///////////////////
/*
 orderId	String	订单表ID
 orderCode	String	订单编号
 orderState	Integer	订单状态
 orderDate	Date	下单日期
 amount	String	订单金额
 fastmailfee	String	运费
 linkman	String	联系人
 phone1	String	手机号
 address1	String	详细地址
 province	Integer	省
 city	Integer	市
 county	Integer	区
 items	List	订单明细
 */

#import <Foundation/Foundation.h>


@interface OrderManagerDataModle : NSObject

@property (nonatomic , copy)NSString             *orderId ;                     //订单表ID
@property (nonatomic , copy)NSString          *orderCode ;               //订单编号
@property (nonatomic , assign)NSInteger         orderState ;                //订单状态
@property (nonatomic , copy)NSString            *orderDate ;                //下单日期
@property (nonatomic , copy)NSString              * amount ;                   //订单金额
@property (nonatomic , copy)NSString              *fastmailfee ;              //运费
@property (nonatomic , copy)NSString              *linkman;                     //联系人
@property (nonatomic , copy)NSString              *phone1;                      //手机号
@property (nonatomic , copy)NSString              *address1;                    //详细地址
@property (nonatomic , copy)NSString              *province ;                   //省
@property (nonatomic , copy)NSString              *city ;                            //市
@property (nonatomic , copy)NSString              *county ;                       //区
@property (nonatomic , retain)NSMutableArray *itemArr ;                   //订单明细

@end
