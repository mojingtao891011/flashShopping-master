//
//  ViewController.m
//  flashShopping
//
//  Created by Width on 14-1-10.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "LandViewController.h"

@interface LandViewController ()

- (void)loadLandView ;

@end

@implementation LandViewController

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

    
}
- (void)loadLandView
{
    UIImageView *landLogoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT-44-20)];
    landLogoView.image = [UIImage imageNamed:@"landLogo"];
}
#pragma mark------MemoryManagement
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
