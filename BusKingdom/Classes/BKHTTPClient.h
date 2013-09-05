//
//  BKHTTPClient.h
//  BusKingdom
//
//  Created by yy on 13-7-16.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface BKHTTPClient : AFHTTPClient

+ (BKHTTPClient *)sharedClient;

@end
