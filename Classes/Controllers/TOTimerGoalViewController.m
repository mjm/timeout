//
//  TOTimerGoalViewController.m
//  Timeout
//
//  Created by Matt Moriarity on 2/14/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "TOTimerGoalViewController.h"

#import "../Categories/NSCalendarAdditions.h"

#import "TOLogController.h"
#import "../Models/TOWorkLog.h"
#import "../Models/TOLogEntry.h"


@implementation TOTimerGoalViewController

@synthesize departureLabel, elapsedLabel, leftLabel;

- (id)initWithLogController:(TOLogController *)controller {
	if (![super initWithNibName:@"TOTimerGoalViewController" logController:controller])
		return nil;
	
	return self;
}

- (void)goalViewControllerDidFinish:(TOGoalViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
    [self.logController save];
}

- (IBAction)changeGoal {
    TOGoalViewController *controller = [[TOGoalViewController alloc] initWithLog:self.log];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	
    [self presentModalViewController:controller animated:YES];
    [controller release];
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

- (void)viewDidUnload {
	self.departureLabel = nil;
	self.elapsedLabel = nil;
	self.leftLabel = nil;
	[super viewDidUnload];
}


@end
