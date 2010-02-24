//
//  TOLogController.h
//  Timeout
//
//  Created by Matt Moriarity on 2/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class TOWorkLog;
@class TOLogEntry;

#import <Foundation/Foundation.h>


@interface TOLogController : NSObject {
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

- (TOWorkLog *)currentLog;
- (TOLogEntry *)runningEntryForLog:(TOWorkLog *)log;
- (NSArray *)logs;

- (void)save;

@end
