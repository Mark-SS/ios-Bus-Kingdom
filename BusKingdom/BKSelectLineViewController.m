//
//  BKSelectLineViewController.m
//  BusKingdom
//
//  Created by gongliang on 13-8-29.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import "BKSelectLineViewController.h"
#import "BKLine.h"
#import "BKUntility.h"
@interface BKSelectLineViewController ()
{
    NSArray *_upArray; //上行
    NSArray *_downArray; //下行
}

@end

@implementation BKSelectLineViewController

- (void)dealloc{
    NSLog(@"select Line dealloc");
}

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITextField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    if ([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
    }
    return YES;
}


#pragma mark -
#pragma mark IBOutlet
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//查询用户所选择的路线
- (IBAction)selectLine:(id)sender {
    
    //如果用户没有输入，提示用户
    if ([BKUntility isBlankString:self.lineTextField.text]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"请输入查询线路"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    //获取路线对应的站点信息，现在时模拟数据，之后换成从服务器请求得到
    BKLine *line = [[BKLine alloc]init];
    [line queryLine:self.lineTextField.text completion:^(id response, NSError *error)
    {
        NSDictionary *result = response[@"result"];
        self.lineInfo.text = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",result[@"name"],result[@"ticket"],result[@"note"],result[@"time_span"]];
        self.lineInfo.hidden = NO;
        
        //上行数组
       _upArray = result[@"stations"][@"1"];
       _upArray = [_upArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSInteger num1 = [obj1[@"number"] integerValue];
            NSInteger num2 = [obj2[@"number"] integerValue];
            if (num1 < num2) {
                return NSOrderedAscending;
            } else if (num1 > num2) {
                return NSOrderedDescending;
            }
            return NSOrderedSame;
        }];

        //下行数组
        _downArray = result[@"stations"][@"2"];
        _downArray = [_downArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSInteger num1 = [obj1[@"number"] integerValue];
            NSInteger num2 = [obj2[@"number"] integerValue];
            if (num1 < num2) {
                return NSOrderedAscending;
            } else if (num1 > num2) {
                return NSOrderedDescending;
            }
            return NSOrderedSame;
        }];
        
        [self.upBtn setTitle:[NSString stringWithFormat:@"向%@",_upArray[0][@"name"]] forState:UIControlStateNormal];
        self.upBtn.hidden = NO;
        [self.downBtn setTitle:[NSString stringWithFormat:@"向%@",_downArray[0][@"name"]] forState:UIControlStateNormal];
        self.downBtn.hidden = NO;
        
        [self.lineTextField resignFirstResponder];
        
    

    }];
    
    
}

- (IBAction)selectDirection:(id)sender {

    UIButton *btn = (UIButton *)sender;
    NSDictionary *dic;
    if (btn.tag == 1000)
    {
         dic = @{@"station":_downArray,
                 @"title":self.lineTextField.text,
                }; 
       
    }else if (btn.tag == 1001)
    {
        dic = @{@"station":_upArray,
                @"title":self.lineTextField.text,
                };
    }
    if (self.returnBlock)
    {
        self.returnBlock(dic);
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
