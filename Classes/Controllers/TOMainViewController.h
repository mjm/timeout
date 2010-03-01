//
//  TOMainViewController.h
//  Timeout
//
//  Created by Matt Moriarity on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class TOLogController;

#import "TOTimerTypeController.h"

@interface TOMainViewController : UIViewController <TOTimerTypeControllerDelegate> {
	TOLogController *logController;
}

@property (nonatomic, retain) TOLogController *logController;

- (id)initWithLogController:(TOLogController *)controller;

- (void)presentMainController;

@end
