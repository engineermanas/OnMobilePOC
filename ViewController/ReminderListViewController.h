//
//  ReminderListViewController.h
//  OnMobilePOC
//
//  Created by Manasa Parida on 24/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateReminderController.h"

@interface ReminderListViewController : UIViewController <CreateReminderControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *reminderListTableView;

- (IBAction)createReminder:(id)sender;
- (IBAction)editReminder:(id)sender;

@end

