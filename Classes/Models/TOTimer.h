#import "TORestModel.h"

@class TOWorkLog;

//! A timer on the push notification provider.
/*!
 \ingroup models
 */
@interface TOTimer : TORestModel {
}

//! Creates a timer on the push provider so that a notification will be sent when the timer is finished.
/*!
 \param log The work log to create a timer for.
 \param token The device that the timer is for.
 */
+ (void)createTimerForLog:(TOWorkLog *)log deviceToken:(NSString *)token;

//! Deletes the timer for a device on the push provider.
/*!
 \param token The device that the timer is for.
 */
+ (void)deleteTimerForDeviceToken:(NSString *)token;

@end