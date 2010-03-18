#import "TORequestOperation.h"

//! Declarations of overriden private methods.
@interface HRRequestOperation (PrivateMethods)

//! The URL request that will be used to make the request.
- (NSMutableURLRequest *)configuredRequest;

@end


@implementation TORequestOperation

- (NSMutableURLRequest *)configuredRequest {
	NSMutableURLRequest *request = [super configuredRequest];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	return request;
}

@end
