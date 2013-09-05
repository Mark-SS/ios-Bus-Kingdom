//
//  BKHTTPClient.m
//  BusKingdom
//
//  Created by yy on 13-7-16.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import "BKHTTPClient.h"
#import "BKDefine.h"

@implementation BKHTTPClient

+ (BKHTTPClient *)sharedClient {
    static BKHTTPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[BKHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kBKApiBaseURL]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}





@end
