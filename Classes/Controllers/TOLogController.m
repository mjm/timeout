//
//  TOLogController.m
//  Timeout
//
//  Created by Matt Moriarity on 2/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TOLogController.h"
#import "TOWorkLog.h"
#import "TOLogEntry.h"

@interface TOLogController (PrivateMethods)

- (NSEntityDescription *)logEntityDescription;
- (NSManagedObjectModel *)managedObjectModel;
- (NSDate *)today;

- (void)addSortDescriptorToOrderedEntries;

@end


@implementation TOLogController

@synthesize managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context {
	if (![super init])
		return nil;
	
	self.managedObjectContext = context;
	
	[self addSortDescriptorToOrderedEntries];
	[self deleteOldLogs];
	
	return self;
}

- (void)addSortDescriptorToOrderedEntries {
	NSEntityDescription *entity = [self logEntityDescription];
	NSPropertyDescription *property = [[entity propertiesByName] valueForKey:@"orderedEntries"];
	NSFetchRequest *fetchRequest = [(NSFetchedPropertyDescription *)property fetchRequest];
	
	NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:YES];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
	[sort release];
}

+ (void)initialize {
	NSDictionary *defaults = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSNumber numberWithInteger:28800], @"TOLastGoal",
							  [NSNumber numberWithInteger:0], @"TOLastRate",
							  [NSNumber numberWithInteger:0], @"TODeleteAfter", nil];
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults registerDefaults:defaults];
}

- (NSEntityDescription *)logEntityDescription {
    NSManagedObjectContext *moc = self.managedObjectContext;
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"Log"
                                            inManagedObjectContext:moc];
    return desc;
}

- (NSManagedObjectModel *)managedObjectModel {
    return self.managedObjectContext.persistentStoreCoordinator.managedObjectModel;
}

- (NSDate *)today {
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSUInteger units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:date];
    
    return [calendar dateFromComponents:components];
}

- (TOWorkLog *)currentLog {
    NSDate *date = [self today];

    NSFetchRequest *request = [[self managedObjectModel]
        fetchRequestFromTemplateWithName:@"currentLog"
        substitutionVariables:[NSDictionary dictionaryWithObject:date forKey:@"TODAY"]];
    
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (array == nil) {
        NSLog(@"Error retrieving current log: %@, %@", error, [error userInfo]);
        return nil;
    } else {
        int count = [array count];
        
        if (count > 0) {
            return [array objectAtIndex:0];
        } else {
			NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
			
            TOWorkLog *log = [NSEntityDescription insertNewObjectForEntityForName:@"Log"
														   inManagedObjectContext:self.managedObjectContext];
            log.day = date;
			log.goal = [userDefaults objectForKey:@"TOLastGoal"];
			log.rate = [NSDecimalNumber decimalNumberWithDecimal:[[userDefaults objectForKey:@"TOLastRate"] decimalValue]];
            
            [self save];
            
            return log;
        }
    }
}

- (TOLogEntry *)runningEntryForLog:(TOWorkLog *)log {
    [self.managedObjectContext refreshObject:log mergeChanges:YES];
    
    NSArray *entries = log.runningEntry;
    int count = [entries count];
    if (count > 0) {
        return [entries objectAtIndex:0];
    } else {
        TOLogEntry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry"
														  inManagedObjectContext:self.managedObjectContext];
        entry.log = log;
        [self save];
        
        return entry;
    }
}

- (NSFetchedResultsController *)logsFetchedResultsController {
	NSFetchRequest *request = [[self managedObjectModel] fetchRequestTemplateForName:@"logs"];
	[request setFetchBatchSize:10];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"day" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	return [[[NSFetchedResultsController alloc] initWithFetchRequest:request
											    managedObjectContext:self.managedObjectContext
												  sectionNameKeyPath:nil
														   cacheName:nil] autorelease];
}

- (void)deleteLog:(TOWorkLog *)log {
	[self.managedObjectContext deleteObject:log];
	[self save];
}

- (void)deleteEntry:(TOLogEntry *)entry fromLog:(TOWorkLog *)log {
	[self.managedObjectContext deleteObject:entry];
	[self.managedObjectContext refreshObject:log mergeChanges:YES];
	[self save];
}

- (void)deleteOldLogs {
	NSInteger days = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TODeleteAfter"] integerValue];
	if (days == 0) {
		// 0 actually means never delete old logs.
		return;
	}
	
	NSDate *today = [self today];
	NSDateComponents *offset = [[NSDateComponents alloc] init];
	[offset setDay:-days];
	NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:offset toDate:today options:0];
	[offset release];
	
	NSFetchRequest *request = [[self managedObjectModel]
							   fetchRequestFromTemplateWithName:@"oldLogs"
										  substitutionVariables:[NSDictionary dictionaryWithObject:date forKey:@"DATE"]];
	
	NSError *error;
	NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (results == nil) {
		NSLog(@"Error deleting old logs: %@, %@", error, [error userInfo]);
	} else {
		for (TOWorkLog *log in results) {
			// don't use [self deleteLog:log] because it would save on every iteration.
			[self.managedObjectContext deleteObject:log];
		}
		[self save];
	}
}


- (void)save {
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error saving the context: %@, %@", error, [error userInfo]);
    }
}

@end
