//
//  TOGoalViewController.h
//  Timeout
//
//  Created by Matt Moriarity on 2/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@protocol TOGoalViewControllerDelegate;

@class TOWorkLog;

@interface TOGoalViewController : UIViewController {
    id <TOGoalViewControllerDelegate> delegate;
    TOWorkLog *log;
    
    IBOutlet UIDatePicker *datePicker;
}

@property (nonatomic, assign) id <TOGoalViewControllerDelegate> delegate;
@property (nonatomic, retain) TOWorkLog *log;

@property (nonatomic, retain) UIDatePicker *datePicker;

- (id)initWithLog:(TOWorkLog *)log;

- (IBAction)done;

@end

@protocol TOGoalViewControllerDelegate
- (void)goalViewControllerDidFinish:(TOGoalViewController *)controller;
@end