//
//  MainViewController.h
//  Timeout
//
//  Created by Matt Moriarity on 2/14/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

@class TOLogController;

#import "TOLogsViewController.h"
#import "GoalViewController.h"
#import "../Models/TOWorkLog.h"

@interface MainViewController : UIViewController <GoalViewControllerDelegate, TOLogsViewControllerDelegate> {
    TOWorkLog *todayLog;

    NSTimer *timer;
    NSDateComponents *lastComponents;
    TOLogController *logController;
    
    IBOutlet UINavigationItem *todayItem;
    IBOutlet UILabel *departureLabel;
    IBOutlet UILabel *elapsedLabel;
    IBOutlet UILabel *leftLabel;
    IBOutlet UIButton *startStopButton;
}

@property (nonatomic, retain) TOLogController *logController;
@property (nonatomic, retain) TOWorkLog *todayLog;

- (id)initWithLogController:(TOLogController *)controller;

- (IBAction)showInfo;
- (IBAction)changeGoal;
- (IBAction)startOrStopTimer;

@end
