//
//  BKMapAnnotation.h
//  BusKingdom
//
//  Created by gongliang on 13-8-27.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
typedef enum {
    Bus = 0,  //公交车
    BusStation = 1, //公交车站牌
    MyStation =2, //自己所在站牌
}AnnotationType;

@interface BKMapAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate; //针的位置信息
@property (nonatomic, copy) NSString *title; //针的标题
@property (nonatomic, copy) NSString *subtitle; //针的副标题
@property (nonatomic, assign) AnnotationType type;

- (id)initWithCoord:(CLLocationCoordinate2D)coor;

@end
 