//
//  TOLogDetailViewController.m
//  Timeout
//
//  Created by Matt Moriarity on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TOLogDetailViewController.h"

#import "../Models/TOWorkLog.h"
#import "../Models/TOLogEntry.h"

#import "TOEntryViewController.h"
#import "TOLogController.h"

@implementation TOLogDetailViewController

@synthesize logController, log;
@synthesize editButton, doneButton;

- (id)initWithLog:(TOWorkLog *)aLog logController:(TOLogController *)controller {
	if (![super initWithNibName:@"TOLogDetailViewController" bundle:nil])
		return nil;
	
	self.logController = controller;
	self.log = aLog;
	self.title = aLog.title;
	return self;
}


- (void)viewDidLoad {
	[super viewDidLoad];

    self.navigationItem.rightBarButtonItem = self.editButton;
}


- (void)viewWillAppear:(BOOL)animated {
	NSManagedObjectContext *context = [self.log managedObjectContext];
	[context refreshObject:self.log mergeChanges:YES];
	
	[self.tableView reloadData];

	[super viewWillAppear:animated];
}

- (IBAction)edit {
	[self.tableView setEditing:YES animated:YES];
	self.navigationItem.rightBarButtonItem = self.doneButton;
}

- (IBAction)done {
	[self.tableView setEditing:NO animated:YES];
	self.navigationItem.rightBarButtonItem = self.editButton;
}

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
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.editButton = nil;
	self.doneButton = nil;
	[super viewDidUnload];
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.log.orderedEntries count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	TOLogEntry *entry = [self.log.orderedEntries objectAtIndex:indexPath.row];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.timeStyle = NSDateFormatterShortStyle;
	
	NSString *start = [formatter stringFromDate:entry.startTime];
	NSString *end = entry.endTime ? [formatter stringFromDate:entry.endTime] : @"Now";
	cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", start, end];
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	[formatter release];
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	TOLogEntry *entry = [self.log.orderedEntries objectAtIndex:indexPath.row];
	
	TOEntryViewController *controller = [[TOEntryViewController alloc] initWithEntry:entry];
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}


- (void) tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		TOLogEntry *entry = [self.log.orderedEntries objectAtIndex:indexPath.row];
		[self.logController deleteEntry:entry fromLog:self.log];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)dealloc {
	self.log = nil;
	self.logController = nil;
    [super dealloc];
}


@end

