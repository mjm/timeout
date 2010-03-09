//
//  TORestModel.m
//  Timeout
//
//  Created by Matt Moriarity on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TORestModel.h"
#import "TORequestOperation.h"

@interface HRRestModel (PrivateMethods)

+ (NSMutableDictionary *)mergedOptions:(NSDictionary *)options;

@end


@implementation TORestModel

+ (NSOperation *)requestWithMethod:(HRRequestMethod)method path:(NSString *)path options:(NSDictionary *)options object:(id)obj {
    NSMutableDictionary *opts = [self mergedOptions:options];
    return [TORequestOperation requestWithMethod:method path:path options:opts object:obj];
}

@end
