//
//  RootViewController.m
//  SQLPOTests
//
//  Created by Zach Holt on 3/9/09.
//  Copyright ProxyObjects 2009. All rights reserved.
//

#import "RootViewController.h"
#import "SQLPOTestsAppDelegate.h"
#import "SQLPOTestsPet.h"
#import "SQLPOTestsGroomer.h"
#import "SQLPOTestsPerson.h"

@implementation RootViewController
@synthesize tableBacking;
@synthesize stuffToDisplay;

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/


- (void)viewWillAppear:(BOOL)animated {
	[self handleTableBackingChange:self];
    [super viewWillAppear:animated];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//	switch ( self.tableBacking ) {
//		case BACK_TABLE_WITH_PAIRED_ARRAYS:
//			return 1;
//			break;
//		case BACK_TABLE_WITH_AN_OBJECT_AT_A_TIME:
//			return 1;
//			break;
//		default:
			return 1;
//			break;
//	}
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch ( self.tableBacking ) {
		case BACK_TABLE_WITH_PAIRED_ARRAYS:
			if ( [self.stuffToDisplay respondsToSelector:@selector( objectAtIndex: )] ) {
				if ( [[self.stuffToDisplay objectAtIndex:0] respondsToSelector:@selector( count )] ) {
					return [[self.stuffToDisplay objectAtIndex:0] count];
				}
				else {
					return 1;
				}
			}
			else {
				return 1;
			}
			break;
		case BACK_TABLE_WITH_AN_OBJECT_AT_A_TIME:
			return [SQLPOTestsGroomer count];
			break;
		default:
			return [self.stuffToDisplay count];
			break;
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"GroomerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];

		UILabel *groomerNameLabel = [[UILabel alloc] initWithFrame:GROOMER_NAME_LABEL_FRAME];
		groomerNameLabel.tag = GROOMER_NAME_LABEL_TAG;
		groomerNameLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
		
		UILabel *petCountLabel = [[UILabel alloc] initWithFrame:PET_COUNT_LABEL_FRAME];
		petCountLabel.tag = PET_COUNT_LABEL_TAG;
		petCountLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];

		UILabel *customerCountLabel = [[UILabel alloc] initWithFrame:CUSTOMER_COUNT_LABEL_FRAME];
		customerCountLabel.tag = CUSTOMER_COUNT_LABEL_TAG;
		customerCountLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
		
		[cell addSubview:groomerNameLabel];
		[cell addSubview:petCountLabel];
		[cell addSubview:customerCountLabel];
		
		[groomerNameLabel autorelease];
		[petCountLabel autorelease];
		[customerCountLabel autorelease];

    }
    
    // Set up the cell...
	if ( self.tableBacking == BACK_TABLE_WITH_PAIRED_ARRAYS ) {
		((UILabel*)[cell viewWithTag:GROOMER_NAME_LABEL_TAG]).text = [[self.stuffToDisplay objectAtIndex:0] objectAtIndex:indexPath.row];
//		((UILabel*)[cell viewWithTag:PET_COUNT_LABEL_TAG]).text = [NSString stringWithFormat:@"%d pets", [[groomer pets] count]];
//		((UILabel*)[cell viewWithTag:CUSTOMER_COUNT_LABEL_TAG]).text = [NSString stringWithFormat:@"1st customer: %@", [[[groomer customers] objectAtIndex:0] lastName]];
	}
	else if ( self.tableBacking == BACK_TABLE_WITH_AN_OBJECT_AT_A_TIME ) {
		SQLPOTestsGroomer *groomer = [[SQLPOTestsGroomer findByCriteria:[NSString stringWithFormat:@"ORDER BY company_name ASC LIMIT 1 OFFSET %d", indexPath.row]] objectAtIndex:0];
		((UILabel*)[cell viewWithTag:GROOMER_NAME_LABEL_TAG]).text = groomer.companyName;
		((UILabel*)[cell viewWithTag:PET_COUNT_LABEL_TAG]).text = [NSString stringWithFormat:@"%d pets", [[groomer pets] count]];
		((UILabel*)[cell viewWithTag:CUSTOMER_COUNT_LABEL_TAG]).text = [NSString stringWithFormat:@"1st customer: %@", [[[groomer customers] objectAtIndex:0] lastName]];
	}
	else {
		SQLPOTestsGroomer *groomer = (SQLPOTestsGroomer *)[self.stuffToDisplay objectAtIndex:indexPath.row];
		((UILabel*)[cell viewWithTag:GROOMER_NAME_LABEL_TAG]).text = groomer.companyName;
		((UILabel*)[cell viewWithTag:PET_COUNT_LABEL_TAG]).text = [NSString stringWithFormat:@"%d pets", [[groomer pets] count]];
		((UILabel*)[cell viewWithTag:CUSTOMER_COUNT_LABEL_TAG]).text = [NSString stringWithFormat:@"1st customer: %@", [[[groomer customers] objectAtIndex:0] lastName]];
	}
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return ROW_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
	[stuffToDisplay release];
    [super dealloc];
}

-(IBAction)handleTableBackingChange:(id)sender {
	NSLog( @"Dropping stuffToDisplay" );
	self.stuffToDisplay = nil;

	if ( sender == self ) {
		self.tableBacking = BACK_TABLE_WITH_AN_ARRAY_OF_OBJECTS;
	}
	else {
		self.tableBacking = [(UISegmentedControl *)sender selectedSegmentIndex];
	}

	if ( self.tableBacking == BACK_TABLE_WITH_AN_ARRAY_OF_OBJECTS ) {
		NSLog( @"Reloading stuffToDisplay (objects)" );
		self.stuffToDisplay = [SQLPOTestsGroomer findByCriteria:@"ORDER BY company_name ASC"];
	}
	else if ( self.tableBacking == BACK_TABLE_WITH_PAIRED_ARRAYS ) {
		NSLog( @"Reloading stuffToDisplay (pairedArrays)" );
		NSArray *names = [SQLPOTestsGroomer pairedArraysForProperties:[NSArray arrayWithObjects:@"companyName", nil] ];
		NSArray *petCounts = [SQLPOTestsGroomer pairedArraysForProperties:[NSArray arrayWithObjects:@"companyName", nil] withCriteria:@"INNER JOIN s_q_l_p_o_tests_pet ON s_q_l_p_o_tests_pet.groomer = 'SQLPOTestsGroomer-'||s_q_l_p_o_tests_groomer.pk" ];
//		NSArray *customerCounts = [SQLPOTestsGroomer pairedArraysForProperties:[NSArray arrayWithObjects:@"companyName", nil] withCriteria:@"INNER JOIN s_q_l_p_o_tests_pet ON s_q_l_p_o_tests_pet.groomer = 'SQLPOTestsGroomer-'||s_q_l_p_o_tests_groomer.pk" ];

		self.stuffToDisplay = [NSArray arrayWithObjects:[names objectAtIndex:0], [names objectAtIndex:1], nil];
		
//		for( NSArray *array in self.stuffToDisplay ) {
		for( id thing in self.stuffToDisplay ) {
			NSLog( @"Got a %@", [thing className] );
//			for ( id thing in array ) {
//				NSLog( @"Got a %@", [thing className] );
//			}
		}
	}
	
	[(UITableView *)self.view reloadData];
}

@end

