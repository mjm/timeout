//
//  TOLogEntry.h
//  Timeout
//
//  Created by Matt Moriarity on 2/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@class TOWorkLog;

#import <Foundation/Foundation.h>

@interface TOLogEntry : NSManagedObject {

}

@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) TOWorkLog * log;

- (NSTimeInterval)timeElapsed;

- (BOOL)isRunning;
- (void)startTimer;
- (void)stopTimer;

@end
