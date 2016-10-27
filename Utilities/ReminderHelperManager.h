//
//  ReminderHelperManager.h
//  OnMobilePOC
//
//  Created by Manasa Parida on 26/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReminderHelperManager : NSObject

+ (NSInteger)DeviceSystemMajorVersion;

//+ (instancetype)sharedInstance;
+ (NSString *)stringFromDateLocalTimeZone:(NSDate *)date;
+ (NSDate *)dateFromString:(NSString *)dateAsString;

// Object Validation
+ (BOOL)dataObjectIsNilwithObject:(id)object;

@end
