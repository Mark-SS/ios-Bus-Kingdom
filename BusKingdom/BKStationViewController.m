//
//  BKStationViewController.m
//  BusKingdom
//
//  Created by gongliang on 13-9-4.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import "BKStationViewController.h"
#import "BKLineInfo.h"
#import "SVProgressHUD.h"

#define kStaWidth 140
#define kStaHeight 40

@interface BKStationViewController ()

@property (nonatomic, strong) BKLineInfo *lineInfo;
@property (nonatomic, assign) NSInteger chooseSid;//选择的id
@property (nonatomic, assign) NSInteger chooseTag;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BKStationViewController

- (void)dealloc
{
    NSLog(@"station 释放");
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_timer invalidate], _timer = nil;
}

- (void)aaa
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view.
    [SVProgressHUD show];
    
    _lineInfo = [BKLineInfo new];
    [self.lineInfo
     queryStation:self.title
     comletion:^(id object, NSError *error){
         self.lineInfo = (BKLineInfo *)object;
         self.staArray = self.lineInfo.staArray;
         self.title = self.lineInfo.lName;
         
         [self.staArray enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop) {
             UIImageView *imageView;
             imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"estation_station.png"]];
             imageView.frame = CGRectMake(75, 50*(self.staArray.count-1-idx), 19, 50);
             [self.staScrollView addSubview:imageView];
             
             UIButton *staBtn = [UIButton buttonWithType:UIButtonTypeCustom];
             staBtn.tag = 100 + idx;
             staBtn.frame = CGRectMake(100, 20+50*(self.staArray.count - 1 -idx), kStaWidth, kStaHeight);
             [staBtn setTitle:obj[@"name"] forState:UIControlStateNormal];
             
             [staBtn addTarget:self action:@selector(chooseStation:)
              forControlEvents:UIControlEventTouchUpInside];
             [staBtn setTitleColor:[UIColor blackColor]
                          forState:UIControlStateNormal];
             
             staBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
             [staBtn setBackgroundImage:[UIImage imageNamed:@"station_label_normal_bg.png"]
                               forState:UIControlStateNormal];
             
             if (idx == 5) {
                 self.chooseSid = [obj[@"id"] integerValue];
                 [self requestBusStatus];
                 
             }
             [self.staScrollView addSubview:staBtn];
             self.staScrollView.contentSize = CGSizeMake(0, 20+50*(self.staArray.count-1) + kStaHeight + 10);
             
         }];
         UIImageView *arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bus2station_scroll_arrow.png"]];
         arrowView.frame = CGRectMake(83, 48, arrowView.image.size.width, arrowView.image.size.height);
         [self.view addSubview:arrowView];
         [SVProgressHUD dismiss];
     }];
    
    
    
    
    //开辟一个线程用来
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0f
                                     target:self
                                   selector:@selector(requestBusStatus)
                                   userInfo:nil
                                    repeats:YES];
    
    
    
    
}

- (void)chooseStation:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    self.chooseSid = [self.staArray[btn.tag-100][@"id"]integerValue];
    
    if (_chooseTag) {
        UIButton *lastBtn = (UIButton *)[self.staScrollView viewWithTag:self.chooseTag];
        [lastBtn setBackgroundImage:[UIImage imageNamed:@"station_label_normal_bg.png"]
                           forState:UIControlStateNormal];
    }

    [btn setBackgroundImage:[UIImage imageNamed:@"station_label_bus_arrived_bg.png"]
                   forState:UIControlStateNormal];
    _chooseTag = btn.tag;

}

- (void)requestBusStatus
{
    NSLog(@"chooseid2 = %d",self.chooseSid);

    [self.lineInfo queryBusStatus:self.lineInfo.lid
                  andStation:self.chooseSid
                   comletion:^(id obj, NSError *error){
                       self.busArray = obj[@"result"][@"status"];
                       [self.busArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
                           
                           NSInteger index = [obj[@"sno"]integerValue];
                           NSInteger isStop = [obj[@"stop"]integerValue];
                           NSInteger tag = 100 + index;
                           NSLog(@"tag = %d  isStopm = %d",tag,isStop);
                           UIImage *image = [UIImage imageNamed:@"bus_status_0.png"];
                           if (isStop) {
                               image = [UIImage imageNamed:@"bus_status_1.png"];
                           }
                           
                           NSInteger lastTag = 1000 + idx;
                           UIImageView *imageView = (UIImageView *)[self.staScrollView viewWithTag:lastTag];
                           if (imageView) {
                               [imageView removeFromSuperview];
                           }
                           
                           imageView = [[UIImageView alloc]initWithImage:image];
                           imageView.tag = lastTag;
                           imageView.frame = CGRectMake(40, (self.staArray.count  - (tag - 100))*50 + (isStop?20:0) + 2, imageView.image.size.width, imageView.image.size.height);
                           [self.staScrollView addSubview:imageView];
                       }];
        
    }];
}

#pragma mark -
#pragma mark 改变方向
- (IBAction)changeRun:(id)sender {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
