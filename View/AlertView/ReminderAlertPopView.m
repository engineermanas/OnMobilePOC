//
//  ReminderAlertPopView.m
//  OnMobilePOC
//
//  Created by Manasa Parida on 27/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import "ReminderAlertPopView.h"
#import "ReminderConstant.h"


@implementation ReminderAlertPopView

+ (instancetype)sharedInstance {
    
    static dispatch_once_t pred = 0;
    static ReminderAlertPopView *sharedInstance = nil;
    
    dispatch_once(&pred, ^{
        
        sharedInstance = [[ReminderAlertPopView alloc] init];
    });
    return sharedInstance;
}

// We can aslo customized more in this method to pass extra information to display

-(void)showAlertToUserWithView:(UIViewController *)view WithAlertTitle:(NSString *)title WithAlertMessage:(NSString *)message
{
    UIAlertController * alertView=   [UIAlertController alertControllerWithTitle:title
                                                                         message:message
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction actionWithTitle:kAlertAction
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          
                                                          [alertView dismissViewControllerAnimated:YES completion:nil];
                                                          
                                                      }];
    // Add Alert Action to the Alert Controller
    [alertView addAction:yesButton];
    
    // Now time to show the Alert with aleart action on top of the view
    [view presentViewController:alertView animated:YES completion:nil];
}


@end
