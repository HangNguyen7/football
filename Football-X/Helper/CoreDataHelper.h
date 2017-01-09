//
//  CoreDataHelper.h
//
//  Created by Hoang Dang Trung on 12/24/16.
//  Copyright © 2016 trunghoangdang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataHelper : NSObject

/*Add three most important instance variables with @property of Core Data classes */
@property (nonatomic, readonly) NSManagedObjectContext *context;
@property (nonatomic, readonly) NSManagedObjectModel *model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;

/* Declare static init method to initialise the Helper class */
+ (CoreDataHelper *)initCoreDataHelper;

/* Declare all the require instance method to manage Core Data life cycle */
- (void)initializeContext;
- (NSString*)getApplicationDocumentsDirectoryPath;
- (NSManagedObjectModel*)initilizeManagedObjectModel;
- (NSPersistentStoreCoordinator*)initilizeManagedPersistentStoreCoordinator;
- (void)saveCurrentContext;


#pragma mark - Below methods custom for each Projetc (Optional)
- (void)insertPersonWithName:(NSString*)name andAge:(NSString*)age;
- (NSArray*)selectAllPersons;
//- (NSManagedObject*)searchContactInfoByName:(NSString*)name;
- (void)deletePerson:(NSManagedObject*)person;


@end
