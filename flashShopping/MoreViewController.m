//
//  MoreViewController.m
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "MoreViewController.h"
#import "SelectRowViewController.h"


@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *moreTableView;
    NSArray *titleArr;
}

@end

@implementation MoreViewController

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
    self.view.backgroundColor = [UIColor clearColor];
     self.titleLabel.text = @"更多";
    moreTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENMAIN_WIDTH, self.view.bounds.size.height-20) style:UITableViewStyleGrouped];
    moreTableView.dataSource=self;
    moreTableView.delegate=self;
    moreTableView.bounces=NO;
    [self.view addSubview:moreTableView];
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getData:) name:postNoteName object:nil];
    titleArr=[NSArray arrayWithObjects:@"关于我们",@"新手入门",@"版本检测",@"意见反馈",@"打分鼓励一下",@"清除本地缓存", nil];
}
- (void)getData:(NSNotification*)note
{
    NSLog(@">>>>>>%@",[note object]);
}
#pragma mark----UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return titleArr.count;
    }else{
        return 1;
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID=@"cellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    if (indexPath.section==0) {
        cell.textLabel.text=titleArr[indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section==1){
        cell.textLabel.text=@"闪购客服电话：400-638-1819";
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
    }else {
        cell.textLabel.text=@"退出应用";
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    return cell;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        return 20;
    }return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        if (indexPath.row==2) {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"暂无更新" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        SelectRowViewController *selectRowView=[[SelectRowViewController alloc]init];
        selectRowView.navgationTitle=titleArr[indexPath.row];
        [self.navigationController pushViewController:selectRowView animated:YES];
    }
 
}
#pragma mark----Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
