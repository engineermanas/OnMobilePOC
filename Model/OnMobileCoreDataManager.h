//
//  OnMobileCoreDataManager.h
//  OnMobilePOC
//
//  Created by Manasa Parida on 26/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ReminderManagedObject.h"
#import "ReminderModel.h"


@interface OnMobileCoreDataManager : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *backgroundManagedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectContext *UIManagedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectContext *masterManagedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)sharedInstance;

-(NSManagedObjectContext*)masterManagedObjectContext;

- (void)saveContextWithCompletionBlock:(void (^)(BOOL response))completionBlock;

-(void)saveReminderDetails:(ReminderModel *)reminderDetails withCompletionBlock:(void (^)(BOOL response))completionBlock;

-(NSArray *)getReminderDetails;

@end
