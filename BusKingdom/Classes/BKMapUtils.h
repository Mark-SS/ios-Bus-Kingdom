//
//  BKMapUtils.h
//  BusKingdom
//
//  Created by yy on 13-7-25.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BKMapUtils : NSObject

+ (CLLocation *)findNearestLocationForPoint:(CLLocation *)point withPoints:(NSArray *)points;

@end
