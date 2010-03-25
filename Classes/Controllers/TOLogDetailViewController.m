#import "TOLogDetailViewController.h"

#import "../Models/TOWorkLog.h"
#import "../Models/TOLogEntry.h"

#import "TOEntryViewController.h"
#import "TOLogController.h"
#import "TOTimerViewController.h"

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

- (void)viewDidAppear:(BOOL)animated {
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
	[super viewDidAppear:animated];
}

- (IBAction)edit {
	[self.tableView setEditing:YES animated:YES];
	self.navigationItem.rightBarButtonItem = self.doneButton;
}

- (IBAction)done {
	[self.tableView setEditing:NO animated:YES];
	self.navigationItem.rightBarButtonItem = self.editButton;
}

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
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		TOTimerType timerType = [[NSUserDefaults standardUserDefaults] integerForKey:@"TOTimerType"];
		return (timerType == TOTimerTypeGoal) ? 1 : 2;
	}
    return [self.log.orderedEntries count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 1)
		return @"Entries";
	return nil;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	static NSString *HeaderIdentifier = @"Header";
	
	if (indexPath.section == 0) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:HeaderIdentifier] autorelease];
		}
		
		switch (indexPath.row) {
			case 0:
				cell.textLabel.text = @"Hours Worked";
				
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
				dateFormatter.dateFormat = @"H:mm:ss";
				cell.detailTextLabel.text = [dateFormatter stringFromDate:[[NSCalendar currentCalendar]
																		   dateFromComponents:[self.log timeElapsed]]];
				[dateFormatter release];
				
				break;
			case 1:
				cell.textLabel.text = @"Earned Pay";
				
				NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
				numFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
				cell.detailTextLabel.text = [numFormatter stringFromNumber:[self.log earnedPay]];
				[numFormatter release];
				
				break;
		}
		
		return cell;
	}
    
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


- (NSIndexPath *)tableView:(UITableView *)table willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		return nil;
	}
	
	return indexPath;
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)table editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		return UITableViewCellEditingStyleNone;
	}
	
	return UITableViewCellEditingStyleDelete;
}


- (void)dealloc {
	self.log = nil;
	self.logController = nil;
    [super dealloc];
}


@end

