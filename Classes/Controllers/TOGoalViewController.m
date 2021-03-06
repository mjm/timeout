#import "TOGoalViewController.h"
#import "../Models/TOWorkLog.h"

@implementation TOGoalViewController

@synthesize delegate, log;
@synthesize datePicker;

+ (void)initialize {
	[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:6]
																						forKey:@"TOGoalIncrement"]];
}

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
	 self.datePicker.minuteInterval = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TOGoalIncrement"] intValue];
}

- (void)viewDidAppear:(BOOL)animated {
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
	[super viewDidAppear:animated];
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
