//
//  TOTimerViewController.m
//  Timeout
//
//  Created by Matt Moriarity on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TOTimerViewController.h"

#import "TOLogController.h"

#import "../Models/TOWorkLog.h"
#import "../Models/TOLogEntry.h"

@interface TOTimerViewController (PrivateMethods)

- (void)timerUpdate:(NSTimer *)aTimer;

@end


@implementation TOTimerViewController

@synthesize logController, log;
@synthesize navigationItem, startStopButton;

#pragma mark Initialization

- (id)initWithNibName:(NSString *)nibName logController:(TOLogController *)controller {
	if (![super initWithNibName:nibName bundle:nil])
		return nil;
	
	self.logController = controller;
	return self;
}

#pragma mark View controller lifecycle

- (void)viewDidAppear:(BOOL)animated {
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
	
	self.log = [self.logController currentLog];
	[self updateWithLogInfo];
	
	if (timer != nil)
		[timer invalidate];
	
	timer = [NSTimer scheduledTimerWithTimeInterval:1.0
											 target:self
										   selector:@selector(timerUpdate:)
										   userInfo:nil
											repeats:YES];
	
	[self timerUpdate:nil];
	
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[timer invalidate];
	timer = nil;
	
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.navigationItem = nil;
	self.startStopButton = nil;
	[super viewDidUnload];
}

#pragma mark Display updating

- (void)updateWithLogInfo {
	self.navigationItem.title = self.log.title;
	
	TOLogEntry *entry = [self.logController runningEntryForLog:self.log];
	[self setButtonState:![entry isRunning]];
}

- (void)setButtonState:(BOOL)startButton {
	NSString *title;
	NSString *imageName;
	
	if (startButton) {
		title = @"Start Timer";
		imageName = @"StartButton.png";
	} else {
		title = @"Stop Timer";
		imageName = @"StopButton.png";
	}
	
	[self.startStopButton setTitle:title forState:UIControlStateNormal];
	UIImage *image = [UIImage imageNamed:imageName];
	[self.startStopButton setBackgroundImage:image forState:UIControlStateNormal];
	
}

- (void)timerUpdate:(NSTimer *)aTimer {
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    const NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |
	NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    if (![components isEqual:lastComponents]) {
        [lastComponents release];
        lastComponents = [components retain];
        [self updateWithDateComponents:components];
    }
}

- (void)updateWithDateComponents:(NSDateComponents *)components {
	[self doesNotRecognizeSelector:_cmd];
}

#pragma mark Actions

- (IBAction)viewLogs {
	TOLogsViewController *controller = [[TOLogsViewController alloc] initWithLogController:self.logController];
	controller.delegate = self;
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
	[controller release];
	
	[self presentModalViewController:navController animated:YES];
	[navController release];
}

- (IBAction)startOrStopTimer {
    TOLogEntry *entry = [self.logController runningEntryForLog:self.log];
    if ([entry isRunning]) {
        [entry stopTimer];
    } else {
        [entry startTimer];
    }
    
    [self.logController save];
    [self setButtonState:![entry isRunning]];
	[self timerUpdate:nil];
}

#pragma mark View controller delegate methods

- (void)logsViewControllerDidFinish:(TOLogsViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark Memory management

- (void)dealloc {
	self.log = nil;
	self.logController = nil;
    [super dealloc];
}


@end
