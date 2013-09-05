//
//  BKLine.m
//  BusKingdom
//
//  Created by yy on 13-7-16.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import "BKLine.h"
#import "BKHTTPClient.h"

@implementation BKLine

- (void)queryBusesForLine:(NSString *)lineId completion:(BKLineCompletionBlock)completion {
    if (!completion) {
        return;
    }
    BKHTTPClient *client = [BKHTTPClient sharedClient];
    [client getPath:@"line/bus"
         parameters:@{@"id" : lineId}
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                completion(responseObject, nil);
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                completion(nil, error);
            }];
}

- (void)queryLine:(NSString *)lineId completion:(BKLineCompletionBlock)completion {
    if (!completion) {
        return;
    }
    
    BKHTTPClient *client = [BKHTTPClient sharedClient];
    [client getPath:@"line"
         parameters:@{@"query" : lineId}
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                completion(responseObject, nil);
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                completion(nil, error);
            }];
}

@end
