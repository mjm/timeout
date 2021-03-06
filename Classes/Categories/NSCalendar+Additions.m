#import "NSCalendar+Additions.h"

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
