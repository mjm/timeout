//! \file

@class TOLogController;
@class TOWorkLog;

#import "TOLogsViewController.h"

//! Enumeration for the various timer types.
typedef enum {
	TOTimerTypeNone, //!< The user has not selected a timer type.
	TOTimerTypeGoal, //!< The user wants to track by goal.
	TOTimerTypePay   //!< The user wants to track pay.
} TOTimerType;

//! Base class for view controllers that display a timer.
/*!
 
 Handles starting and stopping the timer and the button to view the list of logs.
 Schedules the timer to update the display every second.
 
 \ingroup timer_controllers
 \nosubgrouping
 */
@interface TOTimerViewController : UIViewController <TOLogsViewControllerDelegate> {
	TOWorkLog *log; //!< The log whose information is being displayed.
	TOLogController *logController; //!< The controller used for persistence.
	
	NSTimer *timer; //!< Timer used to update the display.
	NSDateComponents *lastComponents; //!< The most recent time the timer was updated.
	
	IBOutlet UINavigationItem *navigationItem; //!< The navigation item shown in the navigation bar.
	IBOutlet UIButton *startStopButton; //!< The start/stop button.
}

@property (nonatomic, retain) TOWorkLog *log;
@property (nonatomic, retain) TOLogController *logController;

@property (nonatomic, retain) IBOutlet UINavigationItem *navigationItem;
@property (nonatomic, retain) IBOutlet UIButton *startStopButton;

//! \name Initializing a View Controller
//@{

//! Creates a new view controller using a given NIB and persistence controller.
/*!
 Allows subclasses to provide their own NIB for the interface.
 
 \param nibName The NIB file to use for the interface.
 \param controller The controller to use for persistence operations.
 \return the new view controller.
 */
- (id)initWithNibName:(NSString *)nibName logController:(TOLogController *)controller;

//@}
//! \name Updating the View
//@{

//! Updates the display with information about the current log.
/*!
 This is only done when the view appears to the user. It is not updated regularly.
 */
- (void)updateWithLogInfo;

//! Updates the display with up-to-date timer information.
/*!
 This is called every minute when the timer is fired. Subclasses should override this
 to update the timer display. The default implementation will give an error.
 
 \param components The current date when the timer is being updated.
 */
- (void)updateWithDateComponents:(NSDateComponents *)components;

//! Updates the state of the start/stop button to make sure the text and background are correct.
/*!
 \param isStartButton YES if the start button should be displayed, NO if the stop button should
 be displayed.
 */
- (void)setButtonState:(BOOL)isStartButton;

//@}
//! \name Actions
//@{

//! Action called when the user wants to view the list of logs.
- (IBAction)viewLogs;

//! Action called when the user wants to either start or stop the timer.
- (IBAction)startOrStopTimer;

//@}

@end
