//
//  BasicInfoViewController.m
//  flashShopping
//
//  Created by Width on 14-1-13.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BasicInfoViewController.h"

@interface BasicInfoViewController ()<UITextFieldDelegate>

@end

@implementation BasicInfoViewController

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
    self.title = @"基本信息";
    self.isBack = YES ;
    self.isAddRefreshButton = YES ;
    if (IOS_VERSION < 7.0) {
        [_bobyView setFrame:CGRectMake(0, 10, SCREENMAIN_WIDTH, SCREENMAIN_HEIGHT-20-44-10)];
    }
    
        for (UIView *subView in self.bobyView.subviews) {
        if ([subView isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)subView;
            
                textField.delegate = self ;
    
        }
    }

    
}
- (void)keyWillshow:(NSNotification*)note{
    
    
    [_bobyView setFrame:CGRectMake(0, _bobyView.frame.origin.y - 150, _bobyView.bounds.size.width, _bobyView.bounds.size.height)];
    
}
- (void)keyWillHide:(NSNotification*)note{
    
   [_bobyView setFrame:CGRectMake(0, 10, _bobyView.bounds.size.width, _bobyView.bounds.size.height)];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"=======");
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyWillshow:) name:UIKeyboardWillShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyWillHide:) name:UIKeyboardWillHideNotification object:nil];
    

    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
