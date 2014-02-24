//
//  PullNenu.h
//  flashShopping
//
//  Created by Width on 14-2-11.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PullNenu : UIView<UITableViewDataSource ,UITableViewDelegate>

- (id)initWithFrame:(CGRect)frame  AndTitleArr:(NSArray*)titleArr;

@end
