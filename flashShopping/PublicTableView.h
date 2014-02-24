//
//  PublicTableView.h
//  flashShopping
//
//  Created by Width on 14-1-16.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseTableView.h"

@interface PublicTableView : BaseTableView <UITableViewDataSource,UITableViewDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *orderCode;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *orderState;

@property (nonatomic , retain)NSMutableDictionary *itemDict ;
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andDataDic:(NSMutableDictionary*)DataDic ;

@end
