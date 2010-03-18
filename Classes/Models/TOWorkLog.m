#import "TOLogEntry.h"
#import "TOWorkLog.h"

@implementation TOWorkLog

@dynamic day, goal, rate, entries, runningEntry, orderedEntries;

- (NSString *)title {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	
	formatter.dateFormat = @"eeee";
	NSString *weekday = [formatter stringFromDate:self.day];
	
	formatter.dateStyle = NSDateFormatterShortStyle;
	NSString *date = [formatter stringFromDate:self.day];
	
	[formatter release];
	return [NSString stringWithFormat:@"%@, %@", weekday, date];
}

const NSUInteger timeUnits = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;

- (NSNumber *)remainingSeconds {
	NSDateComponents *components = [self timeLeft];
	if (components == nil) {
		return nil;
	}
	
	NSUInteger seconds = [components second] + (60 * [components minute]) + (3600 * [components hour]);
	return [NSNumber numberWithInt:seconds];
}

- (NSDateComponents *)timeElapsed {
    NSTimeInterval elapsed = 0;
    for (TOLogEntry *entry in self.entries) {
        elapsed += [entry timeElapsed];
    }
    
    NSDate *start = [NSDate date];
    NSDate *end = [start addTimeInterval:elapsed];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return [calendar components:timeUnits fromDate:start toDate:end options:0];
}

- (NSDateComponents *)timeLeft {
    NSDateComponents *timeElapsed = [self timeElapsed];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *reference = [NSDate date];
    NSDate *start = [calendar dateByAddingComponents:timeElapsed toDate:reference options:0];
    NSDate *end = [reference addTimeInterval:[self.goal doubleValue]];
	
	if ([start compare:end] == NSOrderedDescending) {
		return nil;
	}
    
    return [calendar components:timeUnits fromDate:start toDate:end options:0];
}

- (NSDate *)estimatedDepartureFromDate:(NSDate *)date {
	if ([self timeLeft] == nil) {
		return nil;
	}
	
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    return [calendar dateByAddingComponents:[self timeLeft] toDate:now options:0];
}

- (NSNumber *)earnedPay {
	NSDecimalNumber *total = [NSDecimalNumber zero];
	
	for (TOLogEntry *entry in self.entries) {
		total = [total decimalNumberByAdding:[entry earnedPay]];
	}
	
	return total;
}

@end
