//
//  TOLogDetailViewController.h
//  Timeout
//
//  Created by Matt Moriarity on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TOWorkLog;
@class TOLogController;

@interface TOLogDetailViewController : UITableViewController {
	TOWorkLog *log;
	TOLogController *logController;
	
	IBOutlet UIBarButtonItem *editButton;
	IBOutlet UIBarButtonItem *doneButton;
}

@property (nonatomic, retain) TOLogController *logController;
@property (nonatomic, retain) TOWorkLog *log;

- (id)initWithLog:(TOWorkLog *)log logController:(TOLogController *)controller;

- (IBAction)edit;
- (IBAction)done;

@end
