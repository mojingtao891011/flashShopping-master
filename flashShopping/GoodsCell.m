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
    //出售状态
    _isUpLabel = [[UILabel alloc]init];
    [_directionsLabel addSubview:_isUpLabel];
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
    [self setIntroductionText:_goodsModel.name];
    _directionsLabel.left = _goodsImgView.right + 5;
    _directionsLabel.top = 10 ;
    _directionsLabel.width = self.width - _goodsImgView.width - 20 ;
    _directionsLabel.numberOfLines = 0 ;
    _directionsLabel.backgroundColor = [UIColor clearColor];
    _directionsLabel.textColor = nameTextColor ;
    _directionsLabel.text = [NSString  stringWithFormat:@"              %@",_goodsModel.name];
    
    //出售状态
    _isUpLabel.left = 0 ;
    _isUpLabel.top = 0 ;
    _isUpLabel.textColor = [UIColor redColor];
   // NSLog(@"goodsIsUP = %d",_goodsModel.isUp);
    
    if ([_goodsModel.isUp isEqualToString:@"1" ]) {
        _isUpLabel.text = @"[出售中]";
    }else{
        _isUpLabel.text = @"[已下架]";
    }
    [_isUpLabel sizeToFit];
    
//    //商品编号
//    _goodsCodeLabel.left = _directionsLabel.left ;
//    _goodsCodeLabel.top = _directionsLabel.bottom ;
//    [_goodsCodeLabel sizeToFit];
    
    //价格（字体）
    _priceLabel.left = _directionsLabel.left ;
    _priceLabel.top = _directionsLabel.bottom ;
    _priceLabel.text = @"价格：";
    _priceLabel.textColor = priceTextColor ;
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
    _numLabel.textColor = priceTextColor ;
    _numLabel.backgroundColor = [UIColor clearColor];
    [_numLabel sizeToFit];

    //库存数量
    [_numNumberabel setFrame:CGRectMake(_numLabel.right, _priceLabel.bottom, 0, 0)];
    _numNumberabel.text = [NSString stringWithFormat:@"%@",_goodsModel.num] ;
    _numNumberabel.textColor = nameTextColor ;
    _numNumberabel.backgroundColor = [UIColor clearColor];
    [_numNumberabel sizeToFit];
    
  
}

//赋值 and 自动换行,计算出cell的高度
-(void)setIntroductionText:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.directionsLabel.text = text;
    //设置label的最大行数
    self.directionsLabel.numberOfLines = 10;
    CGSize size = CGSizeMake(220, 300);
    CGSize labelSize = [self.directionsLabel.text sizeWithFont:self.directionsLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    self.directionsLabel.frame = CGRectMake(self.directionsLabel.frame.origin.x, self.directionsLabel.frame.origin.y, labelSize.width, labelSize.height );
    
    //计算出自适应的高度
    if (labelSize.height < 60) {
        frame.size.height = 100 ;
    }else{
        frame.size.height = labelSize.height+40;
    }
    
    
    self.frame = frame;
}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//    
//}

@end
