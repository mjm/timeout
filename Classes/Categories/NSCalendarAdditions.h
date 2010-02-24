//
//  NSCalendarAdditions.h
//  Timeout
//
//  Created by Matt Moriarity on 2/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSCalendar (Additions)

- (NSDateComponents *)components:(NSUInteger)units fromInterval:(NSTimeInterval)interval;

- (NSTimeInterval)intervalFromComponents:(NSDateComponents *)components;

@end
