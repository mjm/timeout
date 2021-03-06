#import "TOTimerViewController.h"

#import "TOLogController.h"

#import "../Models/TOWorkLog.h"
#import "../Models/TOLogEntry.h"

#pragma mark Private Methods

@interface TOTimerViewController (PrivateMethods)

//! \name Private Methods
//@{

//! Called when the timer fires.
/*!
 Delegates to subclass implementations of updateWithDateComponents: to perform the actual
 updating of the display.
 
 \param aTimer The timer that has fired.
 */
- (void)timerUpdate:(NSTimer *)aTimer;

//@}

@end

#pragma mark -

@implementation TOTimerViewController

@synthesize logController, log;
@synthesize navigationItem, startStopButton;

#pragma mark -
#pragma mark Initializing a View Controller

- (id)initWithNibName:(NSString *)nibName logController:(TOLogController *)controller {
	if (![super initWithNibName:nibName bundle:nil])
		return nil;
	
	self.logController = controller;
	return self;
}

#pragma mark -
#pragma mark View Controller Lifecycle

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

#pragma mark -
#pragma mark Updating the View

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
	TOLogEntry *entry = [self.logController runningEntryForLog:self.log];
	[self setButtonState:![entry isRunning]];
	
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

#pragma mark -
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

#pragma mark -
#pragma mark View Controller Delegate Methods

- (void)logsViewControllerDidFinish:(TOLogsViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	self.log = nil;
	self.logController = nil;
    [super dealloc];
}


@end
