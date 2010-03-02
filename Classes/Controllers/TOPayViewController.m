//
//  TOPayViewController.m
//  Timeout
//
//  Created by Matt Moriarity on 3/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TOPayViewController.h"

@implementation TOPayViewController

@synthesize delegate, rate, rateField;

- (id)initWithRate:(NSDecimalNumber *)aRate {
	if (![super initWithNibName:@"TOPayViewController" bundle:nil])
		return nil;
	
	self.rate = aRate;
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	formatter.numberStyle = NSNumberFormatterCurrencyStyle;
	[formatter setCurrencySymbol:@""];
	self.rateField.text = [formatter stringFromNumber:self.rate];
	
	[formatter release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.rateField = nil;
}

- (IBAction)done {
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	formatter.numberStyle = NSNumberFormatterCurrencyStyle;
	formatter.generatesDecimalNumbers = YES;
	formatter.currencySymbol = @"";
	[formatter setLenient:YES];
	
	NSDecimalNumber *number = (NSDecimalNumber *) [formatter numberFromString:self.rateField.text];
	[self.delegate payViewController:self rateDidChange:number];
}

- (void)dealloc {
	self.rate = nil;
    [super dealloc];
}


@end
