@class TOWorkLog;
@class TOLogEntry;

//! Controller for managing the object model of the application.
/*!
 
 Handles retrieving and manipulating logs and entries for the application.
 Also provides a convenient method for saving any changes.
 
 \ingroup controllers
 */
@interface TOLogController : NSObject {
    NSManagedObjectContext *managedObjectContext; //! The Core Data managed object context.
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

//! Creates a new controller with a managed object context.
/*!
 \param context The application's Core Data managed object context.
 \return the new log controller.
 */
- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

//! Retrieves the log for the current day, creating it if it does not exist.
/*!
 If the log doesn't already exist, a new one is created. Its day is set to the current date.
 Its goal is set to the value of the "TOLastGoal" user default. Its rate is set to the value
 of the "TOLastRate" user default.
 
 If a new log must be created, the managed object context is saved once it is created.
 
 \return a work log.
 */
- (TOWorkLog *)currentLog;

//! Retrieves the currently running log entry for the given log.
/*!
 The running entry is one which does not have an end time. There should only ever be at most
 one of these entries for any given log. If no such entry exists, one will be created and
 associated with the given log.
 
 If a new entry must be created, the managed object context is saved once it is created.
 
 \param log The log whose entry should be retrieved.
 \return a log entry.
 */
- (TOLogEntry *)runningEntryForLog:(TOWorkLog *)log;

//! Creates a new fetched results controller for the user's work logs.
/*!
 The controller will display the entries ordered by date.
 
 \return a new fetched results controller.
 */
- (NSFetchedResultsController *)logsFetchedResultsController;


//! Deletes a log from the application.
/*!
 \param log The log to delete.
 */
- (void)deleteLog:(TOWorkLog *)log;

//! Deletes an entry from a log.
/*!
 Refreshes the log after deletion so that the fetched property for the entries is up-to-date.
 
 \param entry The entry to delete.
 \param log The log to delete it from.
 */
- (void)deleteEntry:(TOLogEntry *)entry fromLog:(TOWorkLog *)log;

//! Deletes any old logs from the application.
/*!
 Deletes logs if they are older than a certain number of days. The number of days is determined
 a user preference. The default behavior is to never delete logs.
 */
- (void)deleteOldLogs;

//! Saves any unsaved changes to the managed object context.
- (void)save;

@end
