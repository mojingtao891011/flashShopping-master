//
//  LogisticViewController.m
//  flashShopping
//
//  Created by Width on 14-2-26.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "LogisticViewController.h"

@interface LogisticViewController ()

@end

@implementation LogisticViewController

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
    self.titleLabel.text = @"物流信息";
    //创建导航栏上的保存按钮
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.width = 50 ;
    saveButton.height = 30 ;
    [saveButton setBackgroundImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveModifyInfo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveButton];
    self.bodyView.height = SCREENMAIN_HEIGHT ;
    if (IOS_VERSION < 7.0) {
        self.bodyView.top = - 64 ;
    }

}
#pragma mark---MemoryManager
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---customModth
- (void)saveModifyInfo
{
    NSLog(@"sbsd");
}

@end
