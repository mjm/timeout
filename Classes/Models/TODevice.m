#ifndef SKIP_PUSH

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

+ (void)restConnection:(NSURLConnection *)connection didReturnResource:(id)resource  object:(id)object {
	NSLog(@"Success: %@", resource);
}

@end

#endif