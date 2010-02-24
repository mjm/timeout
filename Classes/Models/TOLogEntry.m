//
//  TOLogEntry.m
//  Timeout
//
//  Created by Matt Moriarity on 2/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TOLogEntry.h"


@implementation TOLogEntry

@dynamic startTime;
@dynamic endTime;
@dynamic log;

- (NSTimeInterval)timeElapsed {
    if (self.startTime == nil) {
        return 0;
    }
    
    NSDate *start = self.startTime;
    NSDate *end = (self.endTime == nil) ? [NSDate date] : self.endTime;
    
    return [end timeIntervalSinceDate:start];
}

- (BOOL)isRunning {
    return (self.startTime != nil) && (self.endTime == nil);
}

- (void)startTimer {
    if (self.startTime != nil || self.endTime != nil) {
        return;
    }
    
    self.startTime = [NSDate date];
}

- (void)stopTimer {
    if (![self isRunning]) {
        return;
    }
    
    self.endTime = [NSDate date];
}

@end
