//
//  TOTimerPayViewController.h
//  Timeout
//
//  Created by Matt Moriarity on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class TOLogController;

#import "TOTimerViewController.h"
#import "TOPayViewController.h"

@interface TOTimerPayViewController : TOTimerViewController <TOPayViewControllerDelegate> {
	IBOutlet UILabel *elapsedLabel;
	IBOutlet UILabel *startLabel;
	IBOutlet UILabel *earnedLabel;
}

@property (nonatomic, retain) UILabel *elapsedLabel;
@property (nonatomic, retain) UILabel *startLabel;
@property (nonatomic, retain) UILabel *earnedLabel;

- (id)initWithLogController:(TOLogController *)controller;

- (IBAction)changeRate;

@end
