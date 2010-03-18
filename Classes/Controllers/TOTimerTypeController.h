@class TOTimerTypeController;

//! Protocol for delegates of TOTimerTypeController
/*!
 
 Allows the controller to notify an object when the user has finished with it.
 
 */
@protocol TOTimerTypeControllerDelegate

//! Called when the user has finished selecting their timer type.
/*!
 When this method is called, the user default key "TOTimerType" contains the user's selected
 timer type, so the delegate can now hide the controller and display the proper one for the
 chosen type.
 
 \param controller The controller that has finished.
 */
- (void)timerTypeControllerDidFinish:(TOTimerTypeController *)controller;

@end

//! View controller to let the user choose how they want to track their time.
/*!
 
 This view is displayed on the first launch of the application when the user has not
 chosen how the timer type they wish to use. It explains the two options and allows the
 user to select one.
 
 */
@interface TOTimerTypeController : UIViewController {
	id <TOTimerTypeControllerDelegate> delegate; //!< Delegate for this controller.
	
	IBOutlet UIButton *goalButton; //!< Button pressed if the user chooses to track by goal.
	IBOutlet UIButton *payButton; //!< Button pressed if the user chooses to track pay.
}

@property (nonatomic, assign) id <TOTimerTypeControllerDelegate> delegate;

@property (nonatomic, retain) IBOutlet UIButton *goalButton;
@property (nonatomic, retain) IBOutlet UIButton *payButton;

//! Creates a new view controller.
/*!
 \return a new view controller.
 */
- (id)init;

//! Action called when the user chooses to track by goal.
- (IBAction)selectGoal;

//! Action called when the user chooses to track pay.
- (IBAction)selectPay;

@end
