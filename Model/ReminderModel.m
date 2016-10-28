//
//  ReminderModel.m
//  OnMobilePOC
//
//  Created by Manasa Parida on 28/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import "ReminderModel.h"

@implementation ReminderModel

- (id)init
{
    self = [super init];
    
    if (self) {
        
        // Initialization code here.
        self.title = nil;
        self.time = nil;
        self.frequency = nil;
        self.isReminderStartTime = nil;
    }
    
    return self;
}
@end
