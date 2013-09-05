//
//  BKAFHTTPClient.h
//  BusKingdom
//
//  Created by gongliang on 13-9-3.
//  Copyright (c) 2013年 yongche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPClient.h>

@interface BKAFHTTPClient : AFHTTPClient

+ (id)sharedInstance;

@end
