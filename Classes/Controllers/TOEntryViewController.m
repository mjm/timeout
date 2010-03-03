//
//  TOEntryViewController.m
//  Timeout
//
//  Created by Matt Moriarity on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TOEntryViewController.h"

#import "TOLogEntry.h"

@implementation TOEntryViewController

@synthesize entry, tableView, datePicker;

- (id)initWithEntry:(TOLogEntry *)anEntry {
	if (![super initWithNibName:@"TOEntryViewController" bundle:nil])
		return nil;
	
	self.entry = anEntry;
	self.title = @"Edit Entry";
	return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView reloadData];
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	[self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
	[self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/

- (void)viewDidDisappear:(BOOL)animated {
	NSManagedObjectContext *context = self.entry.managedObjectContext;
	NSError *error;
	
	if (![context save:&error]) {
		NSLog(@"Error saving: %@, %@", error, [error userInfo]);
	}
	
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.tableView = nil;
	self.datePicker = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	static NSString *kSectionTitle = @"Entry Times";
	
	return kSectionTitle;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)table
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.timeStyle = NSDateFormatterShortStyle;
    
    if (indexPath.row == 0) {
		cell.textLabel.text = @"Start Time";
		cell.detailTextLabel.text = [formatter stringFromDate:self.entry.startTime];
	} else {
		cell.textLabel.text = @"End Time";
		if (self.entry.endTime) {
			cell.detailTextLabel.text = [formatter stringFromDate:self.entry.endTime];
		} else {
			cell.detailTextLabel.text = nil;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
	}
	
	[formatter release];
	
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)table
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 1 && self.entry.endTime == nil) {
		return nil;
	}
	return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		self.datePicker.date = self.entry.startTime;
		self.datePicker.maximumDate = self.entry.endTime;
		self.datePicker.minimumDate = nil;
	} else {
		self.datePicker.date = self.entry.endTime;
		self.datePicker.minimumDate = self.entry.startTime;
		self.datePicker.maximumDate = nil;
	}
}

- (IBAction)dateChanged {
	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.timeStyle = NSDateFormatterShortStyle;
	
	NSDate *date = self.datePicker.date;
	cell.detailTextLabel.text = [formatter stringFromDate:date];
	
	if (indexPath.row == 0) {
		self.entry.startTime = date;
	} else {
		self.entry.endTime = date;
	}
	
	[formatter release];
}


- (void)dealloc {
	self.entry = nil;
    [super dealloc];
}


@end

