//
//  BKMapViewController.h
//  BusKingdom
//
//  Created by yy on 13-7-18.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface BKMapViewController : UIViewController <MKMapViewDelegate>
{
    NSTimer *timer; //自动刷新汽车位置
}

@property (nonatomic, strong) NSArray *buses;  //公交车数组
@property (nonatomic, strong) NSArray *busStations; //公交车站牌数组
@property (nonatomic, assign) int row; //指定现在用户选取的站点


@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UIButton *onOffRefresh;

- (IBAction)doneTapped:(id)sender;
- (IBAction)refreshBus:(id)sender;

@end
