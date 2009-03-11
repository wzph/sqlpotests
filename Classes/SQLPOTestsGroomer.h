//
//  SQLPOTestsGroomer.h
//  SQLPOTests
//
//  Created by Zach Holt on 3/9/09.
//  Copyright 2009 ProxyObjects. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface SQLPOTestsGroomer : SQLitePersistentObject {
	NSString *firstName;
	NSString *lastName;
	NSString *companyName;
	NSString *address;
	NSNumber *rate;
}

@property (nonatomic,retain) NSString *firstName;
@property (nonatomic,retain) NSString *lastName;
@property (nonatomic,retain) NSString *companyName;
@property (nonatomic,retain) NSString *address;
@property (nonatomic,retain) NSNumber *rate;

-(NSArray *)pets;
-(NSArray *)customers;
@end
