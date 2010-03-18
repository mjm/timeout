@class TOWorkLog;
@class TOLogController;

//! View controller to display details of a specific log.
/*!
 
 Displays information about a single log. Shows either the hours worked or the pay earned,
 depending on how the user has chosen to track their timer. Shows a list of the entries in
 the log.
 
 */
@interface TOLogDetailViewController : UITableViewController {
	TOWorkLog *log; //!< The log being displayed by this controller.
	TOLogController *logController; //!< The persistence controller.
	
	IBOutlet UIBarButtonItem *editButton; //!< Button pressed when the user wants to delete entries.
	IBOutlet UIBarButtonItem *doneButton; //!< Button pressed when the user is done deleting entries.
}

@property (nonatomic, retain) TOLogController *logController;
@property (nonatomic, retain) TOWorkLog *log;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *editButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;

//! Creates a new view controller with a log to display and a persistence controller.
/*!
 \param log The log whose details will be displayed.
 \param controller The controller to use for persistence operations.
 \return a new view controller.
 */
- (id)initWithLog:(TOWorkLog *)log logController:(TOLogController *)controller;

//! Action called when the user wants to delete entries from the log.
- (IBAction)edit;

//! Action called when the user wants to stop deleting entries from the log.
- (IBAction)done;

@end
