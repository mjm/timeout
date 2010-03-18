#import "TORestModel.h"

//! A registered device on the push notification provider server.
@interface TODevice : TORestModel {
}

//! Notifies the push provider that a device with the given token exists.
/*!
 This call returns immediately; the communication with the server occurs asynchronously.
 
 \param token The device token to register.
 */
+ (void)registerDeviceWithToken:(NSString *)token;

@end
