//
//  OnMobileLocalNotificationManager.h
//  OnMobilePOC
//
//  Created by Manasa Parida on 03/11/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OnMobileLocalNotificationManager : NSObject

+ (instancetype)sharedInstance;

-(void)scheduleLocalNotificationWithData:(NSDictionary *)reminderDetails;
-(void)cancelLocalNotificationWithData:(id)notifications;

@end
