//
//  ViewController.m
//  flashShopping
//
//  Created by Width on 14-1-10.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "LandViewController.h"
#import "MainViewController.h"
#import "SGDataService.h"

@interface LandViewController ()<UITextFieldDelegate>
{
    UIScrollView *scrollView ;
    UIImageView *imageViewBg ;
    UIView *langView ;
    UITextField *userName ;
    UITextField *userPossWord ;
    UIButton *StatusButton ;
    NSUserDefaults *userDefaults ;
}
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
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    //初始化登陆界面并存数据
    [self loadLandView] ;
    //存完再取
    [self loadUserDefaultsData];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [UIView animateWithDuration:0.5 animations:^{
        [langView setFrame:CGRectMake(10,imageViewBg.bottom + 20 , SCREENMAIN_WIDTH-20, 170)];
    }];
    
}
#pragma mark----UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES ;
}
#pragma mark-------
- (void)loadLandView
{
    //总体是个UIScrollView
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT)];
    scrollView.contentSize = CGSizeMake(SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT + 60);
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    //最上面得logo
    imageViewBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, 145)];
    imageViewBg.userInteractionEnabled = YES ;
    imageViewBg.image = [UIImage imageNamed:@"landLogo.jpg"];
    [scrollView addSubview:imageViewBg];
    //用户名／密码／是否记住／登陆的父视图
    langView = [[UIView alloc]initWithFrame:CGRectMake(10, SCREENMAIN_HEIGHT, SCREENMAIN_WIDTH - 20, 170)];
    langView.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:langView];
    //用户名／密码的背景图
    UIImageView *landViewBg = [[UIImageView alloc]initWithFrame:CGRectMake( 0, 0, langView.width, 89)];
    landViewBg.userInteractionEnabled = YES ;
    landViewBg.image = [UIImage imageNamed:@"langImgbg"] ;
    landViewBg.backgroundColor = [UIColor clearColor];
    [langView addSubview:landViewBg];
    userName = [[UITextField alloc]initWithFrame:CGRectMake(10, 7, landViewBg.width - 5, 45)];
    userName.delegate = self ;
    userName.borderStyle = UITextBorderStyleNone ;
    userName.placeholder = @"请输入用户名" ;
    userName.clearButtonMode = UITextBorderStyleNone ;
    userName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter ;
    userName.autocapitalizationType = UITextAutocapitalizationTypeNone ;
    [landViewBg addSubview:userName];
    userPossWord = [[UITextField alloc]initWithFrame:CGRectMake(10, userName.bottom, landViewBg.width - 5, 45)];
    userPossWord.delegate = self ;
    userPossWord.borderStyle = UITextBorderStyleNone ;
    userPossWord.placeholder = @"请输入密码" ;
    userPossWord.secureTextEntry = YES ;
    [landViewBg addSubview:userPossWord];
    //是否记住
    StatusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [StatusButton setFrame:CGRectMake(0, userPossWord.bottom + 10, 15, 15)];
    [StatusButton setBackgroundImage:[UIImage imageNamed:@"remember"] forState:UIControlStateNormal];
     [StatusButton setBackgroundImage:[UIImage imageNamed:@"remember_bg"] forState:UIControlStateSelected];
    [StatusButton addTarget:self action:@selector(isRememberUserName:) forControlEvents:UIControlEventTouchUpInside];
    [langView addSubview:StatusButton];
    
    UILabel *isRememberLabel = [[UILabel alloc]initWithFrame:CGRectMake(StatusButton.right + 20, userPossWord.bottom + 8, 20, 20)];
    isRememberLabel.text = @"记住用户名" ;
    [isRememberLabel sizeToFit];
    [langView addSubview:isRememberLabel];
    //登陆
    UIButton *landButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [landButton setFrame:CGRectMake(0, langView.height - 40, langView.width, 40)];
    [landButton setBackgroundImage:[UIImage imageNamed:@"landButton"] forState:UIControlStateNormal];
    [landButton addTarget:self action:@selector(landButton:) forControlEvents:UIControlEventTouchUpInside];
    [langView addSubview:landButton];
}
- (void)isRememberUserName:(UIButton*)button
{
    button.selected = !button.selected ;
    if (button.selected) {
        [userDefaults setObject:userName.text forKey:@"userName"];
        [userDefaults setObject:userPossWord.text forKey:@"userPossWord"];
        [userDefaults setBool:button.selected forKey:@"isRemember"];
        [userDefaults synchronize];
    }else{
        [userDefaults removeObjectForKey:@"userName"];
        [userDefaults removeObjectForKey:@"userPossWord"];
        [userDefaults removeObjectForKey:@"isRemember"];
        [userDefaults synchronize];
    }
}
- (void)loadUserDefaultsData
{
    userName.text = [userDefaults objectForKey:@"userName"];
    userPossWord.text = [userDefaults objectForKey:@"userPossWord"];
    StatusButton.selected = [userDefaults boolForKey:@"isRemember"];

}
#pragma mark------登陆
- (void)landButton:(UIButton*)button
{
    NSDictionary *dict = @{@"actionCode":@"21" ,  @"appType":@"json" };
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    [mutableDict setObject:userName.text forKey:@"username"] ;
    [mutableDict setObject:userPossWord.text forKey:@"password"] ;
    [SGDataService requestWithUrl:BASEURL dictParams:mutableDict httpMethod:@"post" completeBlock:^(id result){
        if ([result[@"content"] isKindOfClass:[NSDictionary class]]) {
            NSString *companyId = result[@"content"][@"entId"] ;
            [userDefaults setObject:companyId forKey:COMPANYID] ;
            [userDefaults synchronize] ;
            
             MainViewController *mainViewCtl = [[MainViewController alloc]init];
            mainViewCtl.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal ;
            [self presentModalViewController:mainViewCtl animated:YES];
        }else{

             UIAlertView *alertView =[ [UIAlertView alloc]initWithTitle:@"友情提示" message:result[@"content"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"返回", nil];
            [alertView show] ;
        }
    }];
    
}
#pragma mark------MemoryManagement
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
