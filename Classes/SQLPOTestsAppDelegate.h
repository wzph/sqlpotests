//
//  SQLPOTestsAppDelegate.h
//  SQLPOTests
//
//  Created by Zach Holt on 3/9/09.
//  Copyright ProxyObjects 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQLPOTestsAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

