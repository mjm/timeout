//
//  TOTimerViewController.h
//  Timeout
//
//  Created by Matt Moriarity on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class TOLogController;
@class TOWorkLog;

#import "TOLogsViewController.h"


typedef enum {
	TOTimerTypeNone,
	TOTimerTypeGoal,
	TOTimerTypePay
} TOTimerType;


@interface TOTimerViewController : UIViewController <TOLogsViewControllerDelegate> {
	TOWorkLog *log;
	TOLogController *logController;
	
	NSTimer *timer;
	NSDateComponents *lastComponents;
	
	IBOutlet UINavigationItem *navigationItem;
	IBOutlet UIButton *startStopButton;
}

@property (nonatomic, retain) TOWorkLog *log;
@property (nonatomic, retain) TOLogController *logController;

@property (nonatomic, retain) UINavigationItem *navigationItem;
@property (nonatomic, retain) UIButton *startStopButton;

- (id)initWithNibName:(NSString *)nibName logController:(TOLogController *)controller;

- (void)updateWithLogInfo;
- (void)updateWithDateComponents:(NSDateComponents *)components;

- (IBAction)viewLogs;
- (IBAction)startOrStopTimer;

- (void)setButtonState:(BOOL)isStartButton;

@end
