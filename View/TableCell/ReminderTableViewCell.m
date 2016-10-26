//
//  ReminderTableViewCell.m
//  OnMobilePOC
//
//  Created by Manasa Parida on 25/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import "ReminderTableViewCell.h"
#import "ReminderConstant.h"

@implementation ReminderTableViewCell

@synthesize reminderTitle,reminderTime,reminderFrequency,reminderStartStopSwitch,delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
        
        reminderTitle = [[UILabel alloc]init];
        reminderTitle.font = [UIFont fontWithName:kFontNameHelvetica size:25];
        reminderTitle.lineBreakMode = NSLineBreakByWordWrapping;
        reminderTitle.textAlignment = NSTextAlignmentLeft;
        reminderTitle.textColor = [UIColor blackColor];
        
        reminderTime = [[UILabel alloc]init];
        reminderTime.font = [UIFont fontWithName:kFontNameHelvetica size:20];
        reminderTime.lineBreakMode = NSLineBreakByWordWrapping;
        reminderTime.textAlignment = NSTextAlignmentLeft;
        reminderTime.textColor = [UIColor blackColor];
        
        reminderFrequency = [[UILabel alloc]init];
        reminderFrequency.font = [UIFont fontWithName:kFontNameHelvetica size:15];
        reminderFrequency.textAlignment = NSTextAlignmentLeft;
        reminderFrequency.textColor = [UIColor blackColor];
        reminderFrequency.backgroundColor = [UIColor clearColor];
        
        reminderStartStopSwitch = [[UISwitch alloc] init];
        [reminderStartStopSwitch addTarget:self action:@selector(reminderStartAndStop:) forControlEvents:UIControlEventValueChanged];

        
        [self.contentView addSubview:reminderTitle];
        [self.contentView addSubview:reminderTime];
        [self.contentView addSubview:reminderFrequency];
        [self.contentView addSubview:reminderStartStopSwitch];

    }
    return self;
}

- (void) reminderStartAndStop:(UISwitch *)sender {
    
    if ([delegate respondsToSelector:@selector(userSelectedValue:)]) {
        
        [delegate userSelectedValue:sender];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    
    frame = CGRectMake(kReminderTitleFrame);
    reminderTitle.frame = frame;
    
    frame = CGRectMake(kReminderTimeFrame);
    reminderTime.frame = frame;

    frame = CGRectMake(kReminderFrequencyFrame);
    reminderFrequency.frame = frame;

    frame = CGRectMake(kReminderStartStopFrame);
    reminderStartStopSwitch.frame = frame;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
