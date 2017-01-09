//
//  CountryBall.m
//  Football-X
//
//  Created by Hoang Dang Trung on 12/28/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import "CountryBall.h"

@implementation CountryBall

- (instancetype)initWithCode:(NSString *)code withName:(NSString *)name andCallingCode:(NSString *)callingCode {
    if (self == [super init]) {
        _code = code;
        _name = name;
        _callingCode = callingCode;
    }
    
    return self;
}

@end
