//
//  AppDelegate.h
//  Football-X
//
//  Created by Hoang Dang Trung on 12/19/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

