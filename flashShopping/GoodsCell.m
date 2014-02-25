//
//  GoodsCell.m
//  flashShopping
//
//  Created by Width on 14-1-20.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
/*
@property ( nonatomic , retain )UIImageView         *goodsImgView;                      //商品图片
@property ( nonatomic , retain )UILabel                   *sellStatusLabel;                      //出售状态
@property ( nonatomic , retain )UILabel                   *directionsLabel;                     //商品描述
@property ( nonatomic , retain ) UILabel                   *priceLabel;                             //价格（字体）
@property ( nonatomic , retain ) UILabel                   *priceMoneyLabel;                  //价格
@property ( nonatomic , retain ) UILabel                   *numLabel;                               //库存 （字体）
@property ( nonatomic , retain ) UILabel                   *numNumberabel;                   //库存
*/

#import "GoodsCell.h"
#import "UIImageView+WebCache.h"

@implementation GoodsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initSunView];
       
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)_initSunView
{
   
    //图片
    _goodsImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_goodsImgView];
    //商品描述
    _directionsLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_directionsLabel];
    //商品编号
    _goodsCodeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_goodsCodeLabel];
     //价格（字体）
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_priceLabel];
    //价格
    _priceMoneyLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_priceMoneyLabel];
     //库存
    _numLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_numLabel];
     //库存数量
    _numNumberabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_numNumberabel];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //图片
    [_goodsImgView setFrame:CGRectMake(10, 10, 80, 80)];
    [_goodsImgView setImageWithURL:[NSURL URLWithString:_goodsModel.viewUrl] placeholderImage:[UIImage imageNamed:@"init.jpg"]];
    
    //商品描述
    CGSize size = [_goodsModel.name sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake( 100 , 300) lineBreakMode:NSLineBreakByCharWrapping];
    [_directionsLabel setFrame:CGRectMake(_goodsImgView.right,  5,  self.width - _goodsImgView.right , size.height - 15 )];
    _directionsLabel.numberOfLines = 0 ;
    _directionsLabel.backgroundColor = [UIColor clearColor];
    _directionsLabel.text = [NSString stringWithFormat:@"[出售中]%@",_goodsModel.name];
        
    //商品编号
    _goodsCodeLabel.left = _goodsImgView.right ;
    _goodsCodeLabel.top = _directionsLabel.bottom ;
    [_goodsCodeLabel sizeToFit];
    
    //价格（字体）
    _priceLabel.left = _goodsImgView.right ;
    _priceLabel.top = _goodsCodeLabel.bottom ;
    _priceLabel.text = @"价格：";
    _priceLabel.backgroundColor = [UIColor clearColor];
    [_priceLabel sizeToFit];
   
    
    //价格
    _priceMoneyLabel.left = _priceLabel.right ;
    _priceMoneyLabel.top = _priceLabel.top ;
    _priceMoneyLabel.text = [NSString stringWithFormat:@"%@",_goodsModel.price];
    _priceMoneyLabel.textColor = [UIColor redColor];
    _priceMoneyLabel.backgroundColor = [UIColor clearColor];
    [_priceMoneyLabel sizeToFit];
    
    //库存
    [_numLabel setFrame:CGRectMake(_priceLabel.left, _priceLabel.bottom, 0, 0)];
    _numLabel.text = @"库存：";
    _numLabel.backgroundColor = [UIColor clearColor];
    [_numLabel sizeToFit];

    //库存数量
    [_numNumberabel setFrame:CGRectMake(_numLabel.right, _priceLabel.bottom, 0, 0)];
    _numNumberabel.text = [NSString stringWithFormat:@"%@",_goodsModel.num] ;
    _numNumberabel.backgroundColor = [UIColor clearColor];
    [_numNumberabel sizeToFit];
    
    
}
@end
