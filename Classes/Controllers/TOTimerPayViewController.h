@class TOLogController;

#import "TOTimerViewController.h"
#import "TOPayViewController.h"

//! Timer view controller for users who are tracking their pay.
/*!
 
 Displays three labels for time elapsed, start time, and earned pay.
 
 */
@interface TOTimerPayViewController : TOTimerViewController <TOPayViewControllerDelegate> {
	IBOutlet UILabel *elapsedLabel; //!< Label to display time elapsed.
	IBOutlet UILabel *startLabel; //!< Label to display the start time for the running entry.
	IBOutlet UILabel *earnedLabel; //!< Label to display the pay earned for the day.
}

@property (nonatomic, retain) IBOutlet UILabel *elapsedLabel;
@property (nonatomic, retain) IBOutlet UILabel *startLabel;
@property (nonatomic, retain) IBOutlet UILabel *earnedLabel;

//! Creates a new view controller with a persistence controller.
/*!
 \param controller The controller to use for persistence operations.
 \return the new view controller.
 */
- (id)initWithLogController:(TOLogController *)controller;

//! Action called when the user wants to change their pay rate for the day.
- (IBAction)changeRate;

@end
