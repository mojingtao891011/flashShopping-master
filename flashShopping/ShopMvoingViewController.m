//
//  ShopMvoingViewController.m
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "ShopMvoingViewController.h"
#import "BaseTableView.h"
#import "BaseNavViewController.h"


@interface ShopMvoingViewController ()
@end

@implementation ShopMvoingViewController

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
    self.view.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = @"店铺动态";
    NSLog(@"hebingceshi2133132231");
   
        
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
@end
