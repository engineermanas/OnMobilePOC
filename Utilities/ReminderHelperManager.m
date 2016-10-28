//
//  ReminderHelperManager.m
//  OnMobilePOC
//
//  Created by Manasa Parida on 26/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import "ReminderHelperManager.h"
#import "ReminderConstant.h"
#import <UIKit/UIKit.h>

@implementation ReminderHelperManager

#pragma mark - Singleton Shared Instance
#pragma mark

//+ (instancetype)sharedInstance
//{
//    static dispatch_once_t pred = 0;
//    static ReminderHelperManager *sharedInstance = nil;
//    dispatch_once(&pred, ^{
//        sharedInstance = [[ReminderHelperManager alloc] init];
//        
//    });
//    return sharedInstance;
//}

#pragma mark - Date Conversation Into String and String Into Date
#pragma mark

+ (NSString *)stringFromDateLocalTimeZone:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kDateFormat];
    return [formatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)dateAsString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:kTimeLocale];
    [dateFormatter setLocale:locale];
    [dateFormatter setDateFormat:kDateFormat];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:kTimeZone]];
    return [dateFormatter dateFromString:dateAsString] ;
}

+ (NSInteger)DeviceSystemMajorVersion
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}

// Any Object can be validate from here to return YES or NO
+ (BOOL)dataObjectIsNilwithObject:(id)object
{
    BOOL objectIsNil;
    NSString *objectAsString;
    
    if ([object isKindOfClass:[NSString class]]) {
        
        objectAsString = (NSString *)object;
        
        if (objectAsString == nil || [objectAsString isEqualToString:@""] || objectAsString == (id)[NSNull null]) {
            objectIsNil = YES;
            return objectIsNil;
        }
        else {
            objectIsNil = NO;
            return objectIsNil;
        }
    }
    else {
        if (object == nil || object == (id)[NSNull null]) {
            
            objectIsNil = YES;
            return objectIsNil;
            
        } else {
            
            if (object != nil) {
                objectIsNil = NO;
                return objectIsNil;
            }
            else {
                objectIsNil = YES;
                return objectIsNil;
            }
        }
    }
}


@end
