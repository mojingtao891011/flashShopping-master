//
//  DetailViewController.m
//  flashShopping
//
//  Created by Width on 14-1-13.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "DetailViewController.h"
#import "BasicInfoViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    self.title = @"商品详情";
    self.isBack = YES ;
    self.isAddRefreshButton = YES ;
    if (IOS_VERSION < 7.0) {
        [_bobyView setFrame:CGRectMake(0, 10, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT-20-44-10)];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editor:(id)sender {
    
    BasicInfoViewController *basicInfoView = [[BasicInfoViewController alloc]init];
    [self.navigationController pushViewController:basicInfoView animated:YES];
}
@end
