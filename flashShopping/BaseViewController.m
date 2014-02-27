//
//  BaseViewController.m
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //自定义导航标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 125, 40)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = _titleLabel;
    
	//背景图片
   // self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    if (self.navigationController.viewControllers.count > 1) {
        //自定义ButtonItem
        UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonItem setFrame:CGRectMake(0, 10, 20, 20)];
        [buttonItem setBackgroundImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
        [buttonItem addTarget:self action:@selector(buttonItemClickAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:buttonItem];
        self.navigationItem.leftBarButtonItem = barButtonItem ;
    }
    
}

#pragma mark------Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark------customMethod
- (void)createUIBarButtonItemAndLoction:(NSInteger)loctions  image:(NSString*)imageName
{
    _isLeftOrRight = loctions ;
    //自定义ButtonItem
    UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonItem setFrame:CGRectMake(0, 10, 20, 20)];
    [buttonItem setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [buttonItem addTarget:self action:@selector(buttonItemClickAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:buttonItem];
    
    if (loctions == left) {
        self.navigationItem.leftBarButtonItem = barButtonItem ;
    }else{
        self.navigationItem.rightBarButtonItem = barButtonItem ;
    }
    
}
- (void)buttonItemClickAction:(UIButton *)buttonItem
{
    if (!_isLeftOrRight) {
        [self.navigationController popViewControllerAnimated:YES];
    }
        
}
@end
