//
//  FeedbackViewController.m
//  flashShopping
//
//  Created by sg on 14-3-3.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController
@synthesize opinion = _opinion;
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
    self.view.backgroundColor = [UIColor whiteColor];

	// Do any additional setup after loading the view.
    //    self.title = @"意见反馈";
    
    [self createCommitBtn];
    [self loadMainView];
    
    
}
- (void)createCommitBtn{
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    commitBtn.frame = CGRectMake(270, 5, 50, 35);
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [rightBtnView addSubview:commitBtn];
    
    
    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtnView];
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
}

- (void)commitBtn:(UIButton *)sender{
    
    
    
}

- (void)loadMainView{
    
    _opinion = [[UITextView alloc] init];
    
    _opinion.frame = CGRectMake(10.0f, 74.0f, SCREENMAIN_WIDTH - 20.0f, self.view.bounds.size.height - 349.0f );
    //    _opinion.delegate = self;
    
    //    _opinion.backgroundColor = [UIColor redColor];
    //    _opinion.textAlignment = NSTextAlignmentLeft;
    _opinion.layer.cornerRadius = 6;
    _opinion.layer.masksToBounds = YES;
    _opinion.layer.borderWidth = 1;
    _opinion.layer.borderColor = [[UIColor grayColor] CGColor];
    _opinion.font = [UIFont systemFontOfSize:18];
    [_opinion becomeFirstResponder];
    //    _opinion.placeholder = @"闪购客服电话：400-638-1819，欢迎来电！也可以在此留言！";
    //
    //    _opinion.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_opinion];
    
    
    _contact = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 220.0f, SCREENMAIN_WIDTH - 20.0f, 44.0f)];
    _contact.placeholder = @"亲们可以在此留下联系方式";
    //    _contact.borderStyle = UITextBorderStyleRoundedRect;
    _contact.layer.borderColor = [[UIColor grayColor] CGColor];
    _contact.layer.cornerRadius = 6;
    _contact.layer.masksToBounds = YES;
    _contact.layer.borderWidth = 1;
    
    
    _contact.font = [UIFont systemFontOfSize:14];
    
    [self.view addSubview:_contact];

}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSRange range;
    range.location = 0;
    range.length  = 0;
    textView.selectedRange = range;
    
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
