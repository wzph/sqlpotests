//
//  SQLPOTestsPerson.m
//  SQLPOTests
//
//  Created by Zach Holt on 3/9/09.
//  Copyright 2009 ProxyObjects. All rights reserved.
//

#import "SQLPOTestsPerson.h"
#import "SQLPOTestsPet.h"

@implementation SQLPOTestsPerson
@synthesize firstName;
@synthesize lastName;
@synthesize birthday;


-(NSArray *)pets {
	return [self findRelated:[SQLPOTestsPet class] forProperty:@"owner" filter:nil];
}

@end
