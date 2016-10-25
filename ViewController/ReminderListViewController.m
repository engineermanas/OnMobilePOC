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
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>


@interface ReminderListViewController ()

@property (nonatomic, strong) NSMutableArray *reminderListArray;

@end

@implementation ReminderListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.reminderListArray = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self viewTitleName];
    [self.reminderListTableView reloadData];
}


#pragma mark - UITableView Delegate and Datasource method implementation

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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // Cell background color
        cell.backgroundColor = kCellBackgroundColor;

    }
    
    // Get Cell Index All Value
    NSDictionary *reminder = [self.reminderListArray objectAtIndex:indexPath.row];
    cell.reminderTitle.text = [reminder objectForKey:kReminderTitle];
    cell.reminderTime.text = [reminder objectForKey:kReminderTime];
    cell.reminderFrequency.text = [NSString stringWithFormat:kReminderFormat,[reminder objectForKey:kReminderFrequency]];
    [cell.reminderStartStopSwitch addTarget:self action:@selector(reminderStartAndStop:) forControlEvents:UIControlEventValueChanged];

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

- (void) reminderStartAndStop:(UISwitch *)sender {

    NSLog(sender.on ? @"YES" : @"NO");
}

- (IBAction)createReminder:(id)sender {
    
    [self performSegueWithIdentifier:kSegueCreateReminderID sender:self];
}

- (IBAction)editReminder:(id)sender {
    
    [self.reminderListTableView setEditing:!self.reminderListTableView.isEditing animated:YES];
    
    // Reload the table view.
    [self.reminderListTableView reloadData];
    
}
#pragma mark - CreateReminderControllerDelegate method implementation

-(void)reminderWasSuccessfullySavedWithData:(NSDictionary*)reminderDetails {
    
    [self.reminderListArray addObject:reminderDetails];
    
//    UILocalNotification *aNotification = [[UILocalNotification alloc] init];
//    aNotification.fireDate = [reminderDetails objectForKey:@"ReminderTime"];
//    aNotification.timeZone = [NSTimeZone defaultTimeZone];
//    aNotification.alertBody = @"Notification triggered";
//    aNotification.alertAction = @"Details";
//    [[UIApplication sharedApplication] scheduleLocalNotification:aNotification];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:kSegueCreateReminderID]) {
        CreateReminderController *datePickerViewController = [segue destinationViewController];
        datePickerViewController.delegate = self;
    }
}

- (void) viewTitleName {
    
    self.title = self.reminderListArray.count ? kReminderList : kCreateRemibnder;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
