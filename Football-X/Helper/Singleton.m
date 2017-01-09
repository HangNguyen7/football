//
//  Singleton.m
//  Football-X
//
//  Created by Hoang Dang Trung on 12/24/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

static Singleton *sharedSingleton = nil;

+ (Singleton*)sharedSingleton {
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedSingleton = [[Singleton alloc] init];
    });
    
    return sharedSingleton;
}



@end


