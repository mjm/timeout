//
//  TOTimerTypeController.h
//  Timeout
//
//  Created by Matt Moriarity on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TOTimerTypeController;

@protocol TOTimerTypeControllerDelegate

- (void)timerTypeControllerDidFinish:(TOTimerTypeController *)controller;

@end


@interface TOTimerTypeController : UIViewController {
	id <TOTimerTypeControllerDelegate> delegate;
	
	IBOutlet UIButton *goalButton;
	IBOutlet UIButton *payButton;
}

@property (nonatomic, assign) id <TOTimerTypeControllerDelegate> delegate;

@property (nonatomic, retain) UIButton *goalButton;
@property (nonatomic, retain) UIButton *payButton;

- (id)init;

- (IBAction)selectGoal;
- (IBAction)selectPay;

@end
