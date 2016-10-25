//
//  ReminderTableViewCell.h
//  OnMobilePOC
//
//  Created by Manasa Parida on 25/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReminderTableViewCell : UITableViewCell


@property (nonatomic,strong) UILabel *reminderTitle;
@property (nonatomic,strong) UILabel *reminderTime;
@property (nonatomic,strong) UILabel *reminderFrequency;
@property (nonatomic,strong) UISwitch *reminderStartStopSwitch;



@end
