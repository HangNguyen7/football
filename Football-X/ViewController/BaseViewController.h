//
//  BaseViewController.h
//  Football-X
//
//  Created by Hoang Dang Trung on 12/19/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXSlideTransitionAnimator.h"
#import "FXBounceTransitionAnimator.h"
#import "FXDropTransitionAnimator.h"
#import "FXFoldTransitionAnimator.h"
#import "FXScaleTransitionAnimator.h"

@interface BaseViewController : UIViewController<UIScrollViewDelegate, UITextFieldDelegate, UISearchBarDelegate, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

- (void)addGestureRecognizerWithSelector:(SEL)funcName withTapsRequired:(int)num forView:(UIView*)view;
- (void)makeBlurEffectView;
- (void)addImageViewAsBackground:(UIImage*)image;

- (id<UIViewControllerAnimatedTransitioning>)scaleTrasitionAnimatorWithAppearing:(BOOL)isAppearing;
- (id<UIViewControllerAnimatedTransitioning>)bounceTrasitionAnimatorWithAppearing:(BOOL)isAppearing;




@end
