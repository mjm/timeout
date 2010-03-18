@protocol TOGoalViewControllerDelegate;
@class TOWorkLog;

//! View controller allowing the user to select the goal time for the day.
/*!
 
 Presents the user with a date picker so that the user can select how much time they intend
 to work for the day. Calls to a delegate when the user is done changing the goal.
 
 */
@interface TOGoalViewController : UIViewController {
    id <TOGoalViewControllerDelegate> delegate; //!< Delegate for this controller.
    TOWorkLog *log; //!< The log whose goal is being changed.
    
    IBOutlet UIDatePicker *datePicker; //!< The date picker for selecting the goal.
}

@property (nonatomic, assign) id <TOGoalViewControllerDelegate> delegate;
@property (nonatomic, retain) TOWorkLog *log;

@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;

//! Creates a new controller for editing a log.
/*!
 \param log The log to be edited.
 \return the new view controller.
 */
- (id)initWithLog:(TOWorkLog *)log;

//! Action called when the user hits the "Done" button.
- (IBAction)done;

@end

//! Protocol for delegates of TOGoalViewController.
/*!
 
 Allows the controller to notify an object when the user has finished with it.
 
 */
@protocol TOGoalViewControllerDelegate

//! Called when the user has finished selecting their goal time.
/*!
 When this method is called, the log's new goal has already been set. When this method is called,
 the delegate should at a minimum stop displaying the goal view.
 
 \param controller The view controller that finished displaying.
 */
- (void)goalViewControllerDidFinish:(TOGoalViewController *)controller;

@end