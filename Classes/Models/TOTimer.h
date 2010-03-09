//
//  TOTimer.h
//  Timeout
//
//  Created by Matt Moriarity on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TORestModel.h"

@class TOWorkLog;
@protocol TOTimerDelegate;

@interface TOTimer : TORestModel {
	NSNumber *timerId;
}

@property (nonatomic, retain) NSNumber *timerId;

- (id)initWithDictionary:(NSDictionary *)values;

+ (void)createTimerForLog:(TOWorkLog *)log deviceToken:(NSString *)token delegate:(id <TOTimerDelegate>)delegate;
+ (void)deleteTimerForDeviceToken:(NSString *)token;

@end

@protocol TOTimerDelegate 

- (void)timerCreated:(TOTimer *)timer;

@end