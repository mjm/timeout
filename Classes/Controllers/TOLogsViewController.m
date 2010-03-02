//
//  TFLogsViewController.m
//  Timeout
//
//  Created by Matt Moriarity on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TOLogsViewController.h"
#import "TOLogController.h"
#import "TOLogDetailViewController.h"

#import "../Models/TOWorkLog.h"

@implementation TOLogsViewController

@synthesize delegate, logController, logs;
@synthesize tableView, doneButton, editButton, cancelButton;

- (id)initWithLogController:(TOLogController *)controller {
	if (![super initWithNibName:@"TOLogsViewController" bundle:nil])
		return nil;
	
	self.logController = controller;
	self.title = @"Logs";
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.logs = [self.logController logs];
	self.navigationItem.leftBarButtonItem = self.doneButton;
	self.navigationItem.rightBarButtonItem = self.editButton;
	
	[self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
	[super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.tableView = nil;
	self.doneButton = nil;
	self.editButton = nil;
	self.cancelButton = nil;
}

- (IBAction)done {
	[self.delegate logsViewControllerDidFinish:self];
}

- (IBAction)edit {
	[self.tableView setEditing:YES animated:YES];
	self.navigationItem.rightBarButtonItem = self.cancelButton;
}

- (IBAction)cancel {
	[self.tableView setEditing:NO animated:YES];
	self.navigationItem.rightBarButtonItem = self.editButton;
}

#pragma mark Table view delegate

- (void)tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	TOWorkLog *log = [self.logs objectAtIndex:indexPath.row];
	
	TOLogDetailViewController *controller = [[TOLogDetailViewController alloc] initWithLog:log
																			 logController:self.logController];
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
	
	[table deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.logs count];
}

- (UITableViewCell *)tableView:(UITableView *)table
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	TOWorkLog *log = [self.logs objectAtIndex:indexPath.row];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateStyle = NSDateFormatterLongStyle;
	
	cell.textLabel.text = [formatter stringFromDate:log.day];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	[formatter release];
	return cell;
}

- (void) tableView:(UITableView *)table
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[self.logController deleteLog:[self.logs objectAtIndex:indexPath.row]];
		self.logs = [self.logController logs];
		[table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}


- (void)dealloc {
	self.logController = nil;
	self.logs = nil;
    [super dealloc];
}


@end
