//
//  TOEntryViewController.h
//  Timeout
//
//  Created by Matt Moriarity on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TOLogEntry;

@interface TOEntryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	TOLogEntry *entry;
	
	IBOutlet UITableView *tableView;
	IBOutlet UIDatePicker *datePicker;
}

@property (nonatomic, retain) TOLogEntry *entry;

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIDatePicker *datePicker;

- (id)initWithEntry:(TOLogEntry *)anEntry;

- (IBAction)dateChanged;

@end
