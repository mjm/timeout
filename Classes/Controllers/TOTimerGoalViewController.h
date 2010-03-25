@class TOLogController;

#import "TOTimerViewController.h"
#import "TOGoalViewController.h"

//! Timer view controller for users who are tracking their time by goal.
/*!
 
 Displays three labels for departure time, time remaining, and time elapsed.
 
 \nosubgrouping
 \ingroup timer_controllers
 */
@interface TOTimerGoalViewController : TOTimerViewController <TOGoalViewControllerDelegate> {
	//! \name Outlets
	//@{
	
    IBOutlet UILabel *departureLabel; //!< Label for departure time.
    IBOutlet UILabel *elapsedLabel; //!< Label for time elapsed.
    IBOutlet UILabel *leftLabel; //!< Label for time remaining.
	
	//@}
}

@property (nonatomic, retain) IBOutlet UILabel *departureLabel;
@property (nonatomic, retain) IBOutlet UILabel *elapsedLabel;
@property (nonatomic, retain) IBOutlet UILabel *leftLabel;

//! \name Initializing a View Controller
//@{

//! Creates a new controller with a log controller for persistence.
/*!
 \param controller The log controller to use for handling persistence operations.
 \return the new view controller.
 */
- (id)initWithLogController:(TOLogController *)controller;

//@}
//! \name Actions
//@{

//! Called when the user wants to change their goal time.
- (IBAction)changeGoal;

//@}

@end
