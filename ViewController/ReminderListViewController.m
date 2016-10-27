//
//  ReminderListViewController.m
//  OnMobilePOC
//
//  Created by Manasa Parida on 24/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import "ReminderListViewController.h"
#import "CreateReminderController.h"
#import "ReminderTableViewCell.h"
#import "ReminderConstant.h"
#import "OnMobileCoreDataManager.h"
#import "Reminder.h"
#import "ReminderHelperManager.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>


@interface ReminderListViewController ()

@property (nonatomic, strong) NSMutableArray *reminderListArray;
@property (assign) BOOL isReminderON;


@end

@implementation ReminderListViewController


#pragma mark - ViewController LifeCycle
#pragma mark

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // By Default Reminder is set to YES
    self.isReminderON = YES;
    self.reminderListArray = [[NSMutableArray alloc] initWithArray:[[OnMobileCoreDataManager sharedInstance] getReminderDetails]];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self viewTitleName];
    [self.reminderListTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Datasource
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.reminderListArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kTableCellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Cell indentifie Instance
    static NSString *CellIdentifier = kReminderTableListCell;
    
    // Customizable Cell Instance which is going to use as ReusableCell
    ReminderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[ReminderTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // Cell background color
        cell.backgroundColor = kCellBackgroundColor;
    }
    
    // Get Cell Index All Value
    Reminder *reminder = [self.reminderListArray objectAtIndex:indexPath.row];
    cell.reminderTitle.text = reminder.title;
    cell.reminderTime.text = [ReminderHelperManager stringFromDateLocalTimeZone:reminder.time];
    cell.reminderFrequency.text = reminder.frequency;
    cell.reminderStartStopSwitch.selected = reminder.isValid;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // If your source is an NSMutableArray do this
        [self.reminderListArray removeObjectAtIndex:indexPath.row];
        
        // tell table to refresh now
        [tableView reloadData];
        [self viewTitleName];
    }
}

#pragma mark - UISwitch Delegate Implementation
#pragma mark

- (void)userSelectedValue:(UISwitch *)sender {
    
    self.isReminderON = sender.on;
    NSLog(sender.on ? @"YES" : @"NO");
}

#pragma mark - User Selection Action
#pragma mark

- (IBAction)createReminder:(id)sender {
    
    [self performSegueWithIdentifier:kSegueCreateReminderID sender:self];
}

- (IBAction)editReminder:(id)sender {
    
    [self.reminderListTableView setEditing:!self.reminderListTableView.isEditing animated:YES];
    
    // Reload the table view.
    [self.reminderListTableView reloadData];
    
}
#pragma mark - CreateReminder Save Method Delegate
#pragma mark

-(void)reminderWasSuccessfullySavedWithData:(NSDictionary*)reminderDetails {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:60];
    // [reminderDetails objectForKey:kReminderTime];
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = [reminderDetails objectForKey:kReminderTitle];
    localNotification.alertAction = @"Details";
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
    // Once User Save the Reinder Details Then Save into CoreData
    [[OnMobileCoreDataManager sharedInstance] saveReminderDetails:[self convertDictionaryIntoReminderModelArray:reminderDetails]];
    
    // Assign those user data into array to update the table view row
    self.reminderListArray = [[[OnMobileCoreDataManager sharedInstance] getReminderDetails] copy];
    [self.reminderListTableView reloadData];

    
    
}

- (Reminder *) convertDictionaryIntoReminderModelArray:(NSDictionary *)dictionary {
    
    NSManagedObjectContext *managedObjectContext = [[OnMobileCoreDataManager sharedInstance] masterManagedObjectContext];
    
    Reminder *reminder = [NSEntityDescription insertNewObjectForEntityForName:@"Reminder"
                                                     inManagedObjectContext:managedObjectContext];
    reminder.title = [dictionary objectForKey:kReminderTitle];
    reminder.time = [ReminderHelperManager dateFromString:[dictionary objectForKey:kReminderTime]];;
    reminder.frequency = [dictionary objectForKey:kReminderFrequency];
    //reminder.isValid = self.isReminderON;
    
    return reminder;
}

#pragma mark - Navigation Segue
#pragma mark

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:kSegueCreateReminderID]) {
        
        CreateReminderController *datePickerViewController = [segue destinationViewController];
        datePickerViewController.delegate = self;
    }
}

#pragma mark - View Title Changed
#pragma mark

- (void) viewTitleName {
    
    self.title = self.reminderListArray.count ? kReminderList : kCreateRemibnder;
}

@end
