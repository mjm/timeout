@class TOWorkLog;

//! An entry for a contiguous block of time in a work log.
/*!
 \ingroup models
 */
@interface TOLogEntry : NSManagedObject {
}

//! The start time of the entry.
@property (nonatomic, retain) NSDate *startTime;
//! The end time of the entry.
@property (nonatomic, retain) NSDate *endTime;
//! The work log that this entry belongs to.
@property (nonatomic, retain) TOWorkLog *log;

//! The amount of time encompassed by this entry.
/*!
 If the end time is not set, it will be assumed to be the current time.
 
 \return the number of seconds that have passed.
 */
- (NSTimeInterval)timeElapsed;

//! The amount of money earned for this entry.
- (NSDecimalNumber *)earnedPay;

//! Whether or not the timer is running.
/*!
 \return YES if start time is set but end time is not, NO otherwise.
 */
- (BOOL)isRunning;

//! Starts the timer by setting the start time to the current time.
- (void)startTimer;

//! Stops the timer by setting the end time to the current time.
- (void)stopTimer;

@end
