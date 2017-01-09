//
//  BaseViewController.m
//  Football-X
//
//  Created by Hoang Dang Trung on 12/19/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreData/CoreData.h>

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.cornerRadius = 5;
    self.view.layer.masksToBounds = YES;
    
    [self initDefaultParameterForTransitionAnimator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Add ImageView as Background
- (void)addImageViewAsBackground:(UIImage*)image {
    UIImageView *imgBackground = [[UIImageView alloc] initWithImage:image];
    imgBackground.frame = self.view.frame;
    imgBackground.layer.zPosition = -1;
    imgBackground.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imgBackground];
    [self.view sendSubviewToBack:imgBackground];
}

#pragma mark - Blur effect view
- (void)makeBlurEffectView {
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.layer.zPosition = -0.5;
        blurEffectView.frame = self.view.bounds;
//        blurEffectView.alpha = 0.5;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:blurEffectView];
        [self.view sendSubviewToBack:blurEffectView];
    } else {

    }
}

#pragma mark - Add gesture recognizer for UIView
- (void)addGestureRecognizerWithSelector:(SEL)funcName withTapsRequired:(int)num forView:(UIView*)view {
    SEL selector = funcName;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setDelegate:self];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:recognizer];
}

#pragma mark - Status bar white color
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - init Parameter for Transition Animator
- (void)initDefaultParameterForTransitionAnimator {
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        NSString *initialDefaultsPath = [[NSBundle mainBundle] pathForResource:@"ParameterAnimatorDefault" ofType:@"plist"];
        NSDictionary *initialDefaults = [NSDictionary dictionaryWithContentsOfFile:initialDefaultsPath];
        [[NSUserDefaults standardUserDefaults] registerDefaults:initialDefaults];
    });
}

#pragma mark - Custom Transition Animator
- (id<UIViewControllerAnimatedTransitioning>)scaleTrasitionAnimatorWithAppearing:(BOOL)isAppearing {
    
    id<UIViewControllerAnimatedTransitioning> animationController;
    
    FXScaleTransitionAnimator *animator = [[FXScaleTransitionAnimator alloc] init];
    animator.appearing = isAppearing;
    animator.duration = 0.35;
    animationController = animator;
    
    return animationController;
}

- (id<UIViewControllerAnimatedTransitioning>)bounceTrasitionAnimatorWithAppearing:(BOOL)isAppearing {
    
    id<UIViewControllerAnimatedTransitioning> animationController;
    
    ParameterAnimator *params = [ParameterAnimator sharedParameter];

    FXBounceTransitionAnimator *animator = [[FXBounceTransitionAnimator alloc] init];
    animator.appearing = isAppearing;
    animator.duration = params.springDuration;
    animator.edge = params.edge;
    animator.dampingRatio = params.dampingRatio;
    animator.velocity = params.velocity;
    animationController = animator;
    
    return animationController;
}




@end













