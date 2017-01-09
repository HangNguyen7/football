//
//  FXBounceTransitionAnimator.h
//  Football-X
//
//  Created by Hoang Dang Trung on 12/28/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import "FXSlideTransitionAnimator.h"

@interface FXBounceTransitionAnimator : FXSlideTransitionAnimator

@property (nonatomic, assign) CGFloat dampingRatio;
@property (nonatomic, assign) CGFloat velocity;

@end
