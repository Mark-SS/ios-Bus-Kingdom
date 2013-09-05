//
//  BKMapAnnotation.m
//  BusKingdom
//
//  Created by gongliang on 13-8-27.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import "BKMapAnnotation.h"

@implementation BKMapAnnotation

- (id)initWithCoord:(CLLocationCoordinate2D)coor
{
    if (self = [super init]) {
        self.coordinate = coor;
    }
    return self;
}

- (void)setCoordinate:(CLLocationCoordinate2D)coordinate
{
    _coordinate = coordinate;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
}

- (void)setSubtitle:(NSString *)subtitle
{
    _subtitle = subtitle;
}

- (CLLocationCoordinate2D)_coordinate
{
    return _coordinate;
}

@end
