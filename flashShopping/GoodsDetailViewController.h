//
//  GoodsDetailViewController.h
//  flashShopping
//
//  Created by Width on 14-1-23.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseViewController.h"
#import "GoodInfoModle.h"

@interface GoodsDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property ( nonatomic ,retain)GoodInfoModle *goodsModel;
@property (strong, nonatomic) IBOutlet UITableViewCell *customCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *customCell2;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *edPrice;
@property (strong, nonatomic) IBOutlet UITableViewCell *edInfoCell;
- (IBAction)ModifyInfoButton:(id)sender;

@end
