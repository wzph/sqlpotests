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

#define GROOMER_NAME_LABEL_TAG 3
#define PET_COUNT_LABEL_TAG 4
#define CUSTOMER_COUNT_LABEL_TAG 5

#define GROOMER_NAME_LABEL_FRAME CGRectMake( 10.0,  10.0,  280.0, 15.0 )
#define PET_COUNT_LABEL_FRAME CGRectMake( 10.0,  30.0,  50.0, 15.0 )
#define CUSTOMER_COUNT_LABEL_FRAME CGRectMake( 80.0,  30.0,  200.0, 15.0 )

#define ROW_HEIGHT 50.0;

@interface RootViewController : UITableViewController {
	NSUInteger tableBacking;
	NSMutableArray *stuffToDisplay;
}
@property (nonatomic) NSUInteger tableBacking;
@property (nonatomic, retain) NSMutableArray *stuffToDisplay;

-(IBAction)handleTableBackingChange:(id)sender;

@end
