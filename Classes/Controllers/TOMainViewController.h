@class TOLogController;

#import "TOTimerTypeController.h"

//! The main view controller that is initially added to the window.
/*!
 
 This view controller shows nothing of value in its view. Its main purpose is to delegate to
 other view controllers.
 
 */
@interface TOMainViewController : UIViewController <TOTimerTypeControllerDelegate> {
	TOLogController *logController; //!< The controller used for persistence.
}

@property (nonatomic, retain) TOLogController *logController;

//! Creates a new view controller with a persistence controller.
/*!
 \param controller The controller used for persistence.
 */
- (id)initWithLogController:(TOLogController *)controller;

//! Displays the appropriate view controller modally.
- (void)presentMainController;

@end
