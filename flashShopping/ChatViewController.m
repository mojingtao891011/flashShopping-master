//
//  ChatViewController.m
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "ChatViewController.h"


#define IPADDRESS @"192.168.1.201"
#define PORT 4000


@interface ChatViewController ()
@end

@implementation ChatViewController

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
    self.titleLabel.text = @"闪聊";
    
//    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://sztest.iflashbuy.com:8201"]]];
//    //ws://sztest.iflashbuy.com:8201
//    _webSocket.delegate = self;
//    [_webSocket open];
//    
//    self.view.backgroundColor = [UIColor whiteColor];
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 320,SCREENMAIN_HEIGHT - 44) style:UITableViewStylePlain];
//    
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    
//    [self.view addSubview: _tableView];
//    
//    
//    
//    //	创建一个 toolbar
//    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SCREENMAIN_HEIGHT - 44, 320, 44)];
//    
//    [self.view addSubview:_toolBar];
//    
//    
//    //    创建一个textfield
//    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 2, 200, 40)];
//    
//    _textField.borderStyle = UITextBorderStyleRoundedRect;
//    _textField.delegate = self;
//    [_textField addTarget:self action:@selector(keyBoardDown:) forControlEvents:UIControlEventEditingDidEndOnExit];
//    
//    //    用textField来初始化一个BarButtonIteam
//    UIBarButtonItem *textBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_textField];
//    
//    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    
//    sendButton.frame = CGRectMake(10, 2, 60, 40);
//    [sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
//    
//    
//    UIBarButtonItem *btnBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
//    
//    NSArray *array = [NSArray arrayWithObjects:textBarButtonItem,btnBarButtonItem, nil];
//    
//    
//    //    把数组赋值给toolbar的items属性
//    _toolBar.items = array;
//    _array = [[NSMutableArray alloc] initWithCapacity:0];
//    _isSendByMe = YES;
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    
}
//- (void)keyBoardWillShow:(NSNotification *)notification{
//    //竖屏:216 横屏:140
//    static CGFloat normalKeyboardHeight = 216.0f;
//    
//    NSDictionary *info = [notification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//    _keyboardDistanceToMove = kbSize.height - normalKeyboardHeight;
//    
//    NSLog(@"键盘高度差：%f",_keyboardDistanceToMove);
//    [self changeKeyboardHeight:_keyboardDistanceToMove];
//    
//}
//
//- (void)keyBoardDown:(id)sender{
//    [self.view endEditing:YES];
//    [self endEdit];
//    
//    
//}

#pragma mark -
#pragma mark SRWebSocketDelegate Method
//- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
//    
//    NSLog(@"连接已建立！");
//    
//}
////接收服务端发来的数据
//- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
//    
//    UIView *vie = [self creatBubbleView:message withFromWhere:NO];
//    [_array addObject:vie];
//    [_tableView reloadData];
//    
//}
////发生错误
//- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
//    
//    NSLog(@"%@",error);
//}
//
////关闭连接
//- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
//    
//    
//    
//}
//
//
//- (void)sendButtonClick:(id ) sender{
//    
//    NSString *sendTxt = _textField.text;
//    UIView *view = [self creatBubbleView:sendTxt withFromWhere:YES];
//    [_webSocket send:sendTxt];
//    [_array addObject:view];
//    
//    
//    _isSendByMe = !_isSendByMe;
//    //    刷新表
//    [_tableView reloadData];
//    
//    _textField.text = @"";
//    
//    //   每次发完后让表显示到最后一行
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_array.count - 1 inSection:0];
//    
//    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    
//}
//
//
//
//- (UIView *)creatBubbleView:(NSString *)str withFromWhere:(BOOL)isMe{
//    
//    str = [NSString stringWithFormat:@"%@: %@",isMe?@"Client":@"Server",str];
//    UIFont *font = [UIFont systemFontOfSize:14];
//    //    此处 180 是与要显示字符的label的宽度一致。 这样可以同步换行，计算出同等的高度
//    CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(160, 1000) lineBreakMode:NSLineBreakByCharWrapping];
//    
//    
//    UIView *vie = [[UIView alloc] init];
//    NSString *imageName = isMe?@"bubbleSelf.png":@"bubble.png";
//    
//    UIImage *image = [UIImage imageNamed:imageName];
//    //   拉伸图片方法 第一个参数：
//    //    设置图片的边帽，可以根据墨一个像素点区拉伸图片
//    image = [image stretchableImageWithLeftCapWidth:20 topCapHeight:15];
//    
//    UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:image];
//    
//    bubbleImageView.frame = CGRectMake(0, 0, 200, 20+ size.height);
//    [vie addSubview:bubbleImageView];
//    
//    //    [bubbleImageView release]
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 160, size.height)];
//    label.backgroundColor = [UIColor clearColor];
//    
//    label.numberOfLines = 0;
//    label.font = font;
//    label.lineBreakMode = NSLineBreakByCharWrapping;
//    label.text = str;
//    [vie addSubview:label];
//    
//    
//    if (isMe) {
//        vie.frame = CGRectMake(120, 0, 200, size.height + 40);
//        
//    }else{
//        vie.frame = CGRectMake(0, 0, 200, size.height + 40);
//    }
//    
//    return vie;
//    
//}
//
//#pragma mark -
//#pragma mark UITextFieldDelegate
////输入框获得第一响应
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    
//    
//    [self changeKeyboardHeight:0.0f];
//    
//    
//}
////"改变控件尺寸以适应键盘高度"
//- (void)changeKeyboardHeight:(CGFloat)currentKeyboardHeigetDistance{
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:.25];
//    _tableView.frame =CGRectMake(0, 20, 320, SCREENMAIN_HEIGHT - 44 - 216 - currentKeyboardHeigetDistance);
//    _toolBar.frame = CGRectMake(0, SCREENMAIN_HEIGHT - 44 -216 - currentKeyboardHeigetDistance, 320, 44);
//    [UIView commitAnimations];
//    
//    
//}
//
//#pragma mark -
//#pragma mark UITableViewDelegate
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UIView *vie = [_array objectAtIndex:indexPath.row];
//    return vie.frame.size.height;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _array.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    static NSString *cellIdentifier = @"CellIdentifier";
//    
//    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
//    
//    if(cell == nil){
//        
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    for (UIView *view in [cell.contentView subviews]) {
//        [view removeFromSuperview];
//    }
//    
//    
//    UIView *vie = [_array objectAtIndex:indexPath.row];
//    
//    [cell.contentView addSubview:vie];
//    return cell;
//    
//    
//}
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [_textField resignFirstResponder];
//    
//    [self endEdit];
//}
//
//- (void)endEdit{
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:.25];
//    
//    _toolBar.frame = CGRectMake(0, SCREENMAIN_HEIGHT - 44, 320, 44);
//    _tableView.frame = CGRectMake(0, 20, 320, SCREENMAIN_HEIGHT - 44);
//    
//    [UIView commitAnimations];
//    
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
@end
