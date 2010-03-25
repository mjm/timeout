#import "TOTimerGoalViewController.h"

#import "../Categories/NSCalendar+Additions.h"

#import "TOLogController.h"
#import "../Models/TOWorkLog.h"
#import "../Models/TOLogEntry.h"
#import "../Models/TOTimer.h"
#import "../TOAppDelegate.h"

#pragma mark Private Methods

@interface TOTimerGoalViewController (PrivateMethods)

//! \name Private Methods
//@{

//! Updates the status of the push notification server.
- (void)updatePushTimer;

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
	[self updatePushTimer];
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

- (void)updatePushTimer {
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

#pragma mark -
#pragma mark View Controller Delegate Methods

- (void)goalViewControllerDidFinish:(TOGoalViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
	
	[[NSUserDefaults standardUserDefaults] setObject:self.log.goal forKey:@"TOLastGoal"];
    [self.logController save];
	
	[self updatePushTimer];
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
