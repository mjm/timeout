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

@end


@implementation TOLogController

@synthesize managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context {
	if (![super init])
		return nil;
	
	self.managedObjectContext = context;
	
	NSEntityDescription *entity = [self logEntityDescription];
	NSPropertyDescription *property = [[entity propertiesByName] valueForKey:@"orderedEntries"];
	NSFetchRequest *fetchRequest = [(NSFetchedPropertyDescription *)property fetchRequest];
	
	NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:YES];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
	[sort release];
	
	return self;
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
            TOWorkLog *log = [NSEntityDescription
                insertNewObjectForEntityForName:@"Log"
                inManagedObjectContext:self.managedObjectContext];
            log.day = date;
            
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
        TOLogEntry *entry = [NSEntityDescription
            insertNewObjectForEntityForName:@"Entry"
            inManagedObjectContext:self.managedObjectContext];
        entry.log = log;
        
        [self save];
        
        NSLog(@"Entry: %@", entry);
        return entry;
    }
}

- (NSArray *)logs {
	NSFetchRequest *request = [[self managedObjectModel] fetchRequestTemplateForName:@"logs"];
	[request setFetchBatchSize:10];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"day" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	NSError *error;
	NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
	
	if (!results) {
		NSLog(@"Error fetching logs: %@, %@", error, [error userInfo]);
	}
	
	return results;
}


- (void)save {
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error saving the context: %@, %@", error, [error userInfo]);
    }
}

@end
