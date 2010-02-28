//
//  TOGoalViewController.m
//  Timeout
//
//  Created by Matt Moriarity on 2/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TOGoalViewController.h"
#import "../Models/TOWorkLog.h"

@implementation TOGoalViewController

@synthesize delegate, log;
@synthesize datePicker;

- (id)initWithLog:(TOWorkLog *)aLog {
	if (![super initWithNibName:@"TOGoalViewController" bundle:nil])
		return nil;
	
	self.log = aLog;
	return self;
}

- (IBAction)done {
    self.log.goal = [NSNumber numberWithDouble:self.datePicker.countDownDuration];

    [self.delegate goalViewControllerDidFinish:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datePicker.countDownDuration = [self.log.goal doubleValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.datePicker = nil;
}


- (void)dealloc {
	self.log = nil;
	self.delegate = nil; // shouldn't release
    [super dealloc];
}


@end
