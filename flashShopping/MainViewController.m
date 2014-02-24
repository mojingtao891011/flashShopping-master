//
//  MainViewController.m
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "MainViewController.h"
#import "ShopMvoingViewController.h"
#import "ShopManagerViewController.h"
#import "ChatViewController.h"
#import "MoreViewController.h"
#import "BaseNavViewController.h"

@interface MainViewController (){
    UIView *barView;
    NSTimer *timer;
}

//初始化MainViewController管理的4个ViewController
- (void)_initView;
//自定义ItemBar
- (void)customItemBar;

@end

@implementation MainViewController

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
    
    [self _initView];
    
    [self customItemBar];
	
}

//初始化MainViewController管理的4个ViewController；
- (void)_initView{
    
    //初始化视图控制器
    ShopMvoingViewController *shopMoveView=[[ShopMvoingViewController alloc]init];
    ShopManagerViewController *shopManagerView=[[ShopManagerViewController alloc]init];
    ChatViewController *chatView=[[ChatViewController alloc]init];
    MoreViewController *moreView=[[MoreViewController alloc]init];
    
    NSArray *viewArr=@[ shopMoveView ,shopManagerView , chatView , moreView ];
    NSMutableArray *navArr=[NSMutableArray new];
    
    
    for (UIViewController *view in viewArr) {
        //给视图控制器加导航
            BaseNavViewController *nav=[[BaseNavViewController alloc]initWithRootViewController:view];
            nav.delegate = self ;
             [navArr addObject:nav];
        }
    
    self.viewControllers=navArr;
}

//自定义ItemBar
- (void)customItemBar{
    
    barView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREENMAIN_HEIGHT-49, SCREENMAIN_WIDTH,49)];
    barView.backgroundColor=[UIColor redColor];
    [self.view addSubview:barView];
    
    NSArray *imgNormaArr=@[@"buttom_shopMoving",@"buttom_shopManager",@"chat",@"button_more.png"];
    NSArray *imgSelectedArr=@[@"buttom_shopMoving_bg",@"buttom_shopManager_bg",@"chat_bg",@"button_more_bg"];
    
    for (int i=0; i<imgNormaArr.count ; i++) {
        
        UIButton *itemButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [itemButton setFrame:CGRectMake(i*SCREENMAIN_WIDTH/imgNormaArr.count, 0, SCREENMAIN_WIDTH/imgNormaArr.count, 49)];
        itemButton.tag=100+i;
        [itemButton setBackgroundImage:[UIImage imageNamed:imgNormaArr[i]] forState:UIControlStateNormal];
        [itemButton setImage:[UIImage imageNamed:imgSelectedArr[i]] forState:UIControlStateSelected];
        [itemButton addTarget:self action:@selector(selectedViewControllers:) forControlEvents:UIControlEventTouchUpInside];
        
        [barView addSubview:itemButton];
    }
    
}

//ViewController视图之间的切换
- (void)selectedViewControllers:(UIButton*)button{
    for (UIView *v  in barView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *b=(UIButton*)v;
            b.selected=NO;
        }
    }
    self.selectedIndex=button.tag-100;
    button.selected=YES;
}

//是否要显示BarItem
- (void)showBarItem:(BOOL)show
{
    [UIView animateWithDuration:0 animations:^{
        if (show) {
            self.tabBar.hidden = YES;
            [barView setFrame:CGRectMake(0, SCREENMAIN_HEIGHT-49, SCREENMAIN_WIDTH,49)];
        }else{
            self.tabBar.hidden = YES;
            [barView setFrame:CGRectMake(-320, SCREENMAIN_HEIGHT-49, SCREENMAIN_WIDTH,49)];
        }

    }];
    [self resizeView:show];
}

//隐藏tabBar后调整frame
- (void)resizeView:(BOOL)isFrame{
    
  
    for (UIView *subView in self.view.subviews) {
       
        if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            if (isFrame) {
                [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y, SCREENMAIN_WIDTH, 480-49)];
            }else{
                [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y, SCREENMAIN_WIDTH, 480 )];
            }
           
        }
    }}

#pragma mark-----UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    int count = navigationController.viewControllers.count ;
    if (count == 1) {
        [self showBarItem:YES];
    }else{
        [self showBarItem:NO];
    }
}

#pragma mark----Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
