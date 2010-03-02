//
//  TOTimerPayViewController.m
//  Timeout
//
//  Created by Matt Moriarity on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TOTimerPayViewController.h"

#import "TOLogController.h"
#import "../Models/TOWorkLog.h"
#import "../Models/TOLogEntry.h"

@implementation TOTimerPayViewController

@synthesize elapsedLabel, startLabel, earnedLabel;

- (id)initWithLogController:(TOLogController *)controller {
	if (![super initWithNibName:@"TOTimerPayViewController" logController:controller])
		return nil;
	
	return self;
}

- (void)payViewController:(TOPayViewController *)controller rateDidChange:(NSDecimalNumber *)rate {
	self.log.rate = rate;
	[[NSUserDefaults standardUserDefaults] setObject:rate forKey:@"TOLastRate"];
	
	[self dismissModalViewControllerAnimated:YES];
	[self.logController save];
}

- (IBAction)changeRate {
    TOPayViewController *controller = [[TOPayViewController alloc] initWithRate:self.log.rate];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	
    [self presentModalViewController:controller animated:YES];
    [controller release];
}

- (void)updateWithDateComponents:(NSDateComponents *)components {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	
	TOLogEntry *entry = [self.logController runningEntryForLog:self.log];
	
	NSDate *elapsed = [calendar dateFromComponents:[self.log timeElapsed]];
	NSDate *start = entry.startTime;
	NSNumber *earned = [self.log earnedPay];
	
	dateFormatter.dateFormat = @"H:mm:ss";
	self.elapsedLabel.text = [dateFormatter stringFromDate:elapsed];
	
	dateFormatter.timeStyle = NSDateFormatterShortStyle;
	if (start == nil) {
		self.startLabel.text = @"--:--";
	} else {
		self.startLabel.text = [dateFormatter stringFromDate:start];
	}
	
	numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
	self.earnedLabel.text = [numberFormatter stringFromNumber:earned];
	
	[dateFormatter release];
	[numberFormatter release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.elapsedLabel = nil;
	self.startLabel = nil;
	self.earnedLabel = nil;
	[super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}


@end
