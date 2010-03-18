#import "TOLogEntry.h"
#import "TOWorkLog.h"

@implementation TOLogEntry

@dynamic startTime, endTime, log;

- (NSTimeInterval)timeElapsed {
    if (self.startTime == nil) {
        return 0;
    }
    
    NSDate *start = self.startTime;
    NSDate *end = (self.endTime == nil) ? [NSDate date] : self.endTime;
    
    return [end timeIntervalSinceDate:start];
}

- (NSDecimalNumber *)earnedPay {
	NSDecimalNumber *rate = self.log.rate;
	NSTimeInterval elapsed = [self timeElapsed];
	
	double hours = elapsed / 3600;
	return [rate decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithDecimal:
											   [[NSNumber numberWithDouble:hours] decimalValue]]];
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
