//
//  BaseViewController.h
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic , retain)UILabel *titleLabel;   //导航标题

- (void)createUIBarButtonItem:(BOOL)isRightOrLeft  image:(NSString*)imageName ;  //创建导航按钮
- (void)buttonItemClickAction:(UIButton *)buttonItem;  

@end
