//
//  OnMobileLocalNotificationManager.m
//  OnMobilePOC
//
//  Created by Manasa Parida on 03/11/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import "OnMobileLocalNotificationManager.h"
#import "ReminderHelperManager.h"
#import "ReminderConstant.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>


@implementation OnMobileLocalNotificationManager

#pragma mark - Singleton Shared Instance
#pragma mark

+ (instancetype)sharedInstance
{
    static dispatch_once_t pred = 0;
    static OnMobileLocalNotificationManager *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[OnMobileLocalNotificationManager alloc] init];
        
    });
    return sharedInstance;
}

-(void)scheduleLocalNotificationWithData:(NSDictionary*)reminderDetails {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [ReminderHelperManager dateFromString:[reminderDetails objectForKey:kReminderTime]];
    localNotification.timeZone = [NSTimeZone timeZoneWithAbbreviation:kTimeZone];
    localNotification.alertBody = [reminderDetails objectForKey:kReminderTitle];
    localNotification.alertAction = @"Details";
    localNotification.userInfo =  reminderDetails;
    localNotification.repeatInterval = [self getCalenderUnitWithUserSelectedReminderInterval:[reminderDetails objectForKey:kReminderFrequency]];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

}

-(void)cancelLocalNotificationWithData:(NSDictionary*)reminderDetails {
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSArray * scheduledReminderArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"Notification Details==>>%@",scheduledReminderArray);
}

- (NSCalendarUnit)getCalenderUnitWithUserSelectedReminderInterval:(NSString*)selectedInterval {
    
    if ([selectedInterval isEqualToString:@"Minutes"])
        return NSCalendarUnitMinute;
    else if ([selectedInterval isEqualToString:@"Hourly"])
        return NSCalendarUnitHour;
    else if ([selectedInterval isEqualToString:@"Daily"])
        return NSCalendarUnitDay;
    else if ([selectedInterval isEqualToString:@"Weekly"])
        return NSCalendarUnitWeekday;
    else if ([selectedInterval isEqualToString:@"Monthly"])
        return NSCalendarUnitMonth;
    else if ([selectedInterval isEqualToString:@"Yearly"])
        return NSCalendarUnitYear;
    else
        return 0;
}

@end

