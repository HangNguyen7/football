//
//  FXBounceTransitionAnimator.m
//  Football-X
//
//  Created by Hoang Dang Trung on 12/28/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import "FXBounceTransitionAnimator.h"

@implementation FXBounceTransitionAnimator

static CGFloat const kDefaultDampingRatio = 0.5;
static CGFloat const kDefaultVelocity = 4.0;

- (id)init {
    self = [super init];
    if (self) {
        _dampingRatio = kDefaultDampingRatio;
        _velocity = kDefaultVelocity;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect offscreenRect = [self rectOffsetFromRect:initialFrame atEdge:self.edge];
    
    // Presenting
    if (self.appearing) {
        // Position the view offscreen
        toView.frame = offscreenRect;
        [containerView addSubview:toView];
        
        // Animate the view onscreen
        [UIView animateWithDuration:duration
                              delay:0
             usingSpringWithDamping:self.dampingRatio
              initialSpringVelocity:self.velocity
                            options:0
                         animations: ^{
                             toView.frame = initialFrame;
                         } completion: ^(BOOL finished) {
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }
    // Dismissing
    else {
        [containerView addSubview:toView];
        [containerView sendSubviewToBack:toView];
        
        // Animate the view offscreen
        [UIView animateWithDuration:duration
                              delay:0
             usingSpringWithDamping:self.dampingRatio
              initialSpringVelocity:self.velocity
                            options:0
                         animations: ^{
                             fromView.frame = offscreenRect;
                         } completion: ^(BOOL finished) {
                             [fromView removeFromSuperview];
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }
}

@end
















