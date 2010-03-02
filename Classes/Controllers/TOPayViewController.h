//
//  TOPayViewController.h
//  Timeout
//
//  Created by Matt Moriarity on 3/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@protocol TOPayViewControllerDelegate;

@interface TOPayViewController : UIViewController {
	id <TOPayViewControllerDelegate> delegate;
	NSDecimalNumber *rate;
	
	IBOutlet UITextField *rateField;
}

@property (nonatomic, retain) id <TOPayViewControllerDelegate> delegate;
@property (nonatomic, retain) NSDecimalNumber *rate;

@property (nonatomic, retain) UITextField *rateField;

- (id)initWithRate:(NSDecimalNumber *)aRate;

- (IBAction)done;

@end

@protocol TOPayViewControllerDelegate

- (void)payViewController:(TOPayViewController *)controller rateDidChange:(NSDecimalNumber *)rate;

@end

