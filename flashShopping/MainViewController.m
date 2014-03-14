//
//  MainViewController.m
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "MainViewController.h"
#import "ShopMvoingViewController.h"
#import "GoodManagerViewController.h"
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
    
    ChatViewController *chatView=[[ChatViewController alloc]init];
    MoreViewController *moreView=[[MoreViewController alloc]init];
    
    NSArray *viewArr=@[ shopMoveView , chatView , moreView ];
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
    
    NSArray *imgNormaArr = @[@"ItemBar1-1",@"ItemBar2-1",@"ItemBar3-1"];
    NSArray *imgSelectedArr = @[@"ItemBar1-2",@"ItemBar2-2",@"ItemBar3-2"];
    
    for (int i=0; i<imgNormaArr.count ; i++) {
        
        UIButton *itemButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [itemButton setFrame:CGRectMake(i*SCREENMAIN_WIDTH/imgNormaArr.count, 0, SCREENMAIN_WIDTH/imgNormaArr.count, 49)];
        itemButton.tag=100+i;
        if (itemButton.tag == 100) {
            _lastSelecteButton = itemButton ;
            _lastSelecteButton.selected = YES ;
        }
        [itemButton setBackgroundImage:[UIImage imageNamed:imgNormaArr[i]] forState:UIControlStateNormal];
        [itemButton setImage:[UIImage imageNamed:imgSelectedArr[i]] forState:UIControlStateSelected];
        [itemButton addTarget:self action:@selector(selectedViewControllers:) forControlEvents:UIControlEventTouchUpInside];
        
        [barView addSubview:itemButton];
    }
    
}

//ViewController视图之间的切换
- (void)selectedViewControllers:(UIButton*)button{

    button.selected = YES ;
    _lastSelecteButton.selected = NO ;
    _lastSelecteButton = button ;
    self.selectedIndex = button.tag - 100 ;
 
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
                [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT-49)];
            }else{
                [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT)];
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
