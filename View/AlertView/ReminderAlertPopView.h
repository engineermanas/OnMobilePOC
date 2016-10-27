//
//  ReminderAlertPopView.m
//  OnMobilePOC
//
//  Created by Manasa Parida on 27/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReminderAlertPopView : UIView

+ (instancetype)sharedInstance;

// We can aslo customized more in this method to pass extra information to display
-(void)showAlertToUserWithView:(UIViewController *)view WithAlertTitle:(NSString *)title WithAlertMessage:(NSString *)message;

@end
