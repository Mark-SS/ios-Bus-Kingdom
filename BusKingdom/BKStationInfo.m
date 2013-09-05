//
//  BKStationInfo.m
//  BusKingdom
//
//  Created by gongliang on 13-9-4.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import "BKStationInfo.h"

@implementation BKStationInfo

- (id)initWithId:(NSInteger)sid andName:(NSString *)sName andCoor:(CLLocationCoordinate2D)coord
{
    if (self = [super init]) {
        _sid = sid;
        _sName = [sName copy];
        _coord = coord;
    }
    return self;
}

@end
