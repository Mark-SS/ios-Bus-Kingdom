//
//  BKBusStationInfo.m
//  BusKingdom
//
//  Created by gongliang on 13-9-3.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import "BKBusStationInfo.h"

@implementation BKBusStationInfo


//从缓存中读取最近一次的公交查询情况
- (id)getBusStationInfo
{
    
}

//存最近一次的查询的信息
- (BOOL)saveLastStationInfo:(id)object
{
    
}

//获取路径
- (NSString *)file
{
    NSArray *cachePathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = cachePathArray[0];
    NSString *stationInfo = [cachePath stringByAppendingPathComponent:@"stationInfo"];
    return nil;
}

@end
