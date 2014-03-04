//
//  ModifyInfoViewController.m
//  flashShopping
//
//  Created by Width on 14-2-25.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "ModifyInfoViewController.h"
#import "SGDataService.h"

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
    _bodyTop = _bodyView.top ;
    
    //创建导航栏上的保存按钮
    CustomUIBarButtonItem *saveButton = [[CustomUIBarButtonItem alloc]initWithFrame:CGRectMake(0, 0, 50, 30) andSetdelegate:self andImageName:@"save"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveButton];
    //适配
    self.bodyView.height = SCREENMAIN_HEIGHT ;
    self.bodyView.width = SCREENMAIN_WIDTH ;
    if (IOS_VERSION < 7.0) {
        self.bodyView.top = 44 ;
    }
    
    //监听键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(modifyFrame:) name:UIKeyboardWillShowNotification object:Nil];
    
    //post (  NSDictionary )
    NSDictionary *dict = @{@"actionCode":@"442" , @"appType":@"json" , @"companyId":@"00000101" };
    _mutableDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
   
}
#pragma mark---UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ( textField.tag == 6 || textField.tag ==7 ) {
        [UIView animateWithDuration:0.5 animations:^{
            _bodyView.top = _bodyTop ;
        }];
    }
    return YES ;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _textFieldTag = textField.tag ;
    _textFieldBottom = textField.bottom ;
    [self setFrame:_textFieldBottom andKeyboardHeight:_KeyboardHeight andTextFieldTag:_textFieldTag];
    return YES ;
}
#pragma mark--- UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _textFieldTag = 0 ;
    return YES ;
}
#pragma mark----NSNotificationCenter
- (void)modifyFrame:(NSNotification*)note
{
    CGRect rect = [[[note userInfo]objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
     _KeyboardHeight = rect.size.height ;
   [self setFrame:_textFieldBottom andKeyboardHeight:_KeyboardHeight andTextFieldTag:_textFieldTag];

}
#pragma mark---MemoryManager
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---customModth
//保存
- (void)actions:(id)sender
{
    //必须post字段
    [_mutableDict setObject:_Id forKey:@"Id"];
    [_mutableDict setObject:_goodsId forKey:@"goodsId"];
    //非必须post字段
    [_mutableDict  setObject:_goodTitleTextView.text forKey:@"name"];
    [_mutableDict setObject:_goodCodeTextField.text forKey:@"goodsCode"];
    [_mutableDict setObject:_goodPriceTextField.text forKey:@"price"];
    [_mutableDict setObject:_goodNumTextField.text forKey:@"num"];
    //NSLog(@"dict = %@",_mutableDict);
    //提交修改
    [SGDataService requestWithUrl:BASEURL dictParams:_mutableDict httpMethod:@"post" completeBlock:^(id result){
        //NSLog(@"%@",result[@"content"]);
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:result[@"content"] delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil , nil];
            [alertView show];
    }];
    
}
//键盘自适应
- (void)setFrame:(CGFloat)textFieldBottom andKeyboardHeight:(CGFloat)keyboardHeight andTextFieldTag:(NSInteger)textFieldTag
{
    if ( textFieldTag == 6 || textFieldTag ==7 ) {
        [UIView animateWithDuration:0.5 animations:^{
            _bodyView.top =_bodyTop - (textFieldBottom - (_bodyView.height - keyboardHeight - 64));
        }];
    }
}
//商品状态
- (IBAction)selectButton:(id)sender {
     UIButton *selectButton = (UIButton*)sender ;
    if (selectButton.tag == 2) {
        _isUp = YES;
    }else if( selectButton.tag == 3){
        _isUp = NO ;
    }
 
    [_mutableDict  setObject:[NSString stringWithFormat:@"%d",_isUp] forKey:@"isUp"];
    [_StateButton setBackgroundImage:[UIImage imageNamed:@"Radio-a"] forState:UIControlStateNormal];
    _StateButton = (UIButton*)sender ;
    [_StateButton setBackgroundImage:[UIImage imageNamed:@"Radio-b"] forState:UIControlStateNormal];

}
//推荐
- (IBAction)recommend:(id)sender {
    [_recommendButton setBackgroundImage:[UIImage imageNamed:@"Radio-a"] forState:UIControlStateNormal];
    _recommendButton = (UIButton*)sender ;
    [_recommendButton setBackgroundImage:[UIImage imageNamed:@"Radio-b"] forState:UIControlStateNormal];
}
@end
