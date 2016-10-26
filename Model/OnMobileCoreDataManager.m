//
//  OnMobileCoreDataManager.m
//  OnMobilePOC
//
//  Created by Manasa Parida on 26/10/16.
//  Copyright © 2016 Personal Solution LTD. All rights reserved.
//

#import "OnMobileCoreDataManager.h"
#import "ReminderConstant.h"
//#import "Reminder.h"

@implementation OnMobileCoreDataManager

@synthesize backgroundManagedObjectContext,
            UIManagedObjectContext,
            masterManagedObjectContext,
            managedObjectModel,
            persistentStoreCoordinator;


#pragma mark - Singleton Shared Instance
#pragma mark

+ (instancetype)sharedInstance
{
    static dispatch_once_t pred = 0;
    static OnMobileCoreDataManager *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[OnMobileCoreDataManager alloc] init];
        
    });
    return sharedInstance;
}


#pragma mark - MOCS for Mutli threading context handling
#pragma mark

// Here i am directly calling master for OnmobilePOC

-(NSManagedObjectContext*)masterManagedObjectContext
{
    if (masterManagedObjectContext != nil) {
        return masterManagedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil) {
        
        // Here we can also use NSPrivateQueueConcurrencyType
        masterManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [masterManagedObjectContext setPersistentStoreCoordinator:coordinator];
        [masterManagedObjectContext setMergePolicy:NSMergeByPropertyStoreTrumpMergePolicy];
    }
    
    return masterManagedObjectContext;
}

-(NSManagedObjectContext*)backgroundManagedObjectContext
{
    if (backgroundManagedObjectContext != nil) {
        return backgroundManagedObjectContext;
    }
    backgroundManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    backgroundManagedObjectContext.parentContext = [self UIManagedObjectContext];
    [backgroundManagedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
    backgroundManagedObjectContext.undoManager = nil;
    return backgroundManagedObjectContext;
    
}

- (NSManagedObjectContext *)UIManagedObjectContext
{
    if (UIManagedObjectContext != nil) {
        return UIManagedObjectContext;
    }
    
    
    UIManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    UIManagedObjectContext.parentContext = [self masterManagedObjectContext];
    [UIManagedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
    return UIManagedObjectContext;
}

#pragma mark - MOCS NSPersistent StoreCoordinator
#pragma mark

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    // TO DO
    if (persistentStoreCoordinator != nil) {
        
        return persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"OnMobile.sqlite"];
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:[self managedObjectModel]];
    
    if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil URL:storeURL options:nil error:&error])
        if (error) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
            
        }
    
    return persistentStoreCoordinator;
}

#pragma mark - MOCS NSManaged ObjectModel
#pragma mark

// Returns If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }

    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"OnMobilePOC" withExtension:@"momd"];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}

#pragma mark - MOCS Saving
#pragma mark

- (void)saveContext {
    
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.masterManagedObjectContext;
    
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

// Save in Background Mode
- (void)saveBackgroundManagedObjectContext {
    
    __block NSError *error = nil;
    
    [[self backgroundManagedObjectContext] performBlock:^{
        
        [[self backgroundManagedObjectContext] save:&error];
        
        if (error) {
            
            NSLog(@"backgroundManagedObjectContext....Error==>>%@",error.description);
        }
    }];

}

// Save in UI Mode (Main Thread)
-(void) saveUIManagedObjectContext{
   
    __block NSError *error = nil;
    
    [[self UIManagedObjectContext] performBlock:^{
        
        [[self UIManagedObjectContext] save:&error];
        
        if (error) {
            
            NSLog(@"UIManagedObjectContext....Error==>>%@",error.description);
        }
        
    }];
}

#pragma mark - DocumentsDirectory
#pragma mark

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Reminder Saving Logic Goes Here
#pragma mark

-(void)saveReminderDetails:(Reminder*)reminderDetails {
    
    NSManagedObjectContext *managedObjectContext = [self masterManagedObjectContext];
    
    [self.masterManagedObjectContext performBlock:^{
        
        Reminder *reminder = [NSEntityDescription insertNewObjectForEntityForName:@"Reminder" inManagedObjectContext:managedObjectContext];
        reminder.title = reminderDetails.title;
        reminder.time = reminderDetails.time;
        reminder.frequency = reminderDetails.frequency;
        reminder.isValid = reminderDetails.isValid;
        
        [self saveContext];
    }];
}

#pragma mark - Fetch Reminder Logic Goes Here
#pragma mark

-(NSArray *)getReminderDetails {
    
    NSManagedObjectContext *managedObjectContext = [self masterManagedObjectContext];
    NSArray *reminderObjects =nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Reminder"];
    //NSEntityDescription* entity = [NSEntityDescription entityForName:@"Reminder" inManagedObjectContext:managedObjectContext];
    //[request setEntity:entity];
    NSError *error = nil;
    reminderObjects = [managedObjectContext executeFetchRequest:request error:&error];
    if(error)
    {
        NSLog(@"%@",error);
    }
    
    if (reminderObjects && [reminderObjects count]) {
        
        return reminderObjects;
    }
    return nil;
}

@end
