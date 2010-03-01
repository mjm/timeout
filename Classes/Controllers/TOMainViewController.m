//
//  TOMainViewController.m
//  Timeout
//
//  Created by Matt Moriarity on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TOMainViewController.h"

#import "TOTimerGoalViewController.h"
#import "TOTimerTypeController.h"

@interface TOMainViewController (PrivateMethods)
@property (nonatomic, readonly) TOTimerType timerType;
@end

@implementation TOMainViewController

@synthesize logController;

- (id)initWithLogController:(TOLogController *)controller {
	if (![super initWithNibName:@"TOMainViewController" bundle:nil])
		return nil;
	
	self.logController = controller;
	return self;
}

- (void)presentMainController {
	TOTimerType timerType = self.timerType;
	
	UIViewController *controller;
	switch (timerType) {
		case TOTimerTypeNone:
			controller = [[TOTimerTypeController alloc] init];
			((TOTimerTypeController *) controller).delegate = self;
			break;
		case TOTimerTypeGoal:
			controller = [[TOTimerGoalViewController alloc] initWithLogController:self.logController];
			break;
		default:
			return;
	}
	
	controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}

- (TOTimerType)timerType {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	return [userDefaults integerForKey:@"TOTimerType"];
}

- (void)timerTypeControllerDidFinish:(TOTimerTypeController *)controller {
	[self dismissModalViewControllerAnimated:YES];
	[self performSelector:@selector(presentMainController) withObject:nil afterDelay:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (void)dealloc {
	self.logController = nil;
    [super dealloc];
}


@end
