//
//  BKUntility.m
//  BusKingdom
//
//  Created by gongliang on 13-8-27.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import "BKUntility.h"
#import <CoreLocation/CoreLocation.h>

#define kSpeed 5  //以m/s为单位

@implementation BKUntility

//获取两点之间经纬度对应的距离
+ (double)getDistanceWithStartLongitude:(double)startLon
                               latitude:(double)startLat
                        andEndLongitude:(double)endLon
                               latitude:(double)endLat
{
    
    CLLocation *startLocation = [[CLLocation alloc]initWithLatitude:startLat
                                                          longitude:startLon];
    CLLocation *endLocation = [[CLLocation alloc]initWithLatitude:endLat
                                                        longitude:endLon];

    CLLocationDistance distance = [startLocation distanceFromLocation:endLocation];
    
    NSInteger WXScene;
    
    WXScene = WXSceneSession;
    
    //distance算不来是米为单位，转化为以公里为单位
    return distance/1000;
}

//返回一个NSString 表示两点之前的相隔多少km，大约需要多长时间
+ (NSString *)getTimeAndDistanceWithStartLongitude:(double)startLon
                                          Latitude:(double)startLat
                                   andEndLongitude:(double)endLon
                                          latitude:(double)endLat
{
    double distance = [self getDistanceWithStartLongitude:startLon
                                                 latitude:startLat
                                          andEndLongitude:endLon
                                                 latitude:endLat];
    //需要的时间，单位为s
    int time = 1000*distance/kSpeed;
    //多少个小时
    int hour = time/3600;
    int min = time%3600/60;
    NSString *hourString = @"";
    if (hour)
    {
        hourString = [NSString stringWithFormat:@"%d小时",hour];
    }
    
    NSString *minString = @"";
    if (min)
    {
        minString = [NSString stringWithFormat:@"%d分钟",min];
    }
    
    return [NSString stringWithFormat:@"%0.2fkm,%@%@",distance,hourString,minString];

}

//判断空字符串
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil)
        return YES;
    else if (string == NULL)
        return YES;
    else if ([string isKindOfClass:[NSNull class]])
        return YES;
    else if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0)
        return YES;
    else
        return NO;
}

@end
