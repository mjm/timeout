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

@synthesize delegate, logController, logs, tableView;

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
	self.navigationItem.leftBarButtonItem = doneButton;
	
	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.tableView = nil;
}

- (IBAction)done {
	[self.delegate logsViewControllerDidFinish:self];
}

#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	TOWorkLog *log = [self.logs objectAtIndex:indexPath.row];
	
	TOLogDetailViewController *controller = [[TOLogDetailViewController alloc] initWithLog:log];
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
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


- (void)dealloc {
	self.logController = nil;
	self.logs = nil;
    [super dealloc];
}


@end
