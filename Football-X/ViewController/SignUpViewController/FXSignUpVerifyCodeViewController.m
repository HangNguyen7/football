//
//  FXSignUpVerifyCodeViewController.m
//  Football-X
//
//  Created by Hoang Dang Trung on 12/21/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import "FXSignUpVerifyCodeViewController.h"
#import "FXSignUpUsernameViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface FXSignUpVerifyCodeViewController ()

@property (nonatomic, weak) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITextField *textFieldVerifyCode;
@property (weak, nonatomic) IBOutlet UIButton *btnNextStep;

@end

@implementation FXSignUpVerifyCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBlurEffectForScreen];
    [self addGestureRecognizerForSubviews];
    [self setupTextField];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_textFieldVerifyCode becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup layout for Subviews
- (void)setupLayoutForSubviews {

}

- (void)setBlurEffectForScreen {
    [self addImageViewAsBackground:kImage_Background];
    [self makeBlurEffectView];
    _btnNextStep.userInteractionEnabled = 0;
    [_btnNextStep gradientEffect];
}

#pragma mark - Setup TextField
- (void)setupTextField {
    _textFieldVerifyCode.delegate = self;
    [_textFieldVerifyCode addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - Add Gesture Recognizer for Subviews
- (void)addGestureRecognizerForSubviews {
    [self.btnNextStep addTarget:self action:@selector(createPulseAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.btnBack addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Helper Animation
- (void)createPulseAnimation {
    PulseAnimation *pulse = [PulseAnimation new];
    pulse.colorPulse = [UIColor whiteColor]; //Set fillColor. Default: whiteColor
    
    pulse.position = _btnNextStep.center;
    [self.contentView.layer addSublayer:pulse];
    
    [self performSelector:@selector(removePulseLayer:) withObject:pulse afterDelay:0.5];
}

- (void)removePulseLayer:(PulseAnimation*)pulse {
    [pulse removeFromSuperlayer];
    
    [self nextStep];
}

#pragma mark - TextField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (void)textChanged:(UITextField *)textField {
    if (textField.text.length > 0) {
        [_btnNextStep setBackgroundColor:[UIColor colorWithRed:27.f/255.f green:112.f/255.f blue:195.f/255.f alpha:1]];
        _btnNextStep.userInteractionEnabled = 1;
    } else {
        [_btnNextStep setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.14]];
        _btnNextStep.userInteractionEnabled = 0;
    }
}

#pragma mark - Action
- (void)nextStep {
    FXSignUpUsernameViewController *verifyCodeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FXSignUpUsernameViewController"];
    verifyCodeVC.transitioningDelegate = self;
    
    [self presentViewController:verifyCodeVC animated:YES completion:nil];
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
    return [self bounceTrasitionAnimatorWithAppearing:YES];
}

/* Called when dismissing a view controller that has a transitioningDelegate */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return [self bounceTrasitionAnimatorWithAppearing:NO];
}

@end









