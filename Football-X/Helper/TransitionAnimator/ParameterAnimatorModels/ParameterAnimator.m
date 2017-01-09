//
//  ParameterAnimator.m
//  Football-X
//
//  Created by Hoang Dang Trung on 12/28/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import "ParameterAnimator.h"

static NSString * const kPushTransitionsKey = @"pushTransitions";
static NSString * const kDurationKey        = @"duration";
static NSString * const kEdgeKey            = @"edge";
static NSString * const kDampingRatioKey    = @"dampingRatio";
static NSString * const kVelocityKey        = @"velocity";
static NSString * const kSpringDurationKey  = @"springDuration";

@implementation ParameterAnimator

+ (instancetype)sharedParameter {
    static ParameterAnimator *_sharedParameter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedParameter = [[self alloc] init];
    });
    
    return _sharedParameter;
}

#pragma - Getters and Setters

- (BOOL)pushTransitions {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kPushTransitionsKey];
}

- (void)setPushTransitions:(BOOL)pushTransitions {
    [[NSUserDefaults standardUserDefaults] setBool:pushTransitions forKey:kPushTransitionsKey];
}

- (NSTimeInterval)duration {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:kDurationKey];
}

- (void)setDuration:(NSTimeInterval)duration {
    [[NSUserDefaults standardUserDefaults] setDouble:duration forKey:kDurationKey];
}

- (FXEdge)edge {
    return [[NSUserDefaults standardUserDefaults] integerForKey:kEdgeKey];
}

- (void)setEdge:(FXEdge)edge {
    [[NSUserDefaults standardUserDefaults] setInteger:edge forKey:kEdgeKey];
}

- (CGFloat)dampingRatio {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:kDampingRatioKey];
}

- (void)setDampingRatio:(CGFloat)dampingRatio {
    [[NSUserDefaults standardUserDefaults] setDouble:dampingRatio forKey:kDampingRatioKey];
}

- (CGFloat)velocity {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:kVelocityKey];
}

- (void)setVelocity:(CGFloat)velocity {
    [[NSUserDefaults standardUserDefaults] setDouble:velocity forKey:kVelocityKey];
}

- (NSTimeInterval)springDuration {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:kSpringDurationKey];
}

- (void)setSpringDuration:(NSTimeInterval)springDuration {
    [[NSUserDefaults standardUserDefaults] setDouble:springDuration forKey:kSpringDurationKey];
}


@end





