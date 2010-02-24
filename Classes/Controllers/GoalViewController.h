//
//  GoalViewController.h
//  Timeout
//
//  Created by Matt Moriarity on 2/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@protocol GoalViewControllerDelegate;

@class TOWorkLog;

@interface GoalViewController : UIViewController {
    id <GoalViewControllerDelegate> delegate;
    TOWorkLog *log;
    
    IBOutlet UIDatePicker *datePicker;
}

@property (nonatomic, assign) id <GoalViewControllerDelegate> delegate;
@property (nonatomic, retain) TOWorkLog *log;

- (id)initWithLog:(TOWorkLog *)log;

- (IBAction)done;

@end

@protocol GoalViewControllerDelegate
- (void)goalViewControllerDidFinish:(GoalViewController *)controller;
@end