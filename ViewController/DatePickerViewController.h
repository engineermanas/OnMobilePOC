//
//  DatePickerViewController.h
//  OnMobilePOC
//
//  Created by Manasa Parida on 24/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

// Protocol defined to Notify the caller
@protocol DatePickerViewControllerDelegate

-(void)dateWasSelected:(NSDate *)selectedDate;

@end


@interface DatePickerViewController : UIViewController

@property (nonatomic, weak) id<DatePickerViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIDatePicker *dtDatePicker;

- (IBAction)savePickerDate:(id)sender;
- (IBAction)cancelPickerDate:(id)sender;

@end
