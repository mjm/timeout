@class TOLogEntry;

//! View controller that allows the user to edit the details of a log entry.
/*!
 \nosubgrouping
 \ingroup nav_controllers
 */
@interface TOEntryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	TOLogEntry *entry; //!< The entry being edited by this controller.
	
	//! \name Outlets
	//@{
	
	IBOutlet UITableView *tableView; //!< The table view used to display the editing controls.
	IBOutlet UIDatePicker *datePicker; //!< Date picker for selecting the start and end times.
	
	//@}
}

@property (nonatomic, retain) TOLogEntry *entry;

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;

//! Creates a new controller that will edit a certain entry.
/*!
 \param anEntry The entry that the controller will edit.
 \return a new view controller.
 */
- (id)initWithEntry:(TOLogEntry *)anEntry;

//! \name Actions
//@{

//! Action called when the user changes the selected date with the date picker.
- (IBAction)dateChanged;

//@}

@end
