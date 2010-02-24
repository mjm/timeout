//
//  TOLogDetailViewController.h
//  Timeout
//
//  Created by Matt Moriarity on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TOWorkLog;

@interface TOLogDetailViewController : UITableViewController {
	TOWorkLog *log;
}

@property (nonatomic, retain) TOWorkLog *log;

- (id)initWithLog:(TOWorkLog *)log;

@end
