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
    //refresh按钮
    CustomUIBarButtonItem *barButton = [[CustomUIBarButtonItem alloc]initWithFrame:CGRectMake(0, 0, 25, 25) andSetdelegate:self andImageName:@"refresh"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:barButton];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
#pragma mark------barButtonProtocol
- (void)actions:(id)sender
{
    NSLog(@"refresh");
}
#pragma  mark-----memoryManager
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark------customMethod
- (void)startLoadNet
{
    
}
@end
