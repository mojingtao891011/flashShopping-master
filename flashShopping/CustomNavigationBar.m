//
//  CustomNavigationBar.m
//  flashShopping
//
//  Created by Width on 14-1-20.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar
{
    UITableView *pulltableView;
    UIView *fatherView ;
    UIButton *titleButton ;
    UIButton *pullDwonButton ;
    BOOL flag ;
}

- (id)initWithFrame:(CGRect)frame andTitleArr:(NSArray *)titleArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.titleArr = [NSArray new];
        _titleArr = [ titleArr copy];
        flag = YES ;
        [self _initView];
    }
    return self;
}

- (void)_initView
{
    //自定义导航栏
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"navigationbarBackground"]];
    [imageView setFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, 44)];
    imageView.userInteractionEnabled = YES ;
    [self addSubview:imageView];
    
    // 导航栏左边按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(10, 12, 20, 20)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(returnAction) forControlEvents: UIControlEventTouchUpInside];
    [imageView addSubview:leftButton];
    
     //导航栏标题
    titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleButton setFrame:CGRectMake( (SCREENMAIN_WIDTH - 100 ) / 2, 5, 100, 34)];
    titleButton.tag = 100 ;
    [titleButton setTitle:_titleArr[0] forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(pullDwonAction) forControlEvents: UIControlEventTouchUpInside];
    [imageView addSubview:titleButton];
    
     //导航栏下拉菜单
    pullDwonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pullDwonButton setFrame:CGRectMake(titleButton.left + titleButton.width, 15, 15, 14)];
    pullDwonButton .showsTouchWhenHighlighted = YES ;
    [pullDwonButton setBackgroundImage:[UIImage imageNamed:@"pullDownButton"] forState:UIControlStateNormal];
    [pullDwonButton addTarget:self action:@selector(pullDwonAction) forControlEvents: UIControlEventTouchUpInside];
    [imageView addSubview:pullDwonButton];
    
     //导航栏右边刷新按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(SCREENMAIN_WIDTH - 30, 12, 20, 20)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [imageView addSubview:rightButton];
    
     //下拉视图菜单
    fatherView = [[UIView alloc]initWithFrame:CGRectMake(110, 25, 130, 100)];
    fatherView.height = _titleArr.count * 36 ;
    CGRect    subFrame = fatherView.frame ;
    fatherView.backgroundColor = [UIColor clearColor];
    fatherView.hidden = YES ;
    [self addSubview:fatherView];
    
    //背景图片的拉伸
    UIImageView *pullDwonVIewbg = [[UIImageView alloc]initWithFrame:subFrame];
    pullDwonVIewbg.image = [UIImage imageNamed:@"pullViewbackground"];
    UIImage *newImg = [pullDwonVIewbg .image stretchableImageWithLeftCapWidth:10 topCapHeight:40];
    pullDwonVIewbg.image = newImg ;
    pullDwonVIewbg.userInteractionEnabled = YES ;
    pullDwonVIewbg.clipsToBounds = NO ;
    [pullDwonVIewbg setCenter:CGPointMake( subFrame.size.width / 2, subFrame.size.height / 2 )];
    [fatherView addSubview:pullDwonVIewbg];

    
    //tableView用于显示数据
    pulltableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 22, pullDwonVIewbg.width-20 , pullDwonVIewbg.height - 33 ) style:UITableViewStylePlain];
    pulltableView.dataSource = self ;
    pulltableView.delegate = self ;
    pulltableView.rowHeight = 30 ;
    pulltableView.showsHorizontalScrollIndicator = NO;
    pulltableView.showsVerticalScrollIndicator = NO ;
    [pullDwonVIewbg addSubview:pulltableView];

}
#pragma mark---UITableViewDataSource
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _titleArr.count ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        UILabel  *customLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, pulltableView.width, 40)];
        customLabel.tag = 100 ;
        customLabel.textAlignment = NSTextAlignmentCenter ;
        [cell.contentView addSubview:customLabel];
    }
    UILabel *label = (UILabel*)[cell.contentView viewWithTag:100];
    label.text = _titleArr[indexPath.row];
    return cell ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [titleButton setTitle:_titleArr[indexPath.row] forState:UIControlStateNormal];
    fatherView.hidden = YES;
    self.height = 44;
    flag = !flag ;
    
}
#pragma mark---customAction
- (void)pullDwonAction
{
    
    if (flag) {
        fatherView.hidden = NO ;
        self.height = 300;
    }else{
        fatherView.hidden = YES;
        self.height = 44;
    }
    flag = !flag ;
     //旋转90°
        [UIView animateWithDuration:0.5 animations:^{
         CGAffineTransform   oldTrans = pullDwonButton.transform ;
        CGAffineTransform   newTrans = CGAffineTransformRotate(oldTrans, 180 * M_PI / 180);
        pullDwonButton.transform = newTrans ;
    }];

}
- (void)returnAction
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"return" object:nil];
}
@end
