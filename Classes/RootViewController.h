//
//  RootViewController.h
//  SQLPOTests
//
//  Created by Zach Holt on 3/9/09.
//  Copyright ProxyObjects 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BACK_TABLE_WITH_AN_ARRAY_OF_OBJECTS 0
#define BACK_TABLE_WITH_PAIRED_ARRAYS    1
#define BACK_TABLE_WITH_AN_OBJECT_AT_A_TIME 2


@interface RootViewController : UITableViewController {
	NSUInteger tableBacking;
	NSMutableArray *stuffToDisplay;
}
@property (nonatomic) NSUInteger tableBacking;
@property (nonatomic, retain) NSMutableArray *stuffToDisplay;

-(IBAction)handleTableBackingChange:(id)sender;

@end
