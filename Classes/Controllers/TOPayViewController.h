@protocol TOPayViewControllerDelegate;

//! View controller allowing the user to change their pay rate for the day.
/*!
 
 Presents a text field where the user can enter their new pay rate. Calls to a delegate
 when the user is finished changing their rate.
 
 \nosubgrouping
 \ingroup modal_controllers
 */
@interface TOPayViewController : UIViewController {
	id <TOPayViewControllerDelegate> delegate; //!< Delegate for this controller.
	NSDecimalNumber *rate; //!< The current rate as set by the user.
	
	//! \name Outlets
	//@{
	
	IBOutlet UITextField *rateField; //!< The text field for the pay rate.
	
	//@}
}

@property (nonatomic, retain) id <TOPayViewControllerDelegate> delegate;
@property (nonatomic, retain) NSDecimalNumber *rate;
@property (nonatomic, retain) IBOutlet UITextField *rateField;

//! Creates a view controller with the rate already filled in.
/*!
 \param aRate The rate that should be filled into the text field.
 \return the new view controller.
 */
- (id)initWithRate:(NSDecimalNumber *)aRate;

//! \name Actions
//@{

//! Action called when the user is done changing their pay rate.
- (IBAction)done;

//@}

@end

//! Protocol for delegates of TOPayViewController.
/*!
 
 Allows the controller to notify an object when the user is finished changing the pay rate.
 
 */
@protocol TOPayViewControllerDelegate

//! Called when the user is finished changing the pay rate.
/*!
 It is the delegate's responsibility to update the log with the new pay rate.
 
 \param controller The controller that is finished.
 \param rate The new rate chosen by the user.
 */
- (void)payViewController:(TOPayViewController *)controller rateDidChange:(NSDecimalNumber *)rate;

@end

