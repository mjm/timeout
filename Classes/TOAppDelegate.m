//
//  TOAppDelegate.m
//  Timeout
//
//  Created by Matt Moriarity on 2/14/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "TOAppDelegate.h"
#import "TOTimerGoalViewController.h"
#import "TOLogController.h"

@interface TOAppDelegate (PrivateMethods)

- (TOTimerType)preferredTimerType;

@end

@implementation TOAppDelegate

@synthesize window, mainViewController;

#pragma mark -
#pragma mark Application Lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	TOTimerType timerType = [self preferredTimerType];

	TOTimerGoalViewController *aController = [[TOTimerGoalViewController alloc] initWithLogController:self.logController];
	self.mainViewController = aController;
	[aController release];
	
    mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	[window addSubview:[mainViewController view]];
    [window makeKeyAndVisible];
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

#pragma mark -
#pragma mark User preferences

- (TOTimerType)preferredTimerType {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	TOTimerType timerType = [userDefaults integerForKey:@"TOTimerType"];
	return timerType;
}

#pragma mark -
#pragma mark Application Controllers

- (TOLogController *)logController {
    if (logController != nil) {
        return logController;
    }
    
    logController = [[TOLogController alloc] initWithManagedObjectContext:self.managedObjectContext];
    return logController;
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
    
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: self.managedObjectModel];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
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
