//
//  CreateReminderController.h
//  OnMobilePOC
//
//  Created by Manasa Parida on 24/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerViewController.h"

@protocol CreateReminderControllerDelegate

-(void)reminderWasSuccessfullySavedWithData:(NSDictionary*)reminderDetails;

@end

@interface CreateReminderController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, DatePickerViewControllerDelegate>



@property (nonatomic, weak) id<CreateReminderControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *createReminderTable;


- (IBAction)saveReminder:(id)sender;
- (IBAction)cancelReminder:(id)sender;

@end
