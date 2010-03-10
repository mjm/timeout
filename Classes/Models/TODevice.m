//
//  TODevice.m
//  Timeout
//
//  Created by Matt Moriarity on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TODevice.h"


@implementation TODevice

+ (void)initialize {
	[self setDelegate:self];
	[self setBaseURL:[NSURL URLWithString:PUSH_PROVIDER_URL]];
}

+ (void)registerDeviceWithToken:(NSString *)token {
	NSDictionary *params = [NSDictionary dictionaryWithObject:token forKey:@"token"];
	NSDictionary *options = [NSDictionary dictionaryWithObject:params forKey:@"body"];
	
	[self postPath:@"/devices.json" withOptions:options object:nil];
}

+ (void)restConnection:(NSURLConnection *)connection didFailWithError:(NSError *)error object:(id)object {
	NSLog(@"Did fail with error: %@, %@", error, [error userInfo]);
}

+ (void)restConnection:(NSURLConnection *)connection didReceiveError:(NSError *)error response:(NSHTTPURLResponse *)response object:(id)object {
	NSLog(@"URL connection: %@", connection);
	NSLog(@"Did receive error: %@, %@", error, [error userInfo]);
}

+ (void)restConnection:(NSURLConnection *)connection didReceiveParseError:(NSError *)error responseBody:(NSString *)string {
	NSLog(@"Did receive parse error: %@, %@", error, [error userInfo]);
}

// Given I've passed the controller as the <tt>object</tt> here, I can call any method I want to on it
// giving it a collection of models I've initialized.
+ (void)restConnection:(NSURLConnection *)connection didReturnResource:(id)resource  object:(id)object {
	NSLog(@"Success: %@", resource);
}

@end
