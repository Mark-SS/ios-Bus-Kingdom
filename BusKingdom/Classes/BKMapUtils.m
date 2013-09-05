//
//  BKMapUtils.m
//  BusKingdom
//
//  Created by yy on 13-7-25.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import "BKMapUtils.h"

@implementation BKMapUtils

+ (CLLocation *)findNearestLocationForPoint:(CLLocation *)point withPoints:(NSArray *)points {
    NSArray *sorted = [points sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        CLLocationDistance d1 = [point distanceFromLocation:obj1];
        CLLocationDistance d2 = [point distanceFromLocation:obj2];
        if (d1 < d2) {
            return NSOrderedAscending;
        } else if (d1 > d2) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    return sorted[0];
    
    
}

@end
