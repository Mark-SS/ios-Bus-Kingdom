//
//  BKLineInfo.m
//  BusKingdom
//
//  Created by gongliang on 13-9-3.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import "BKLineInfo.h"
#import "BKAFHTTPClient.h"


@interface BKLineInfo()

@end

@implementation BKLineInfo

- (void)dealloc
{
    NSLog(@"BKLineInfo dealloc");
}

- (id)init
{
    if (self = [super init]) {
        NSLog(@"111");
    }
    return self;
}

//请求一条路线的信息
- (void)queryStation:(NSString *)lName comletion:(BKLineCompletionBlock)completion
{
    if (!completion)
        return;
    NSDictionary *dic = @{@"query":lName,
                          @"pos":@"116.29321,39.83321",
                          @"jump":@""};
    
    [[BKAFHTTPClient sharedInstance]getPath:@"bus/search/line.json"
                                 parameters:dic
                                    success:^(AFHTTPRequestOperation *op, id object){
                                        completion([self getLineInfo:object],nil);
    }
                                    failure:^(AFHTTPRequestOperation *op, NSError *error){
                                        completion(nil,error);
                                        
                                        NSLog(@"error = %@",error);
    }];
}

//根据站点和路线id得到此时车辆状态
- (void)queryBusStatus:(NSInteger)lid andStation:(NSInteger)sid comletion:(BKLineCompletionBlock)completion
{
    if (!completion) {
        return;
    }
    NSDictionary *dic = @{@"lid":@(lid),
                          @"sid":@(sid)};
    [[BKAFHTTPClient sharedInstance]getPath:@"bus/latestio.json"
                                 parameters:dic
                                    success:^(AFHTTPRequestOperation *op, id obj){
                                        completion(obj,nil);
                                    }
                                    failure:^(AFHTTPRequestOperation *op, NSError *error){
                                        completion(nil,error);
                                    }];
}

//根据key解析得到数据
- (BKLineInfo *)getLineInfo:(id)object
{
    NSDictionary *dic = object[@"result"][@"line_home"];
    NSDictionary *lineDic = dic[@"line"];
    BKLineInfo *lineInfo = [BKLineInfo new];
    lineInfo.lid = [lineDic[@"id"]integerValue];
    lineInfo.lName = lineDic[@"name"];
    lineInfo.staCount = [lineDic[@"sta_count"]integerValue];
    lineInfo.firstTime = lineDic[@"first_time"];
    lineInfo.staArray = dic[@"sta"];
    return lineInfo;
}

@end
