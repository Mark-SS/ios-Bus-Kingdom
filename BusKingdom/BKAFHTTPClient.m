//
//  BKAFHTTPClient.m
//  BusKingdom
//
//  Created by gongliang on 13-9-3.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import "BKAFHTTPClient.h"
#import "BKDefine.h"
#import <AFNetworking/AFJSONRequestOperation.h>


@implementation BKAFHTTPClient

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    static BKAFHTTPClient *_bkATHTTPClient;
    dispatch_once(&onceToken, ^{
        _bkATHTTPClient = [[BKAFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:kBKApiURL]];
    });
    
    return _bkATHTTPClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
     
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
        [self setDefaultHeader:@"Accept" value:@"text/plain"];
    }
    
    return self;
}

@end
