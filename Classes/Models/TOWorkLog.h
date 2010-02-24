//
//  TOWorkLog.h
//  Timeout
//
//  Created by Matt Moriarity on 2/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class TOLogEntry;

#import <Foundation/Foundation.h>

@interface TOWorkLog : NSManagedObject {

}

@property (nonatomic, readonly) NSString *title;

@property (nonatomic, retain) NSDate * day;
@property (nonatomic, retain) NSNumber * goal;
@property (nonatomic, retain) NSSet* entries;
@property (nonatomic, retain) NSArray* runningEntry;
@property (nonatomic, retain) NSArray* orderedEntries;

//- (void)addEntriesObject:(TOLogEntry *)value;
//- (void)removeEntriesObject:(TOLogEntry *)value;
//- (void)addEntries:(NSSet *)value;
//- (void)removeEntries:(NSSet *)value;


- (NSDateComponents *)timeElapsed;
- (NSDateComponents *)timeLeft;
- (NSDate *)estimatedDepartureFromDate:(NSDate *)date;

@end
