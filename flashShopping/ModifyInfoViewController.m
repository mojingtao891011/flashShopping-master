//
//  ModifyInfoViewController.m
//  flashShopping
//
//  Created by Width on 14-2-25.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "ModifyInfoViewController.h"
#import "RequestNetwork.h"

@interface ModifyInfoViewController ()

@end

@implementation ModifyInfoViewController

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
    self.titleLabel.text = @"基本信息";
    //创建导航栏上的保存按钮
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.width = 50 ;
    saveButton.height = 30 ;
    [saveButton setBackgroundImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveModifyInfo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveButton];
    
    self.bodyView.height = SCREENMAIN_HEIGHT ;
    if (IOS_VERSION < 7.0) {
        self.bodyView.top = 0 ;
    }
    
     //图片的拉伸
    _goodTitleBg.image = [UIImage imageNamed:@"textfiled-b"];
    UIImage *newImg = [_goodTitleBg .image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    _goodTitleBg.image = newImg ;
    
    //监听键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(modifyFrame:) name:UIKeyboardWillShowNotification object:Nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(defaultFrame:) name:UIKeyboardWillHideNotification object:Nil];
    //获取数据通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getData:) name:@"getDatas" object:nil];
}
#pragma mark---UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES ;
}
#pragma mark----NSNotificationCenter
- (void)modifyFrame:(NSNotification*)note
{
    [UIView animateWithDuration:0.5 animations:^{
        _bodyView.top = _bodyView.top - 75;
    }];
    
}
- (void)defaultFrame:(NSNotification*)note
{
    [UIView animateWithDuration:0.5 animations:^{
        _bodyView.top = _bodyView.top + 75;
    }];

}
- (void)getData:(NSNotification*)note
{
    
    NSData *getData = [note object];
    id json = [NSJSONSerialization JSONObjectWithData:getData options:NSJSONReadingMutableContainers error:nil];
    static NSString *msg ;
    if (json[@"content"] != NULL) {
        msg = json[@"content"] ;
    }
    else{
        msg = @"数据提交失败";
    }
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil , nil];
    [alertView show];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:ModifyDataFinishNote object:nil];
}
#pragma mark---MemoryManager
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---customModth
- (void)saveModifyInfo
{
    NSString *postString = [NSString stringWithFormat:@"{\"actionCode\":\"442\",\"appType\":\"json\" , \"companyId\":\"00000101\" , \"Id\":%@,\"goodsId\":%@ ,\"isUp\":%@ , \"name\":\"%@\" , \"goodsCode\":\"%@\", \"price\":\"%@\", \"num\":\"%@\" }", _Id , _goodsId , @"1" , _goodTitleTextView.text , _goodCodeTextField.text , _goodPriceTextField.text , _goodNumTextField.text ];

    [[RequestNetwork shareManager]requestNetwork:postString noteName:@"getDatas"];
}

- (IBAction)selectButton:(id)sender {
    UIButton *selectButton = (UIButton*)sender ;
    if (selectButton.tag == 2) {
        _isUp = @"1" ;
    }else if( selectButton.tag == 3){
        _isUp = @"0" ;
    }
    for (id button in _bodyView.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            [button setBackgroundImage:[UIImage imageNamed:@"Radio-a"] forState:UIControlStateNormal];
        }
    }
        [selectButton setBackgroundImage:[UIImage imageNamed:@"Radio-b"] forState:UIControlStateNormal];
}
@end
