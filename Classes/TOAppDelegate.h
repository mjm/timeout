@class TOMainViewController;
@class TOLogController;

//! Timeout's application delegate.
/*!
 
 Controls the lifecycle of the application and creates things needed for the entire application.
 It loads the first view controller, handles push notifications, and creates the Core Data stack.
 
 */
@interface TOAppDelegate : NSObject <UIApplicationDelegate> {
    IBOutlet UIWindow *window; //!< The main window of the application.
    TOMainViewController *mainViewController; //!< The main view controller.
    
    TOLogController *logController; //!< The application's persistence controller.
	NSString *deviceToken; //!< The token for the device running the application.
    
    NSManagedObjectModel *managedObjectModel; //!< Core Data managed object model.
    NSManagedObjectContext *managedObjectContext; //!< Core Data managed object context.
    NSPersistentStoreCoordinator *persistentStoreCoordinator; //!< Core Data persistent store coordinator.
}

@property (nonatomic, retain, readonly) TOLogController *logController;
@property (nonatomic, retain) NSString *deviceToken;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//! Location of the application's documents directory for storing data.
@property (nonatomic, readonly) NSString *applicationDocumentsDirectory;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) TOMainViewController *mainViewController;

@end

