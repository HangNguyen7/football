//
//  CountryBall.h
//  Football-X
//
//  Created by Hoang Dang Trung on 12/28/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryBall : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *callingCode;

- (instancetype)initWithCode:(NSString*)code withName:(NSString*)name andCallingCode:(NSString*)callingCode;

@end
