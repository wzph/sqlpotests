//
//  SQLPOTestsPet.h
//  SQLPOTests
//
//  Created by Zach Holt on 3/9/09.
//  Copyright 2009 ProxyObjects. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@class SQLPOTestsPerson;
@class SQLPOTestsGroomer;

@interface SQLPOTestsPet : SQLitePersistentObject {
	NSString *breed;
	NSString *name;
	NSString *allergies;
	NSNumber *haircut;
	NSDate *lastVisit;
	NSDate *birthday;
	SQLPOTestsPerson *owner;
	SQLPOTestsGroomer *groomer;
}
@property (nonatomic,retain) NSString *breed;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *allergies;
@property (nonatomic,retain) NSNumber *haircut;
@property (nonatomic,retain) NSDate *lastVisit;
@property (nonatomic,retain) NSDate *birthday;
@property (nonatomic,retain) SQLPOTestsPerson *owner;
@property (nonatomic,retain) SQLPOTestsGroomer *groomer;

@end
