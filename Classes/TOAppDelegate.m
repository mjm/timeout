//
//  TOAppDelegate.m
//  Timeout
//
//  Created by Matt Moriarity on 2/14/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>

#import "TOAppDelegate.h"
#import "Controllers/TOMainViewController.h"
#import "Controllers/TOLogController.h"

#ifndef SKIP_PUSH
#import "Models/TODevice.h"
#endif

@interface TOAppDelegate ()

- (void)stopTimer;

@end

@implementation TOAppDelegate

@synthesize deviceToken;
@synthesize window, mainViewController;

#pragma mark -
#pragma mark Application Lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)options {
	id notification = [options objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
	if (notification) {
		[self stopTimer];
	}
	
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
	
	TOMainViewController *aController = [[TOMainViewController alloc] initWithLogController:self.logController];
	self.mainViewController = aController;
	[aController release];
	
    mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	[window addSubview:[mainViewController view]];
    [window makeKeyAndVisible];
	
	[aController presentMainController];
	
	return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // TODO handle error
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
	if (notification.fireDate) {
		[self stopTimer];
	}
}

#pragma mark -
#pragma mark Push notifications

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
#ifndef SKIP_PUSH
	NSString *tokenDesc = [devToken description];
	self.deviceToken = [tokenDesc substringWithRange:NSMakeRange(1, [tokenDesc length] - 2)];
	[TODevice registerDeviceWithToken:self.deviceToken];
#endif
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	NSLog(@"registering error, %@, %@", error, [error userInfo]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	NSLog(@"received notification: %@", userInfo);
	
	// TODO play an alert sound
	SystemSoundID soundId = kSystemSoundID_Vibrate;
	
	NSDictionary *apsInfo = [userInfo valueForKey:@"aps"];
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Timeout"
														message:[apsInfo valueForKey:@"alert"]
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
	[alertView show];
	AudioServicesPlayAlertSound(soundId);
	
	[alertView release];
}

#pragma mark -
#pragma mark Application Logic

- (TOLogController *)logController {
    if (logController != nil) {
        return logController;
    }
    
    logController = [[TOLogController alloc] initWithManagedObjectContext:self.managedObjectContext];
    return logController;
}

- (void)stopTimer {
	TOWorkLog *log = [self.logController currentLog];
	TOLogEntry *entry = [self.logController runningEntryForLog:log];
	if ([entry isRunning]) {
		[entry stopTimer];
	}
}

#pragma mark -
#pragma mark Core Data

- (NSManagedObjectContext *)managedObjectContext {
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"coredata.sqlite"]];
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
							 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
							 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: self.managedObjectModel];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return persistentStoreCoordinator;
}

#pragma mark -
#pragma mark Miscellaneous

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];

    [mainViewController release];
    [window release];
    [super dealloc];
}

@end
