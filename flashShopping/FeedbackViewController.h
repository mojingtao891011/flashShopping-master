//
//  FeedbackViewController.h
//  flashShopping
//
//  Created by sg on 14-3-3.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseViewController.h"

@interface FeedbackViewController :BaseViewController<UITextViewDelegate>
{
    UITextView *_opinion;
    UITextField *_contact;
}
@property (nonatomic,retain) UITextView *opinion;
@end
