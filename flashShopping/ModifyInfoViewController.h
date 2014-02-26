//
//  ModifyInfoViewController.h
//  flashShopping
//
//  Created by Width on 14-2-25.
//  Copyright (c) 2014年 chinawidth. All rights reserved.
//

#import "BaseViewController.h"

@interface ModifyInfoViewController : BaseViewController<UITextViewDelegate , UITextFieldDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UIView *bodyView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *goodTitleBg;
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *goodTitleTextView;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *goodCodeTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *goodPriceTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *goodNumTextField;
@property ( nonatomic , copy )NSString *Id ;
- (IBAction)selectButton:(id)sender;
@end
