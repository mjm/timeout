//
//  TORequestOperation.m
//  Timeout
//
//  Created by Matt Moriarity on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TORequestOperation.h"

@interface HRRequestOperation (PrivateMethods)

- (NSMutableURLRequest *)configuredRequest;

@end


@implementation TORequestOperation

- (NSMutableURLRequest *)configuredRequest {
	NSMutableURLRequest *request = [super configuredRequest];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	return request;
}

@end
