#import "TOTimerTypeController.h"
#import "TOTimerGoalViewController.h"

@interface TOTimerTypeController (PrivateMethods)

//! Sets the timer type for the application and notifies the delegate that the user is finished.
/*!
 \param timerType The timer type that the user has chosen.
 */
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
	[super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.goalButton = nil;
	self.payButton = nil;
}

- (void)setTimerType:(TOTimerType)timerType {
	[[NSUserDefaults standardUserDefaults] setInteger:timerType forKey:@"TOTimerType"];
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
