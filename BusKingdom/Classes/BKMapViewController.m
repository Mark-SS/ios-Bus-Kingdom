//
//  BKMapViewController.m
//  BusKingdom
//
//  Created by yy on 13-7-18.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import "BKMapViewController.h"
#import "BKUntility.h"
#import "BKMapAnnotation.h"
#import "BKLine.h"

#define kAutoTime 10.0f //自动刷新时间间隔

@interface BKMapViewController ()
{
    CLLocationCoordinate2D _userCoordinate2D;
    NSMutableArray *annotations;
}

@property (nonatomic) BOOL showedLocation;

@end

@implementation BKMapViewController

- (void)dealloc
{
    NSLog(@"地图 dealloc");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _map.showsUserLocation = YES;
    [self showBuses];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - mapView delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    _userCoordinate2D = userLocation.coordinate;
        
    if (_showedLocation || !CLLocationCoordinate2DIsValid(userLocation.coordinate)) {
        return;
    }
    
    [_map setCenterCoordinate:userLocation.coordinate animated:YES];
    [_map setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.3, 0.3))];
    _showedLocation = YES;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(MKPointAnnotation *)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *key = @"busAnn";
    MKAnnotationView* annView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:key];
    if (annView == nil) {
        annView = [[MKPinAnnotationView alloc]
                   initWithAnnotation:annotation
                   reuseIdentifier:key];
        
    }
    
    annView.canShowCallout = YES;
        
    return annView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    // Initialize each view
    for (MKPinAnnotationView *mkaview in views)
    {
        // 当前位置 的大头，并且没有右边的附属按钮
        if ([mkaview.annotation isKindOfClass:[MKUserLocation class]])
        {
            continue;
        }
        else
        {
            BKMapAnnotation *annotation = (BKMapAnnotation *)mkaview.annotation;
            switch (annotation.type)
            {
                case Bus:
                    mkaview.pinColor = MKPinAnnotationColorRed;
                    break;
                case BusStation:
                    mkaview.pinColor = MKPinAnnotationColorGreen;
                    break;
                case MyStation:
                    mkaview.pinColor = MKPinAnnotationColorPurple;
                    [mapView selectAnnotation:annotation animated:NO];
                    break;
                default:
                    break;
            }
        }
  
    }
    
    
    
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    

}

#pragma mark - custom methods

- (void)showBuses
{
    if (![_buses count])
    {
        return;
    }
    
    if (annotations)
    {
        [_map removeAnnotations:annotations];
        annotations = nil;
    }
        
    annotations = [NSMutableArray array];
    
    
    __block CLLocationCoordinate2D tempCoordinate;
    
    [_buses enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        
        if (idx == 0)
        {
            BKMapAnnotation *ann = [[BKMapAnnotation alloc]init];
            ann.type = Bus;
            ann.coordinate =  CLLocationCoordinate2DMake([obj[@"lat"] doubleValue], [obj[@"lng"] doubleValue]);
            tempCoordinate = ann.coordinate;
            ann.title = obj[@"id"];
            [annotations addObject:ann];
        }
    }];

    [self.busStations enumerateObjectsUsingBlock:^(id v,NSUInteger idx,BOOL *stop)
     {
         BKMapAnnotation *ann = [[BKMapAnnotation alloc] init];
         
         //如果是我选中的站点，设置为自己的
         if (idx == self.row - 1)
             ann.type = MyStation;
         else 
             ann.type = BusStation;
             
         
         ann.coordinate = CLLocationCoordinate2DMake([v[@"lat"] doubleValue], [v[@"lng"] doubleValue]);
         NSString *distanceTime = [BKUntility getTimeAndDistanceWithStartLongitude:tempCoordinate.longitude
                                                                          Latitude:tempCoordinate.latitude
                                                                   andEndLongitude:[v[@"lng"] doubleValue]
                                                                          latitude:[v[@"lat"] doubleValue]];
         ann.title = [NSString stringWithFormat:@"%@,%@",v[@"name"],distanceTime];
         
         [annotations addObject:ann];
     
     }];

    [_map addAnnotations:annotations];
    
}

#pragma mark - IBAction
- (IBAction)doneTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)refreshBus:(id)sender {
    
    BKLine *line = [[BKLine alloc]init];
    [line queryBusesForLine:@"2" completion:^(id response, NSError *error) {
        NIDPRINT(@"x %@", response);
        if (response[@"result"]) {
            _buses = response[@"result"];
        }
        
        [self showBuses];
    }];
    
    
}

//是否开启自动更新开关
- (IBAction)automaticRefresh:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if ([btn.titleLabel.text isEqualToString:@"开"])
    {
        [btn setTitle:@"关" forState:UIControlStateNormal];
        timer = [NSTimer scheduledTimerWithTimeInterval:kAutoTime
                                                 target:self
                                               selector:@selector(refreshBus:)
                                               userInfo:nil
                                                repeats:YES];
        
    }
    else
    {
        [btn setTitle:@"开" forState:UIControlStateNormal];
        [timer invalidate];
        timer = nil;
        
    }
}



@end
