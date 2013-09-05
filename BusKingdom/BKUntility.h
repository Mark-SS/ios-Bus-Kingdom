//
//  BKUntility.h
//  BusKingdom
//
//  Created by gongliang on 13-8-27.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import <Foundation/Foundation.h>

enum WXScene {
    
    WXSceneSession   = 0,
    WXSceneTimeline = 1,
};

typedef NSInteger WXScene;

@interface BKUntility : NSObject


//获取两点之间经纬度对应的距离
+ (double)getDistanceWithStartLongitude:(double)startLon
                               latitude:(double)startLat
                        andEndLongitude:(double)endLon
                               latitude:(double)endLat;


+ (NSString *)getTimeAndDistanceWithStartLongitude:(double)startLon
                                          Latitude:(double)startLat
                                   andEndLongitude:(double)endLon
                                          latitude:(double)endLat;


#pragma mark -
#pragma mark 空字符串
+ (BOOL)isBlankString:(NSString *)string;

@end
