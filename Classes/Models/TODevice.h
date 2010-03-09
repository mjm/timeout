//
//  TODevice.h
//  Timeout
//
//  Created by Matt Moriarity on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TORestModel.h"

@interface TODevice : TORestModel {

}

+ (void)registerDeviceWithToken:(NSString *)token;

@end
