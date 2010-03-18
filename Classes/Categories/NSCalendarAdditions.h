//! Additional methods for NSCalendar that allow conversion between NSDateComponents and NSTimeInterval.
@interface NSCalendar (Additions)

//! Converts a time interval into date components.
- (NSDateComponents *)components:(NSUInteger)units fromInterval:(NSTimeInterval)interval;

//! Converts date components into a time interval.
- (NSTimeInterval)intervalFromComponents:(NSDateComponents *)components;

@end
