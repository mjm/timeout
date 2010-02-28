//
//  TOAppDelegate.h
//  Timeout
//
//  Created by Matt Moriarity on 2/14/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

@class TOTimerGoalViewController;
@class TOLogController;

@interface TOAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TOTimerGoalViewController *mainViewController;
    
    TOLogController *logController;
    
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property (nonatomic, retain, readonly) TOLogController *logController;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, readonly) NSString *applicationDocumentsDirectory;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) TOTimerGoalViewController *mainViewController;

@end

