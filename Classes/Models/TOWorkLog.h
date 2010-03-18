@class TOLogEntry;

//! A log of entries for a single day.
@interface TOWorkLog : NSManagedObject {
}

//! The title for this log to display in the interface.
/*!
 This title is displayed in the title of the timer and the list of logs.
 */
@property (nonatomic, readonly) NSString *title;

//! The day this log represents.
@property (nonatomic, retain) NSDate *day;
//! The goal time (in seconds) to work for the day.
@property (nonatomic, retain) NSNumber *goal;
//! The hourly pay rate for the day.
@property (nonatomic, retain) NSDecimalNumber *rate;

//! The set of entries in this log.
@property (nonatomic, retain) NSSet *entries;
//! An array with at most one item: the currently running entry for this log.
@property (nonatomic, retain) NSArray *runningEntry;
//! The list of entries in this log sorted by increasing start time.
@property (nonatomic, retain) NSArray *orderedEntries;

//! The number of seconds left in this log.
/*!
 \return nil if the goal time has past, or the number of seconds left till the goal time
	is reached.
 */
- (NSNumber *)remainingSeconds;

//! The total time elapsed for all entries in this log.
- (NSDateComponents *)timeElapsed;

//! The time remaining until the goal time is reached.
/*!
 \return nil if the goal time is past, or date components containing the amount of time
	left.
 */
- (NSDateComponents *)timeLeft;

//! The estimated time of departure based on the time left and the goal time.
/*!
 \param date The current date.
 \return the estimated time of departure.
 */
- (NSDate *)estimatedDepartureFromDate:(NSDate *)date;

//! The amount of pay earned for the entries in this log.
- (NSNumber *)earnedPay;

@end
