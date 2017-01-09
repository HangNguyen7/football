//
//  FXLoginViewController.m
//  Football-X
//
//  Created by Hoang Dang Trung on 12/21/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import "FXLoginViewController.h"
#import "FXSignUpPhoneViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface FXLoginViewController ()

@property (nonatomic, weak) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;
@property (weak, nonatomic) IBOutlet UIButton *btnTwitter;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUsername;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UIImageView *btnShowHidePassword;
@property (weak, nonatomic) IBOutlet UIButton *btnForfotPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnGetStarted;
@property (weak, nonatomic) IBOutlet UIView *viewAsBtnGotoSignUp;


@end

@implementation FXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBlurEffectForScreen];
    [self addGestureRecognizerForSubviews];
    [self setupLayoutForSubviews];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup layout for Subviews
- (void)setupLayoutForSubviews {
    [self.view layoutIfNeeded];
    [_btnGetStarted gradientEffect];
}

- (void)setBlurEffectForScreen {
    [self addImageViewAsBackground:kImage_Background];
    [self makeBlurEffectView];
}

#pragma mark - Add Gesture Recognizer for Subviews
- (void)addGestureRecognizerForSubviews {
    [self addGestureRecognizerWithSelector:@selector(gotoSignUpWithPhoneNumber) withTapsRequired:1 forView:self.viewAsBtnGotoSignUp];
    [self.btnBack addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Action
- (void)gotoSignUpWithPhoneNumber {
    FXSignUpPhoneViewController *signupPhoneVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FXSignUpPhoneViewController"];
    signupPhoneVC.transitioningDelegate = self;
    signupPhoneVC.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:signupPhoneVC animated:YES completion:nil];
}


- (void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:^{
        self.transitioningDelegate = nil;
    }];
}

#pragma mark - UIViewControllerTransitioningDelegate
/* Called when presenting a view controller that has a transitioningDelegate */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [self scaleTrasitionAnimatorWithAppearing:YES];
}

/* Called when dismissing a view controller that has a transitioningDelegate */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return [self scaleTrasitionAnimatorWithAppearing:NO];
}

@end

















