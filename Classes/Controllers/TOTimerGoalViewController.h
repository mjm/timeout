//
//  TOTimerGoalViewController.h
//  Timeout
//
//  Created by Matt Moriarity on 2/14/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

@class TOLogController;

#import "TOTimerViewController.h"
#import "TOGoalViewController.h"

@interface TOTimerGoalViewController : TOTimerViewController <TOGoalViewControllerDelegate> {
    IBOutlet UILabel *departureLabel;
    IBOutlet UILabel *elapsedLabel;
    IBOutlet UILabel *leftLabel;
}

@property (nonatomic, retain) UILabel *departureLabel;
@property (nonatomic, retain) UILabel *elapsedLabel;
@property (nonatomic, retain) UILabel *leftLabel;

- (id)initWithLogController:(TOLogController *)controller;

- (IBAction)changeGoal;

@end
