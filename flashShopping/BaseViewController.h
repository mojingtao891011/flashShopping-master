//
//  BaseViewController.h
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum loction{
    left = 0 ,
    right = 1 ,
}loction;
@interface BaseViewController : UIViewController
{
    BOOL _isLeftOrRight ;
}
@property (nonatomic , retain)UILabel *titleLabel;   //导航标题
@property (nonatomic , assign)enum loction ;

- (void)createUIBarButtonItemAndLoction:(NSInteger)loctions  image:(NSString*)imageName ;  //创建导航按钮
- (void)buttonItemClickAction:(UIButton *)buttonItem;  

@end
