//
//  GoodsDetailViewController.h
//  flashShopping
//
//  Created by Width on 14-1-23.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseViewController.h"
#import "GoodsManamentModel.h"

@interface GoodsDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property ( nonatomic ,retain)GoodsManamentModel *goodsModel;
@property (strong, nonatomic) IBOutlet UITableViewCell *customCell;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *goodsImg;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *sellStatus;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *goodsDescription;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *Number;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *goodsNumber;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *price;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *priceMomeny;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *num;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *numNumber;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *timer;
@property (strong, nonatomic) IBOutlet UITableViewCell *goodsInfoCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *customCell2;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *edPrice;
@property (strong, nonatomic) IBOutlet UITableViewCell *edInfoCell;

@end
