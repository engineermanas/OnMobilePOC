//
//  ReminderModel.h
//  OnMobilePOC
//
//  Created by Manasa Parida on 28/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReminderModel : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * frequency;
@property (nonatomic, strong) NSDate * time;
@property (assign) BOOL isReminderStartTime;

@end
