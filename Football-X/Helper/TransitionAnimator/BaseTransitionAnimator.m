//
//  BaseTransitionAnimator.m
//  Football-X
//
//  Created by Hoang Dang Trung on 12/28/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import "BaseTransitionAnimator.h"

static NSTimeInterval const kDefaultDuration = 1.0;

@implementation BaseTransitionAnimator

- (id)init {
    self = [super init];
    if (self) {
        _duration = kDefaultDuration;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning protocol
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // Must be implemented by inheriting class
    [self doesNotRecognizeSelector:_cmd];
}



@end
