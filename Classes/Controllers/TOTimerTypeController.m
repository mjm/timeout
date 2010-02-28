//
//  TOTimerTypeController.m
//  Timeout
//
//  Created by Matt Moriarity on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TOTimerTypeController.h"
#import "MainViewController.h"

@interface TOTimerTypeController (PrivateMethods)
- (void)setTimerType:(TOTimerType)timerType;
@end

@implementation TOTimerTypeController

@synthesize delegate;
@synthesize goalButton, payButton;

- (id)init {
	if (![super initWithNibName:@"TOTimerTypeController" bundle:nil])
		return nil;
	
	return self;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.goalButton = nil;
	self.payButton = nil;
}

- (void)setTimerType:(TOTimerType)timerType {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setInteger:timerType forKey:@"TOTimerType"];
	[self.delegate timerTypeControllerDidFinish:self];
}

- (IBAction)selectGoal {
	[self setTimerType:TOTimerTypeGoal];
}

- (IBAction)selectPay {
	[self setTimerType:TOTimerTypePay];
}


- (void)dealloc {
    [super dealloc];
}


@end
