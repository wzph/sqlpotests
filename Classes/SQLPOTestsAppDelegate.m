//
//  SQLPOTestsAppDelegate.m
//  SQLPOTests
//
//  Created by Zach Holt on 3/9/09.
//  Copyright ProxyObjects 2009. All rights reserved.
//

#import "SQLPOTestsAppDelegate.h"
#import "RootViewController.h"

#import "SQLPOTestsPet.h"
#import "SQLPOTestsPerson.h"
#import "SQLPOTestsGroomer.h"
#import "SQLiteInstanceManager.h"

@implementation SQLPOTestsAppDelegate

@synthesize window;
@synthesize navigationController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];

	NSString *resourceDatabasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"sqlpotests.sqlite3"];
	NSString *documentsDatabasePath = [[SQLiteInstanceManager sharedManager] databaseFilepath];

	NSError *error;
	if ( [[NSFileManager defaultManager] fileExistsAtPath:resourceDatabasePath] ) {
		if ( [[NSFileManager defaultManager] fileExistsAtPath:documentsDatabasePath] ) {
			NSLog( @"Deleting existing database" );
			if ( ! [[NSFileManager defaultManager] removeItemAtPath:documentsDatabasePath error:&error] ) {
				NSLog( @"Could not delete existing database (%@): '%@'", documentsDatabasePath, [error localizedDescription] );
			}
		}
		NSLog( @"Copying database from bundle to Documents" );
		if ( ! [[NSFileManager defaultManager] copyItemAtPath:resourceDatabasePath toPath:documentsDatabasePath error:&error] ) {
			NSLog( @"Could not copy database from bundle (%d) to Documents (%@): '%@'", resourceDatabasePath, documentsDatabasePath, [error localizedDescription] );
		}
	}
	else {
		NSLog( @"No database found in the bundle.  Creating three new entries." );

		SQLPOTestsPerson *person = [[SQLPOTestsPerson alloc] init];
		person.firstName = @"Steve";
		[person save];
		NSLog( @"person.pk = %d", person.pk );
		
		SQLPOTestsGroomer *groomer = [[SQLPOTestsGroomer alloc] init];
		groomer.firstName = @"Hezekiah";
		[groomer save];
		NSLog( @"groomer.pk = %d", groomer.pk );
		
		SQLPOTestsPet *pet = [[SQLPOTestsPet alloc] init];
		pet.name = @"Scruffy";
		pet.groomer = groomer;
		pet.owner = person;
		[pet save];
		NSLog( @"pet.pk = %d", pet.pk );
	}
	NSLog( @"databaseFilepath: %@", [[SQLiteInstanceManager sharedManager] databaseFilepath] );
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];	
	[window release];
	[super dealloc];
}



@end
