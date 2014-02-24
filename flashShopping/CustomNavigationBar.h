//
//  CustomNavigationBar.h
//  flashShopping
//
//  Created by Width on 14-1-20.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomNavigationBar : UIView <UITableViewDataSource , UITableViewDelegate>

@property ( nonatomic , retain )NSArray *titleArr;
- (id)initWithFrame:(CGRect)frame andTitleArr:(NSArray *)titleArr ;

@end
