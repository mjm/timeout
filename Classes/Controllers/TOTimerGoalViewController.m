#import "TOTimerGoalViewController.h"

#import "../Categories/NSCalendar+Additions.h"

#import "TOLogController.h"
#import "../Models/TOWorkLog.h"
#import "../Models/TOLogEntry.h"
#import "../TOAppDelegate.h"

#ifndef SKIP_PUSH
#import "../Models/TOTimer.h"
#endif

#pragma mark Private Methods

@interface TOTimerGoalViewController (PrivateMethods)

//! \name Private Methods
//@{

//! Updates the status of the push notification server.
- (void)scheduleNotification;

//@}

@end

#pragma mark -

@implementation TOTimerGoalViewController

@synthesize departureLabel, elapsedLabel, leftLabel;

#pragma mark -
#pragma mark Initializing a View Controller

- (id)initWithLogController:(TOLogController *)controller {
	if (![super initWithNibName:@"TOTimerGoalViewController" logController:controller])
		return nil;
	
	return self;
}

#pragma mark -
#pragma mark Updating the View

- (void)setButtonState:(BOOL)isStartButton {
	[super setButtonState:isStartButton];
	[self scheduleNotification];
}

- (void)updateWithDateComponents:(NSDateComponents *)components {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:components];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    NSDate *departure = [self.log estimatedDepartureFromDate:date];
    NSDate *timeLeft = [calendar dateFromComponents:[self.log timeLeft]];
    NSDate *timeElapsed = [calendar dateFromComponents:[self.log timeElapsed]];
    
    formatter.dateFormat = @"H:mm:ss";
	self.leftLabel.text = [formatter stringFromDate:timeLeft];
	self.elapsedLabel.text = [formatter stringFromDate:timeElapsed];
    
    formatter.timeStyle = NSDateFormatterShortStyle;
	if (departure == nil) {
		self.departureLabel.text = @"Done";
	} else {
		self.departureLabel.text = [formatter stringFromDate:departure];
	}
    
    [formatter release];
}

#pragma mark -
#pragma mark Updating the Push Provider

- (void)scheduleNotification {
	Class localNotification = NSClassFromString(@"UILocalNotification");
	if (localNotification) {
		[[UIApplication sharedApplication] cancelAllLocalNotifications];
		
		TOLogEntry *entry = [self.logController runningEntryForLog:self.log];
		if ([entry isRunning]) {
			NSDate *departure = [self.log estimatedDepartureFromDate:[NSDate date]];
			
			UILocalNotification *notification = [[localNotification alloc] init];
			if (!notification)
				return;
			
			notification.fireDate = departure;
			notification.timeZone = [NSTimeZone defaultTimeZone];
			notification.alertBody = @"Time to leave!";
			notification.alertAction = @"Stop Timer";
			notification.soundName = UILocalNotificationDefaultSoundName;
			
			[[UIApplication sharedApplication] scheduleLocalNotification:notification];
			[notification release];
		}
	}
#ifndef SKIP_PUSH
	else {
		TOAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		NSString *token = delegate.deviceToken;
		
		TOLogEntry *entry = [self.logController runningEntryForLog:self.log];
		
		if (token) {
			if ([entry isRunning]) {
				[TOTimer createTimerForLog:self.log deviceToken:delegate.deviceToken];
			} else {
				[TOTimer deleteTimerForDeviceToken:delegate.deviceToken];
			}
		}
	}
#endif
}

#pragma mark -
#pragma mark View Controller Delegate Methods

- (void)goalViewControllerDidFinish:(TOGoalViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
	
	[[NSUserDefaults standardUserDefaults] setObject:self.log.goal forKey:@"TOLastGoal"];
    [self.logController save];
	
	[self scheduleNotification];
}

#pragma mark -
#pragma mark Actions

- (IBAction)changeGoal {
    TOGoalViewController *controller = [[TOGoalViewController alloc] initWithLog:self.log];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	
    [self presentModalViewController:controller animated:YES];
    [controller release];
}

#pragma mark -
#pragma mark View Controller Lifecycle

- (void)viewDidUnload {
	self.departureLabel = nil;
	self.elapsedLabel = nil;
	self.leftLabel = nil;
	[super viewDidUnload];
}


@end
