//
//  ChatViewController.h
//  flashShopping
//
//  Created by Width on 14-1-2.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseViewController.h"
//#import "SRWebSocket.h"


@interface ChatViewController : BaseViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

{
    UIToolbar   *_toolBar;
    UITextField *_textField;
    UITableView *_tableView;
    BOOL         _isSendByMe;
    CGFloat _keyboardDistanceToMove;
    NSMutableArray *_array;
    
//    SRWebSocket *_webSocket;
}

@end
