//
//  BKStationInfo.h
//  BusKingdom
//
//  Created by gongliang on 13-9-4.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>


@interface BKStationInfo : NSObject

@property (nonatomic, assign) NSInteger sid; //该站点的ID
@property (nonatomic, copy) NSString *sName; //该站点的名字
@property (nonatomic, assign) CLLocationCoordinate2D coord; //经纬度

- (id)initWithId:(NSInteger)sid andName:(NSString *)sName andCoor:(CLLocationCoordinate2D)coord;


@end
