//
//  TOTimerTypeController.m
//  Timeout
//
//  Created by Matt Moriarity on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TOTimerTypeController.h"
#import "TOTimerGoalViewController.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
