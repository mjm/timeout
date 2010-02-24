//
//  GoalViewController.m
//  Timeout
//
//  Created by Matt Moriarity on 2/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GoalViewController.h"
#import "TOWorkLog.h"


@implementation GoalViewController

@synthesize delegate;
@synthesize log;

- (id)initWithLog:(TOWorkLog *)aLog {
	if (![super initWithNibName:@"GoalView" bundle:nil])
		return nil;
	
	self.log = aLog;
	return self;
}

- (IBAction)done {
    self.log.goal = [NSNumber numberWithDouble:datePicker.countDownDuration];

    [self.delegate goalViewControllerDidFinish:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    datePicker.countDownDuration = [self.log.goal doubleValue];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	self.log = nil;
    [super dealloc];
}


@end
