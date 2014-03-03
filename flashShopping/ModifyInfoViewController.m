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
    
    self.bodyView.height = SCREENMAIN_HEIGHT ;
    self.bodyView.width = SCREENMAIN_WIDTH ;
   // _bodyView.contentSize = CGSizeMake(SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT );
    if (IOS_VERSION < 7.0) {
        self.bodyView.top = 0 ;
        self.bodyView.height = SCREENMAIN_HEIGHT - 64 ;
    }
    
     //图片的拉伸
    _goodTitleBg.image = [UIImage imageNamed:@"textfiled-b"];
    UIImage *newImg = [_goodTitleBg .image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    _goodTitleBg.image = newImg ;
    
    //监听键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(modifyFrame:) name:UIKeyboardWillShowNotification object:Nil];
   
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
    
}
#pragma mark---MemoryManager
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---customModth
- (void)actions:(id)sender
{
    NSDictionary *dict = @{@"actionCode":@"442" , @"appType":@"json" , @"companyId":@"00000101" , @"Id":_Id , @"goodsId":_goodsId , @"isUp":@"1"};
    NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    [SGDataService requestWithUrl:BASEURL dictParams:mutableDict httpMethod:@"post" completeBlock:^(id result){
        NSLog(@"%@",result[@"content"]);
    }];
    
}
- (void)setFrame:(CGFloat)textFieldBottom andKeyboardHeight:(CGFloat)keyboardHeight andTextFieldTag:(NSInteger)textFieldTag
{
    if ( textFieldTag == 6 || textFieldTag ==7 ) {
        [UIView animateWithDuration:0.5 animations:^{
            _bodyView.top =_bodyTop - (textFieldBottom - (_bodyView.height - keyboardHeight - 64));
        }];
    }
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
