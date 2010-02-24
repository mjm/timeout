//
//  MainViewController.m
//  Timeout
//
//  Created by Matt Moriarity on 2/14/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MainViewController.h"

#import "NSCalendarAdditions.h"

#import "TOLogController.h"
#import "TOLogEntry.h"


@interface MainViewController (PrivateMethods)

- (void)timerUpdate:(NSTimer *)aTimer;
- (void)updateWithLogInfo;
- (void)updateWithDateComponents:(NSDateComponents *)components;

- (void)setButtonState:(BOOL)startButton;

@end

@implementation MainViewController

@synthesize logController, todayLog;

- (id)initWithLogController:(TOLogController *)controller {
	if (![super initWithNibName:@"MainView" bundle:nil])
		return nil;
	
	self.logController = controller;
	return self;
}

- (void)viewDidDisappear:(BOOL)animated {
	[timer invalidate];
	timer = nil;
	
	[super viewDidDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    self.todayLog = [logController currentLog];
    [self updateWithLogInfo];
	
	if (timer != nil) {
		[timer invalidate];
	}
	
	timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(timerUpdate:)
                                           userInfo:nil
                                            repeats:YES];
	
	// make sure the view immediately appears up-to-date
	[self timerUpdate:nil];
	
	[super viewDidAppear:animated];
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
	
	[startStopButton setTitle:title forState:UIControlStateNormal];
	UIImage *image = [UIImage imageNamed:imageName];
	[startStopButton setBackgroundImage:image forState:UIControlStateNormal];
	
}

- (void)updateWithLogInfo {
    todayItem.title = todayLog.title;
    
    TOLogEntry *entry = [logController runningEntryForLog:todayLog];
	[self setButtonState:![entry isRunning]];
}

- (void)logsViewControllerDidFinish:(TOLogsViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)goalViewControllerDidFinish:(GoalViewController *)controller {
    [self dismissModalViewControllerAnimated:YES];
    [logController save];
}


- (IBAction)showInfo {    
	TOLogsViewController *controller = [[TOLogsViewController alloc] initWithLogController:self.logController];
	controller.delegate = self;
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
	[controller release];
	
	[self presentModalViewController:navController animated:YES];
	[navController release];
}

- (IBAction)changeGoal {
    GoalViewController *controller = [[GoalViewController alloc] initWithLog:todayLog];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	
    [self presentModalViewController:controller animated:YES];
    [controller release];
}

- (IBAction)startOrStopTimer {
    TOLogEntry *entry = [logController runningEntryForLog:todayLog];
    if ([entry isRunning]) {
        [entry stopTimer];
    } else {
        [entry startTimer];
    }
    
    [logController save];
    [self setButtonState:![entry isRunning]];
	[self timerUpdate:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:components];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    NSDate *departure = [todayLog estimatedDepartureFromDate:date];
    NSDate *timeLeft = [calendar dateFromComponents:[todayLog timeLeft]];
    NSDate *timeElapsed = [calendar dateFromComponents:[todayLog timeElapsed]];
    
    formatter.dateFormat = @"H:mm:ss";
	leftLabel.text = [formatter stringFromDate:timeLeft];
	elapsedLabel.text = [formatter stringFromDate:timeElapsed];
    
    formatter.timeStyle = NSDateFormatterShortStyle;
	if (departure == nil) {
		departureLabel.text = @"Done";
	} else {
		departureLabel.text = [formatter stringFromDate:departure];
	}
    
    [formatter release];
}

- (void)viewDidUnload {
	self.todayLog = nil;
}


- (void)dealloc {
	self.logController = nil;
    [super dealloc];
}


@end
