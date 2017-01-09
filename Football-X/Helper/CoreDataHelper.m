//
//  CoreDataHelper.m
//
//  Created by Hoang Dang Trung on 12/24/16.
//  Copyright © 2016 trunghoangdang. All rights reserved.
//

#define STORE_FILE_NAME @"Football_X.sqlite"
#define CORE_DATA_FIlE_NAME @"Football_X" //Football_X.xcdatamodeld

#import "CoreDataHelper.h"

static CoreDataHelper *coreDataHelper;

@interface CoreDataHelper ()

@end

@implementation CoreDataHelper


//=================== [BEGIN] - SETUP CORE DATA =================================//

/* To initialise this class and Current Context */
+ (CoreDataHelper*)initCoreDataHelper {
    if (coreDataHelper == nil) {
        coreDataHelper = [[CoreDataHelper alloc] init];
        [coreDataHelper initializeContext];
    }
    
    return coreDataHelper;
}

/* To get the directory path where we store our database file */
- (NSString*)getApplicationDocumentsDirectoryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSLog(@"Path sqlite: %@", basePath);
    
    return basePath;
}

/* To init the managed object model */
 - (NSManagedObjectModel*)initilizeManagedObjectModel {
     if (_model != nil) {
         return _model;
     }
     NSURL *modelURL = [[NSBundle mainBundle] URLForResource:CORE_DATA_FIlE_NAME withExtension:@"momd"];
     _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
     
     return _model;
 }

/* To create core data */
- (NSPersistentStoreCoordinator*)initilizeManagedPersistentStoreCoordinator {
    if (_coordinator != nil) {
        return _coordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath:[[self getApplicationDocumentsDirectoryPath]stringByAppendingPathComponent:STORE_FILE_NAME]];
    NSError *error = nil;
    _coordinator = [[NSPersistentStoreCoordinator alloc]
                   initWithManagedObjectModel:[self initilizeManagedObjectModel]];
    if (![_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                   configuration:nil URL:storeUrl options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _coordinator;
}

/* To init the current context of core data */
 - (void)initializeContext {
     if (_context == nil) {
         NSPersistentStoreCoordinator *acoordinator = [self initilizeManagedPersistentStoreCoordinator];
         _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
         [_context setPersistentStoreCoordinator:acoordinator];
     }
 }

/* Save the current context when app is going to be close/quit.
 Okay!! This method we will use in App Delegate class to store our application core data state when user quite app etc... */
- (void)saveCurrentContext {
    NSError *error = nil;
    if (_context != nil) {
        if ([_context hasChanges] && ![_context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

//========================== [END] - SETUP CORE DATA==================================//



#pragma mark - Below methods custom for each Projetc (Optional)

#pragma mark - COREDATA - INSERT
- (void)insertPersonWithName:(NSString*)name andAge:(NSString*)age {
    NSManagedObject *newPerson;
    newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:_context];
    [newPerson setValue:name forKey:@"name"];
    [newPerson setValue:age forKey:@"age"];
    NSError *error = nil;
    if ([_context save:&error]) {
        NSLog(@"Person saved");
    }
    else{
        NSLog(@"Error occured while saving");
    }
}


#pragma mark - COREDATA - SELECT / VIEW ALL DATA
- (NSArray*)selectAllPersons {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Person"];

    NSError *error = nil;
    NSArray *objects = [_context executeFetchRequest:fetchRequest error:&error];
    if ([objects count]>0) {
        for (NSManagedObject *aContact in objects) {
            NSLog(@"name=%@, age=%@",[aContact valueForKey:@"name"],[aContact valueForKey:@"age"]);
        }
    }
    else{
        NSLog(@"no matches found");
    }
    return objects;
}
//
//#pragma mark - COREDATA - SEARCH
//
////this method will returns an Object which contains one person's Contact info details
//- (NSManagedObject *)searchContactInfoByName:(NSString *)name{
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contacts" inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    
//    //add predicate to search by name
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",name];
//    [fetchRequest setPredicate:predicate];
//    NSManagedObject *aContact = nil;
//    
//    NSError *error;
//    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
//    
//    if ([objects count]==0) {
//        NSLog(@"no matches found");
//    }
//    else{
//        aContact = [objects objectAtIndex:0];
//        NSLog(@"name=%@, address=%@, phone=%@",[aContact valueForKey:@"name"], [aContact valueForKey:@"address"],[aContact valueForKey:@"phone"]);
//    }
//    return aContact;
//}
//

#pragma mark - COREDATA - DELETE
- (void)deletePerson:(NSManagedObject*)person {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    
    //delete object
    [_context deleteObject:person];
    
    // Save everything after deletion
    if ([_context save:&error]) {
        NSLog(@"The update was successful!");
    } else {
        NSLog(@"The update wasn't successful: %@", [error localizedDescription]);
    }
}

@end

