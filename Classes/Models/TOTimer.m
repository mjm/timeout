#ifndef SKIP_PUSH

#import "TOTimer.h"
#import "TOWorkLog.h"

@implementation TOTimer

+ (void)initialize {
	[self setDelegate:self];
	[self setBaseURL:[NSURL URLWithString:PUSH_PROVIDER_URL]];
}

+ (void)createTimerForLog:(TOWorkLog *)log deviceToken:(NSString *)token {
	if ([log remainingSeconds] == nil) {
		return;
	}
	
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							token, @"token", [[log remainingSeconds] stringValue], @"left", nil];
	NSDictionary *options = [NSDictionary dictionaryWithObject:params forKey:@"body"];
	
	[self postPath:@"/timers.json" withOptions:options object:nil];
}

+ (void)deleteTimerForDeviceToken:(NSString *)token {
	NSDictionary *params = [NSDictionary dictionaryWithObject:token forKey:@"token"];
	NSDictionary *options = [NSDictionary dictionaryWithObject:params forKey:@"params"];
	
	[self deletePath:@"/timers.json" withOptions:options object:nil];
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
+ (void)restConnection:(NSURLConnection *)connection didReturnResource:(id)resource object:(id)object {
	NSLog(@"Success: %@", resource);
}

- (void) dealloc {
    [super dealloc];
}

@end

#endif