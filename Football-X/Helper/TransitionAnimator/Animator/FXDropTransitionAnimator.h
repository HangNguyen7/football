//
//  FXDropTransitionAnimator.h
//  Football-X
//
//  Created by Hoang Dang Trung on 12/28/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXDropTransitionAnimator : UIDynamicBehavior <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, getter = isAppearing) BOOL appearing;
@property (nonatomic, assign) NSTimeInterval duration;

@end
