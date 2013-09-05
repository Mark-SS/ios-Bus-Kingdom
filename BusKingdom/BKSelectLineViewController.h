//
//  BKSelectLineViewController.h
//  BusKingdom
//
//  Created by gongliang on 13-8-29.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnBlock)(id object);  //默认返回一个object

@interface BKSelectLineViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *lineTextField; //路线的TextField

@property (weak, nonatomic) IBOutlet UIButton *upBtn;  //上行 默认tag 1000

@property (weak, nonatomic) IBOutlet UIButton *downBtn; //下行 默认tag 1001

@property (strong, nonatomic) ReturnBlock returnBlock;

@property (weak, nonatomic) IBOutlet UITextView *lineInfo;//显示

@end
