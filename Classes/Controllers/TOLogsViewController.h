@class TOLogController;
@class TOLogsViewController;

//! Protocol for delegates of TOLogsViewController.
/*!
 
 Allows the controller to notify an object when the user has finished with it.
 
 */
@protocol TOLogsViewControllerDelegate

//! Called when the user is finished manipulating logs.
/*!
 \param controller The controller that is finished.
 */
- (void)logsViewControllerDidFinish:(TOLogsViewController *)controller;

@end


//! View controller for displaying and editing the user's logs.
/*!
 
 Displays a table view with a list of all the user's logs ordered from most recent to least recent.
 Allows the user to delete logs or drill down into a specific log. Also has a button to switch back
 to the timer view.
 
 */
@interface TOLogsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate> {
	id <TOLogsViewControllerDelegate> delegate; //!< Delegate object for the controller.
	TOLogController *logController; //!< The persistence controller for the application.
	NSFetchedResultsController *fetchedResultsController; //!< The fetched results controller for displaying the results.
	
	IBOutlet UITableView *tableView; //!< The table view displaying the data.
	IBOutlet UIBarButtonItem *doneButton; //!< Button pressed when the user wants to switch to the timer view.
	IBOutlet UIBarButtonItem *editButton; //!< Button pressed when the user wants to delete logs.
	IBOutlet UIBarButtonItem *cancelButton; //!< Button pressed when the user is done deleting logs.
}

@property (nonatomic, assign) id <TOLogsViewControllerDelegate> delegate;
@property (nonatomic, retain) TOLogController *logController;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *editButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *cancelButton;

//! Creates a new controller with a log controller for persistence.
/*!
 \param controller The log controller for handling persistence operations.
 \return a new view controller.
 */
- (id)initWithLogController:(TOLogController *)controller;

//! Action called when the user wants to switch to the timer view.
- (IBAction)done;

//! Action called when the user wants to delete logs.
- (IBAction)edit;

//! Action called when the user is done deleting logs.
- (IBAction)cancel;

@end
