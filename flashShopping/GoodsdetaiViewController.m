//
//  GoodsdetaiViewController.m
//  flashShopping
//
//  Created by 莫景涛 on 14-3-11.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "GoodsdetaiViewController.h"
#import "UIImageView+WebCache.h"
#import "CustomUIBarButtonItem.h"
#import "ModifyInfoViewController.h"
#import "LogisticViewController.h"

@interface GoodsdetaiViewController ()<barButtonProtocol>
{
    UIScrollView *scrollView ;
    UIImageView *imageViewgoodsInfoBg ;
    UIImageView *imageViewLogisticInfoBg ;
    
    UIImageView *goodsImg ;
    UILabel *goodsName ;
    UILabel *Status ;
    UILabel *goodsCode ;
    UILabel *goodsPrice ;
    UILabel *goodsNum ;
    UILabel *goodsUpTime ;
    
    UILabel *LogisticType ;
    UILabel *LogisticPrice ;
    
}
@end

@implementation GoodsdetaiViewController

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
    self.navigationController.navigationBar.hidden = NO ;
    self.titleLabel.text = @"基本详情" ;
    
    CustomUIBarButtonItem *barButton = [[CustomUIBarButtonItem alloc]initWithFrame:CGRectMake(0, 0, 20, 20) andSetdelegate:self andImageName:@"refresh"];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:barButton];
    self.navigationItem.rightBarButtonItem = barButtonItem ;
    [self _initView];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self ];
}
#pragma mark----barButtonProtocol
#pragma mark----点击刷新按钮
- (void)actions:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshData" object:[NSString stringWithFormat:@"%d" , _index]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshUI:) name:@"toGoodsDetaiView" object:nil];
}
#pragma mark----NSNotificationCenter
#pragma mark----更新数据
- (void)refreshUI:(NSNotification*)note
{
    _goodsDataModel = [note object];
    [self loadGoodsDataModelInfo];
}
#pragma mark----customMethod
- (void)_initView
{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT )];
    scrollView.contentSize = CGSizeMake(SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT + 60);
    [self.view addSubview:scrollView];
    
    imageViewgoodsInfoBg = [[UIImageView alloc]initWithFrame:CGRectMake(5, 20, SCREENMAIN_WIDTH - 10, 171)];
    imageViewgoodsInfoBg.userInteractionEnabled = YES ;
    imageViewgoodsInfoBg.image = [UIImage imageNamed:@"goodInfoBg"];
    [scrollView addSubview:imageViewgoodsInfoBg];
    
    imageViewLogisticInfoBg = [[UIImageView alloc]initWithFrame:CGRectMake(5, imageViewgoodsInfoBg.bottom + 30, SCREENMAIN_WIDTH - 10, 86)];
    imageViewLogisticInfoBg.userInteractionEnabled = YES ;
    imageViewLogisticInfoBg.image = [UIImage imageNamed:@"LogisticInfoBg"];
    [scrollView addSubview:imageViewLogisticInfoBg];
    
    UILabel *goodsInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 30, 25)];
    goodsInfoLabel.text = @"商品信息" ;
    [goodsInfoLabel sizeToFit];
    [imageViewgoodsInfoBg addSubview:goodsInfoLabel];
    
    UIButton *penButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [penButton setBackgroundImage:[UIImage imageNamed:@"pen"] forState:UIControlStateNormal];
    [penButton addTarget:self action:@selector(editorInfo:) forControlEvents:UIControlEventTouchUpInside];
    [penButton setFrame:CGRectMake(imageViewgoodsInfoBg.width - 80, 13, 16, 16)];
    [imageViewgoodsInfoBg addSubview:penButton];
    
    UIButton *EditorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [EditorButton setTitle:@"编辑" forState:UIControlStateNormal];
    [EditorButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [EditorButton sizeToFit];
    [EditorButton addTarget:self action:@selector(editorInfo:) forControlEvents:UIControlEventTouchUpInside];
    [EditorButton setFrame:CGRectMake(penButton.right + 10, 10, 40, 25)];
    [imageViewgoodsInfoBg addSubview:EditorButton];
    
    goodsImg  = [[UIImageView alloc]init ];
    [imageViewgoodsInfoBg addSubview:goodsImg];
    goodsName = [[UILabel alloc]init ];
    [imageViewgoodsInfoBg addSubview:goodsName];
    Status = [[UILabel alloc]init];
    [goodsName addSubview:Status];
    goodsCode = [[UILabel alloc]init ] ;
    [imageViewgoodsInfoBg addSubview:goodsCode];
    goodsPrice = [[UILabel alloc]init ];
    [imageViewgoodsInfoBg addSubview:goodsPrice];
    goodsNum = [[UILabel alloc]init];
    [imageViewgoodsInfoBg addSubview:goodsNum];
    goodsUpTime = [[UILabel alloc]init ] ;
    [imageViewgoodsInfoBg addSubview:goodsUpTime];
    
    UILabel *LogisticInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 30, 25)];
    LogisticInfoLabel.text = @"物流信息" ;
    [LogisticInfoLabel sizeToFit];
    [imageViewLogisticInfoBg addSubview:LogisticInfoLabel];
    
    UIButton *LogistipenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [LogistipenButton setBackgroundImage:[UIImage imageNamed:@"pen"] forState:UIControlStateNormal];
    [LogistipenButton addTarget:self action:@selector(editorLogistiInfo:) forControlEvents:UIControlEventTouchUpInside];
    [LogistipenButton setFrame:CGRectMake(imageViewLogisticInfoBg.width - 80, 13, 16, 16)];
    [imageViewLogisticInfoBg addSubview:LogistipenButton];
    
    UIButton *LogistiEditorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [LogistiEditorButton setTitle:@"编辑" forState:UIControlStateNormal];
    [LogistiEditorButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [LogistiEditorButton addTarget:self action:@selector(editorLogistiInfo:) forControlEvents:UIControlEventTouchUpInside];
    [LogistiEditorButton setFrame:CGRectMake(LogistipenButton.right + 10, 10, 40, 25)];
    [imageViewLogisticInfoBg addSubview:LogistiEditorButton];
    
    LogisticType = [[UILabel alloc]init] ;
    [imageViewLogisticInfoBg addSubview:LogisticType];
    LogisticPrice = [[UILabel alloc]init ];
    [imageViewLogisticInfoBg addSubview:LogisticPrice];

    [self loadGoodsDataModelInfo] ;
}
- (void)loadGoodsDataModelInfo
{
    //商品图片
    [goodsImg setFrame:CGRectMake(10, 60, 80, 80)];
    [goodsImg setImageWithURL:[NSURL URLWithString:_goodsDataModel.viewUrl] placeholderImage:[UIImage imageNamed:@"init.jpg"]];
    goodsImg.backgroundColor = [UIColor clearColor];
    //商品描述
    [goodsName setFrame:CGRectMake(goodsImg.right + 10, goodsImg.top - 10, self.view.width - goodsImg.right - 25, 20)];
    goodsName.text = [NSString stringWithFormat:@"             %@",_goodsDataModel.name];
    CGSize size = [_goodsDataModel.name sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(goodsName.width, 120) lineBreakMode:NSLineBreakByWordWrapping];
    goodsName.numberOfLines = 0 ;
    goodsName.height = size.height ;
    [goodsName sizeToFit];
    goodsName.textColor = nameTextColor ;
    goodsName.backgroundColor = [UIColor clearColor];
    //商品状态
    [Status setFrame:CGRectMake(0, 0, 30, 20)];
    if ([_goodsDataModel.isUp isEqualToString:@"1"]) {
        Status.text = @"[出售中]" ;
    }else{
        Status.text = @"[已下架]" ;
    }
    Status.textColor = [UIColor redColor];
    [Status sizeToFit];
    [Status setBackgroundColor:[UIColor clearColor]];
    //商品编号
    [goodsCode setFrame:CGRectMake(goodsName.left, goodsName.bottom, 50, 20)];
    goodsCode.text = [NSString stringWithFormat:@"商品编号:%@",_goodsDataModel.goodsCode] ;
    [goodsCode sizeToFit];
    goodsCode.textColor = priceTextColor ;
    goodsCode.backgroundColor = [UIColor clearColor];
    //商品价格
    UILabel *priceTitle = nil ;
    if (priceTitle == nil) {
        priceTitle = [[UILabel alloc]initWithFrame:CGRectMake(goodsCode.left, goodsCode.bottom, 20, 20)];
        [imageViewgoodsInfoBg addSubview:priceTitle];
        priceTitle.text = @"价格:" ;
        priceTitle.textColor = priceTextColor ;
        [priceTitle sizeToFit];
    }
    [goodsPrice setFrame:CGRectMake(priceTitle.right, goodsCode.bottom , 50, 20)];
    goodsPrice.text = [NSString stringWithFormat:@"¥%@",_goodsDataModel.price] ;
    [goodsPrice sizeToFit];
    goodsPrice.textColor = [UIColor greenColor] ;
    goodsPrice.backgroundColor = [UIColor clearColor];
    //商品库存
    [goodsNum setFrame:CGRectMake(priceTitle.left, goodsPrice.bottom, 50, 20)];
    goodsNum.text = [NSString stringWithFormat:@"库存:%@",_goodsDataModel.num] ;
    [goodsNum sizeToFit];
    goodsNum.textColor = priceTextColor ;
    goodsNum.backgroundColor = [UIColor clearColor];
    //商品上市时间
    [goodsUpTime setFrame:CGRectMake(goodsNum.left, goodsNum.bottom, 50, 20)];
    goodsUpTime.hidden = YES ;
    goodsUpTime.backgroundColor = [UIColor clearColor];
    //物流
    [LogisticType setFrame:CGRectMake(10, 50, 20, 20)];
    LogisticType.text = @"普通物流" ;
    LogisticType.textColor = priceTextColor ;
    [LogisticType sizeToFit];
    [LogisticPrice setFrame:CGRectMake(LogisticType.right + 20, 50, 20, 20)];
    LogisticPrice.text = @"¥12.00" ;
    [LogisticPrice sizeToFit];
    LogisticPrice.textColor = [UIColor greenColor];
    
    if (goodsName.height + 80 >130) {
        imageViewgoodsInfoBg.height = goodsName.height + 120 ;
    }else
    {
        imageViewgoodsInfoBg.height = 171 ;
    }
}

- (void)editorInfo:(UIButton*)sender
{
    ModifyInfoViewController *modifyInfoViewCtl = [[ModifyInfoViewController alloc]init];
    modifyInfoViewCtl.Id = _goodsDataModel.Id ;
    modifyInfoViewCtl.goodsId = _goodsDataModel.goodsId ;
    [self.navigationController pushViewController:modifyInfoViewCtl animated:YES];
}
- (void)editorLogistiInfo:(UIButton*)sender
{
    LogisticViewController *logisticViewCtl = [[LogisticViewController alloc]init];
    [self.navigationController pushViewController:logisticViewCtl animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
