//
//  CreateReminderController.m
//  OnMobilePOC
//
//  Created by Manasa Parida on 24/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import "CreateReminderController.h"
#import <EventKit/EventKit.h>
#import "ReminderConstant.h"
#import "ReminderHelperManager.h"
#import "ReminderAlertPopView.h"
#import "ReminderModel.h"
#import "OnMobileCoreDataManager.h"


@interface CreateReminderController ()

@property (nonatomic, strong) NSString *reminderTitle;
@property (nonatomic, strong) NSDate *reminderTime;
@property (nonatomic, strong) NSString *reminderFrequency;
@property (nonnull, strong) NSMutableDictionary *reminderDetailsDict;
@property (nonatomic, strong) NSArray *remindersRepeatOptionArray;
@property (nonatomic) NSUInteger selectedRepeatReminderIndex;
@property (nonatomic, strong) UITextField *reminderTitleTextField;

@end

@implementation CreateReminderController

@synthesize delegate;

#pragma mark - ViewController LifeCycle
#pragma mark

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Set initial values.
    self.reminderDetailsDict = [[NSMutableDictionary alloc] init];
    self.reminderTime = nil;
    self.reminderTitleTextField.delegate = self;
    // Initialize the repeat reminders array.
    self.remindersRepeatOptionArray = kReminderFrequencyArray;
    self.selectedRepeatReminderIndex = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Selection Action
#pragma mark

- (IBAction)saveReminder:(id)sender {
    
    [self.reminderTitleTextField resignFirstResponder];
    self.reminderTitle = self.reminderTitleTextField.text;
    [self.reminderDetailsDict setObject:self.reminderTitleTextField.text forKey:kReminderTitle];
    
    if ([self isCorrectUserInput]) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            [self saveInCoreData:self.reminderDetailsDict WithCompletionBlock:^(BOOL response) {
                
                if (response) {
                    
                    if ([delegate respondsToSelector:@selector(reminderWasSuccessfullySavedWithData:)]) {
                        
                        [delegate reminderWasSuccessfullySavedWithData:self.reminderDetailsDict];
                        dispatch_async(dispatch_get_main_queue(), ^{
                        
                            [self popViewController];
                        });
                    }
                }
            }];
        });
    }
}

- (void)saveInCoreData:(NSDictionary*)dictData WithCompletionBlock:(void (^)(bool response))completionBlock{
    // Once User Save the Reinder Details Then Save into CoreData
    [[OnMobileCoreDataManager sharedInstance] saveReminderDetails:dictData withCompletionBlock:completionBlock];
}

- (BOOL)isCorrectUserInput {
    
    if ([ReminderHelperManager dataObjectIsNilwithObject:self.reminderDetailsDict]) {
        
        [[ReminderAlertPopView sharedInstance] showAlertToUserWithView:self WithAlertTitle:kOOPS WithAlertMessage:kCreateYourReminder];
        return NO;
        
    } else if ([ReminderHelperManager dataObjectIsNilwithObject:self.reminderTitle]) {
        
        [[ReminderAlertPopView sharedInstance] showAlertToUserWithView:self WithAlertTitle:kReminderAleart WithAlertMessage:kEmptyTitle];
        return NO;
        
    } else if ([ReminderHelperManager dataObjectIsNilwithObject:self.reminderTime]) {
        
        [[ReminderAlertPopView sharedInstance] showAlertToUserWithView:self WithAlertTitle:kReminderAleart WithAlertMessage:kEmptyTime];
        return NO;
        
    } else if ([self.reminderFrequency isEqualToString:kNone] || [ReminderHelperManager dataObjectIsNilwithObject:self.reminderFrequency]) {
        
        [[ReminderAlertPopView sharedInstance] showAlertToUserWithView:self WithAlertTitle:kReminderAleart WithAlertMessage:kEmptyReminder];
        return NO;
        
    } else {
        
        [self.reminderDetailsDict setObject:kYES forKey:kReminderStartTime];
        return YES;
    }
}

- (IBAction)cancelReminder:(id)sender {
    
    [self popViewController];
}

- (void) popViewController {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - DatePicker Selection Method Delegate
#pragma mark

-(void)dateWasSelected:(NSDate *)selectedDate {
    
    // Based on the selected cell, specify what the selected date is purposed for.
    NSIndexPath *indexPath = [self.createReminderTable indexPathForSelectedRow];
    
    if (indexPath.section == 0) {
        // In this case, it's either the event start or end date.
        if (indexPath.row == 1) {
            
            // The event start date.
            self.reminderTime = selectedDate;
            [self.reminderDetailsDict setObject:[ReminderHelperManager stringFromDateLocalTimeZone:self.reminderTime] forKey:kReminderTime];
        }
    }

    // Reload the table view.
    [self.createReminderTable reloadData];
}

#pragma mark - Navigation Segue
#pragma mark

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:kSegueDatepickerID]) {
        DatePickerViewController *datePickerViewController = [segue destinationViewController];
        datePickerViewController.delegate = self;
    }
}

#pragma mark - UITableView Datasource
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 2;
    }
    else {
        
        return self.remindersRepeatOptionArray.count;
    }
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return kReminderTableSection1;
    }
    else {
        
        return kReminderTableSection2;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = nil;
    UIFont *myFont = [ UIFont fontWithName:kFontNameArial size: 18.0 ];
    
    if (indexPath.section == 0) {
        // If the cell is nil, then dequeue it. Make sure to dequeue the proper cell based on the row.
        if (cell == nil) {
            if (indexPath.row == 0) {
                cell = [tableView dequeueReusableCellWithIdentifier:kReminderTitleCell];
            }
            else{
                cell = [tableView dequeueReusableCellWithIdentifier:kReminderGeneralCell];
            }
            cell.textLabel.font  = myFont;
        }
        
        switch (indexPath.row) {
            case 0:
                
                // The title of the reminder.
            {
                self.reminderTitleTextField = (UITextField *)[cell.contentView viewWithTag:10];
                self.reminderTitleTextField.delegate = self;
                self.reminderTitle = self.reminderTitleTextField.text;
                self.reminderTitleTextField.font = myFont;
            }
                break;
                
            case 1:
                
                // The reminder start time.
                if (self.reminderTime == nil) {
                    cell.textLabel.text = kReminderStartTime;
                }
                else{
                    
                    cell.textLabel.text = [ReminderHelperManager stringFromDateLocalTimeZone:self.reminderTime];
                }
                break;
            default:
                break;
        }
    }
    else{
        if (cell == nil) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:kReminderGeneralCell];
        }
        
        // The section with the repeat options.
        cell.textLabel.text = [self.remindersRepeatOptionArray objectAtIndex:indexPath.row];
        
        if (indexPath.row == self.selectedRepeatReminderIndex) {
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        cell.textLabel.font  = myFont;
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0;
}

#pragma mark - UITableView Delegate
#pragma mark

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        [self performSegueWithIdentifier:kSegueDatepickerID sender:self];
    }
    
    if (indexPath.section == 1) {
        
        self.selectedRepeatReminderIndex = indexPath.row;
        self.reminderFrequency = [self.remindersRepeatOptionArray objectAtIndex:self.selectedRepeatReminderIndex];
        [self.reminderDetailsDict setObject:self.reminderFrequency forKey:kReminderFrequency];
        [self.createReminderTable reloadData];
    }
}

#pragma mark - UITextFieldDelegate method implementation
#pragma mark

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [self.reminderTitleTextField resignFirstResponder];
    return NO;
}

@end
