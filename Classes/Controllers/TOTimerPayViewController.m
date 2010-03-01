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

- (IBAction)changeRate {
	// TODO
}

- (void)updateWithDateComponents:(NSDateComponents *)components {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	
	TOLogEntry *entry = [self.logController runningEntryForLog:self.log];
	
	NSDate *elapsed = [calendar dateFromComponents:[self.log timeElapsed]];
	NSDate *start = entry.startTime;
	// TODO actually populate
	NSNumber *earned = [NSDecimalNumber decimalNumberWithString:@"0"];
	
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
