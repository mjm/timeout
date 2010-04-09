#ifndef SKIP_PUSH

#import "TORestModel.h"
#import "TORequestOperation.h"

//! Declarations of private methods so they can be called from a subclass.
@interface HRRestModel (PrivateMethods)

+ (NSMutableDictionary *)mergedOptions:(NSDictionary *)options;

@end


@implementation TORestModel

+ (NSOperation *)requestWithMethod:(HRRequestMethod)method path:(NSString *)path options:(NSDictionary *)options object:(id)obj {
    NSMutableDictionary *opts = [self mergedOptions:options];
    return [TORequestOperation requestWithMethod:method path:path options:opts object:obj];
}

@end

#endif