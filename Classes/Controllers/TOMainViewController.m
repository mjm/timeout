#import "TOMainViewController.h"

#import "TOTimerGoalViewController.h"
#import "TOTimerPayViewController.h"
#import "TOTimerTypeController.h"

@interface TOMainViewController (PrivateMethods)

//! The current preferred timer type, loaded from the user defaults.
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
	BOOL animate = NO;
	switch (timerType) {
		case TOTimerTypeNone:
			controller = [[TOTimerTypeController alloc] init];
			((TOTimerTypeController *) controller).delegate = self;
			animate = YES;
			break;
		case TOTimerTypeGoal:
			controller = [[TOTimerGoalViewController alloc] initWithLogController:self.logController];
			break;
		case TOTimerTypePay:
			controller = [[TOTimerPayViewController alloc] initWithLogController:self.logController];
			break;
		default:
			return;
	}
	
	controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[self presentModalViewController:controller animated:animate];
	
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
