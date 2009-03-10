//
//  SQLPOTestsPerson.h
//  SQLPOTests
//
//  Created by Zach Holt on 3/9/09.
//  Copyright 2009 ProxyObjects. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface SQLPOTestsPerson : SQLitePersistentObject {
	NSString *firstName;
	NSString *lastName;
	NSDate *birthday;
}
@property (nonatomic,retain) NSString *firstName;
@property (nonatomic,retain) NSString *lastName;
@property (nonatomic,retain) NSDate *birthday;

@end
