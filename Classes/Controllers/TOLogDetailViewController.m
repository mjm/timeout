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

@implementation TOLogDetailViewController

@synthesize log;

- (id)initWithLog:(TOWorkLog *)aLog {
	if (![super initWithNibName:@"TOLogDetailViewController" bundle:nil])
		return nil;
	
	self.log = aLog;
	self.title = aLog.title;
	return self;
}


- (void)viewDidLoad {
	[super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
	NSManagedObjectContext *context = [self.log managedObjectContext];
	[context refreshObject:self.log mergeChanges:YES];
	
	[self.tableView reloadData];

	[super viewWillAppear:animated];
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}


@end

