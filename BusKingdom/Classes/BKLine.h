//
//  BKLine.h
//  BusKingdom
//
//  Created by yy on 13-7-16.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BKLineCompletionBlock)(id response, NSError *error);

@interface BKLine : NSObject

- (void)queryBusesForLine:(NSString *)lineId completion:(BKLineCompletionBlock)completion;

- (void)queryLine:(NSString *)lineId completion:(BKLineCompletionBlock)completion;

@end
