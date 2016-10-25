//
//  ReminderConstant.h
//  OnMobilePOC
//
//  Created by Manasa Parida on 25/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//


#define  kCellBackgroundColor [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]

#define kTableCellHeight 100
#define kDateFormat     @"yyyy-MM-dd HH:mm"
#define kTimeLocale     @"en_US_POSIX"
#define kTimeZone       @"UTC"
#define kReminderFormat @"%@ Reminder"

// FontStyle

#define  kFontNameHelvetica       @"Helvetica"
#define  kFontNameArial           @"Arial"

// Reminder List View Title Name

#define kCreateRemibnder   @"Create Reminder"
#define kReminderList      @"Reminder List"

// Custom Table Cell Frame

#define kReminderTitleFrame         boundsX + 10, 05 ,300, 30
#define kReminderTimeFrame          boundsX + 10, 40 ,300, 25
#define kReminderFrequencyFrame     boundsX + 10, 70 ,200, 20
#define kReminderStartStopFrame     boundsX + 300,35 ,50, 30

// Reminder Data Model KeyValue Keys

#define kNillString              @""
#define kReminderTitle           @"ReminderTitle"
#define kReminderStartTime       @"Reminder start time"
#define kReminderTime            @"ReminderTime"
#define kReminderFrequency       @"ReminderFrequency"

// Reminder Frequency Array

#define kReminderFrequencyArray  @[@"Minutes", @"Hourly", @"Daily", @"Weekly", @"Monthly", @"Yearly"]

// StoryBord SegueID

#define kSegueDatepickerID          @"idSegueDatepicker"
#define kSegueCreateReminderID      @"idSegueCreateReminder"

// Crete Reminder Table Cell Data
#define  kReminderTableSection1  @"Reminder Title"
#define  kReminderTableSection2  @"Reminder Frequency"

// Table Cell Identifier

#define  kReminderGeneralCell    @"idCellGeneral"
#define  kReminderTitleCell      @"idCellTitle"
#define  kReminderTableListCell  @"ReminderTableCellIdentifier"
