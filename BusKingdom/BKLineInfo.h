//
//  BKLineInfo.h
//  BusKingdom
//
//  Created by gongliang on 13-9-3.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BKStationInfo.h"

typedef void (^BKLineCompletionBlock)(id response, NSError *error);

@interface BKLineInfo : NSObject

@property (nonatomic, assign) NSInteger lid; //这条路线id
@property (nonatomic, copy) NSString *lName; //这条路线名字
@property (nonatomic, copy) NSString *run; //上行，下行
@property (nonatomic, assign) NSInteger staCount; //总共站数
@property (nonatomic, copy) NSString *firstTime; //首班车时间
@property (nonatomic, strong) NSArray *staArray; //站点信息

/*
 通过ID 查询公交此时的状态
 lName ： 这条线路的名字
*/

- (void)queryStation:(NSString *)lName
           comletion:(BKLineCompletionBlock)completion;

/*
 根据站点和路线id得到此时车辆状态
 lid : 这条线路的id
 sid : 这一个站点的id
*/
- (void)queryBusStatus:(NSInteger)lid
            andStation:(NSInteger)sid
             comletion:(BKLineCompletionBlock)completion;

@end
