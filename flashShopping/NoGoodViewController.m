//
//  NoGoodViewController.m
//  flashShopping
//
//  Created by Width on 14-2-27.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "NoGoodViewController.h"

@interface NoGoodViewController ()

@end

@implementation NoGoodViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"缺货商品" ;
    [self createUIBarButtonItemAndLoction:right image:@"refresh"];
}
#pragma mark------customMethod
- (void)buttonItemClickAction:(UIButton *)buttonItem
{
    NSLog(@"refresh");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
