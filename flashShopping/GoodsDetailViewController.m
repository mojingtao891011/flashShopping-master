//
//  GoodsDetailViewController.m
//  flashShopping
//
//  Created by Width on 14-1-23.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "GoodsDetailViewController.h"

@interface GoodsDetailViewController ()
{
    UITableView *_tableView ;
}
@end

@implementation GoodsDetailViewController

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
    self.titleLabel.text = @"商品详情";
    self.view.backgroundColor = [UIColor clearColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.dataSource = self ;
    _tableView.delegate = self ;
    UIView *tableView_bg = [[UIView alloc]init];
    tableView_bg.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = tableView_bg ;
    [self.view addSubview:_tableView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO ;
    
}
#pragma mark---UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2 ;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2 ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return _customCell ;
    }
    else if (indexPath.section == 0 && indexPath.row == 1) {
        
        _goodsImg.image =[UIImage imageNamed:_goodsModel.viewUrl];
        _goodsImg.left = 10;
        _goodsImg.height = 100 ;
        _goodsImg.width = 110 ;
        _goodsImg.top = (_goodsInfoCell.height - 100 ) / 2;
//        _sellStatus.text = @"[出售中]";
//        _sellStatus.left = _goodsImg.right ;
//        [_sellStatus sizeToFit];
        
        CGSize size = [_goodsModel.directions sizeWithFont:[UIFont systemFontOfSize:16.0] constrainedToSize:CGSizeMake(SCREENMAIN_WIDTH - _sellStatus.right, 300) lineBreakMode:NSLineBreakByCharWrapping];
        _goodsDescription.text = [NSString stringWithFormat:@"[出售中]%@",_goodsModel.directions] ;
        _goodsDescription.width = _goodsInfoCell.width - _goodsImg.right ;
        _goodsDescription.height = size.height ;
        _goodsDescription.left = _goodsImg.right ;
        NSLog(@"<<<<%f",size.height);
        
        _Number.text = @"编号:";
        _Number.top = _goodsDescription.bottom + 20 ;
        _Number.left = _goodsImg.right ;
        [_Number sizeToFit];
        _goodsNumber.text = _goodsModel.goodsCode ;
        _goodsNumber.left = _Number.right ;
        _goodsNumber.top = _Number.top ;
        [_goodsNumber sizeToFit];
        NSLog(@"++++%f",_num.height);
        
        _price.text = @"价格:";
        _price.top = _Number.bottom ;
        _price.left = _goodsImg.right ;
        [_price sizeToFit];
        _priceMomeny.text = [NSString stringWithFormat:@"￥%0.2f",_goodsModel.price];
        _priceMomeny.top = _Number.bottom ;
        _priceMomeny.left = _price.right ;
        [_priceMomeny sizeToFit];
        
        _num.text = @"库存:";
        _num.top = _price.bottom ;
        _num.left = _goodsImg.right ;
        [_num sizeToFit];
        _numNumber.text = [NSString stringWithFormat:@"%d",_goodsModel.num];
        _numNumber.top = _price.bottom ;
        _numNumber.left = _num.right ;
        [_numNumber sizeToFit];
        
        _timer.top = _num.bottom;
        _timer.left = _goodsImg.right;
        _timer.text = @"上架:2014:01:23 15:30:30";
        [_timer sizeToFit];
        
        return _goodsInfoCell ;
    }
    else if (indexPath.section == 1 && indexPath.row == 0) {
       
        return _customCell2 ;
    }
    else if (indexPath.section == 1 && indexPath.row == 1) {
        _edPrice.text = @"￥12.00";
        return _edInfoCell ;
    }

       return nil ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       if (indexPath.row == 1 && indexPath.section == 0 ) {
           CGSize size = [_goodsModel.directions sizeWithFont:[UIFont systemFontOfSize:16.0] constrainedToSize:CGSizeMake(200, 300) lineBreakMode:NSLineBreakByCharWrapping];
           _goodsInfoCell.height = size.height + _num.height * 5 ;
        return size.height + _num.height * 5;
    }
    return 44;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
