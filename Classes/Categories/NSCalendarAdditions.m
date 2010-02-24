//
//  NSCalendarAdditions.m
//  Timeout
//
//  Created by Matt Moriarity on 2/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSCalendarAdditions.h"


@implementation NSCalendar (Additions)

- (NSDateComponents *)components:(NSUInteger)units fromInterval:(NSTimeInterval)interval {
    NSDate *start = [NSDate date];
    NSDate *end = [start addTimeInterval:interval];
    
    return [self components:units fromDate:start toDate:end options:0];
}

- (NSTimeInterval)intervalFromComponents:(NSDateComponents *)components {
    NSDate *start = [NSDate date];
    NSDate *end = [self dateByAddingComponents:components toDate:start options:0];
    
    return [end timeIntervalSinceDate:start];
}

@end
