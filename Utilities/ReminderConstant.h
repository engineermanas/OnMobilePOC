//
//  ReminderConstant.h
//  OnMobilePOC
//
//  Created by Manasa Parida on 25/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import "ReminderHelperManager.h"

#define IS_iOS7 ([ReminderHelperManager DeviceSystemMajorVersion] == 7)

#define  kCellBackgroundColor [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]

// CoreData Related
#define kOnMobileSqliteFileName     @"OnMobile.sqlite"
#define kOnMobileMOMDName           @"OnMobilePOC"
#define kOnMobileMOMDExt            @"momd"
#define kOnMobileEntityName         @"Reminder"
#define kTitlePredicate             @"title == %@"

#define kTableCellHeight 100
#define kDateFormat     @"yyyy-MM-dd HH:mm"
#define kTimeLocale     @"en_US_POSIX"
#define kTimeZone       @"UTC"
#define kReminderFormat @"%@ Reminder"
#define kRepeatFor      @"Repeat for every : %@"

// FontStyle

#define  kFontNameHelvetica       @"Helvetica"
#define  kFontNameArial           @"Arial"

// Reminder List View Title Name

#define kCreateReminder   @"Create Reminder"
#define kReminderList      @"Reminder List"

// Custom Table Cell Frame

#define kReminderTitleFrame         boundsX + 10, 05 ,300, 30
#define kReminderTimeFrame          boundsX + 10, 40 ,300, 25
#define kReminderFrequencyFrame     boundsX + 10, 70 ,200, 20
#define kReminderStartStopFrame     boundsX + 300,35 ,50, 30

// Reminder Data Model KeyValue Keys

#define kNillString              @""
#define kYES                     @"YES"
#define kReminderTitle           @"ReminderTitle"
#define kReminderStartTime       @"ReminderStartTime"
#define kReminderTime            @"ReminderTime"
#define kReminderFrequency       @"ReminderFrequency"

// Reminder Frequency Array

#define kReminderFrequencyArray  @[@"None", @"Minutes", @"Hourly", @"Daily", @"Weekly", @"Monthly", @"Yearly"]

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


// AlertView Relatd Macro

#define  kOOPS                @"OOPS!"
#define  kAlertTitle          @"Thank You"
#define  kAlertActionOK       @"Ok"
#define  kNone                @"None"
#define  kCreateYourReminder  @"Create Your Remider"
#define  kReminderAleart      @"Reminder!"
#define  kEmptyTitle          @"Title has not been defined"
#define  kEmptyTime           @"Time has not been defined"
#define  kEmptyReminder       @"Reminder has not been defined"





