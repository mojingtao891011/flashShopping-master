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
    _titleLabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.titleView = _titleLabel;
    
	//背景图片
//    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, SCREENMAIN_WIDTH, 568)];
//    backgroundView.userInteractionEnabled = YES ;
//    backgroundView.image = [UIImage imageNamed:@"background"];
//    backgroundView.contentMode = UIViewContentModeScaleToFill ;
//    self.view = backgroundView ;
    //[self.view addSubview:backgroundView];
    
       if (self.navigationController.viewControllers.count > 1) {
        //自定义ButtonItem
        UIButton *buttonItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonItem setFrame:CGRectMake(0, 10, 20, 20)];
        [buttonItem setBackgroundImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
        [buttonItem addTarget:self action:@selector(buttonItemClickAction) forControlEvents:UIControlEventTouchUpInside];
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
- (void)buttonItemClickAction
{
        [self.navigationController popViewControllerAnimated:YES];
        
}
@end
