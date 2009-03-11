//
//  SQLPOTestsGroomer.m
//  SQLPOTests
//
//  Created by Zach Holt on 3/9/09.
//  Copyright 2009 ProxyObjects. All rights reserved.
//

#import "SQLPOTestsGroomer.h"
#import "SQLPOTestsPet.h"

@implementation SQLPOTestsGroomer
@synthesize firstName;
@synthesize lastName;
@synthesize companyName;
@synthesize address;
@synthesize rate;

-(NSArray *)pets {
	return [self findRelated:[SQLPOTestsPet class] forProperty:@"groomer" filter:nil];
}

-(NSArray *)customers {
	NSArray *p = [self pets];
	NSMutableArray *customers = [NSMutableArray arrayWithCapacity:[p count]];

	for ( SQLPOTestsPet *pet in p ) {
		[customers addObject:pet.owner];
	}
	return customers;
}

@end
