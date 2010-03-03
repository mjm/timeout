//
//  TFLogsViewController.h
//  Timeout
//
//  Created by Matt Moriarity on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TOLogController;

@class TOLogsViewController;

@protocol TOLogsViewControllerDelegate
- (void)logsViewControllerDidFinish:(TOLogsViewController *)controller;
@end


@interface TOLogsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate> {
	id <TOLogsViewControllerDelegate> delegate;
	TOLogController *logController;
	NSFetchedResultsController *fetchedResultsController;
	
	IBOutlet UITableView *tableView;
	IBOutlet UIBarButtonItem *doneButton;
	IBOutlet UIBarButtonItem *editButton;
	IBOutlet UIBarButtonItem *cancelButton;
}

@property (nonatomic, assign) id <TOLogsViewControllerDelegate> delegate;
@property (nonatomic, retain) TOLogController *logController;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIBarButtonItem *doneButton;
@property (nonatomic, retain) UIBarButtonItem *editButton;
@property (nonatomic, retain) UIBarButtonItem *cancelButton;

- (id)initWithLogController:(TOLogController *)controller;

- (IBAction)done;
- (IBAction)edit;
- (IBAction)cancel;

@end
