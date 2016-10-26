//
//  Reminder.h
//  OnMobilePOC
//
//  Created by Manasa Parida on 26/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Reminder :NSManagedObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * frequency;
@property (nonatomic, strong) NSDate * time;
@property (readwrite,atomic) BOOL isValid;


@end