//
//  BKStationViewController.h
//  BusKingdom
//
//  Created by gongliang on 13-9-4.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKStationViewController : UIViewController

@property (nonatomic, strong) NSArray *staArray; //车站显示数组

@property (nonatomic, strong) NSArray *busArray; //改线路上有几辆车

@property (weak, nonatomic) IBOutlet UIScrollView *staScrollView;


@end
