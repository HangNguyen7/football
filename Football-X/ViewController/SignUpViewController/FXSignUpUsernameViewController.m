//
//  FXSignUpUsernameViewController.m
//  Football-X
//
//  Created by Hoang Dang Trung on 12/22/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import "FXSignUpUsernameViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface FXSignUpUsernameViewController ()

@property (nonatomic, weak) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUsername;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnGetStarted;
@property (weak, nonatomic) IBOutlet UIImageView *btnShowHidePassword;

@end

@implementation FXSignUpUsernameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBlurEffectForScreen];
    [self addGestureRecognizerForSubviews];
    [self setupLayoutForSubviews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_textFieldUsername becomeFirstResponder];
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
    [self.btnGetStarted addTarget:self action:@selector(createPulseAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.btnBack addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Helper Animation
- (void)createPulseAnimation {
    PulseAnimation *pulse = [PulseAnimation new];
    pulse.colorPulse = [UIColor clearColor]; //Set fillColor. Default: whiteColor
    pulse.pathRef = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, _btnGetStarted.frame.size.width, _btnGetStarted.frame.size.height) cornerRadius:10].CGPath; //Set Path. Default: Circle 50 redius
    pulse.frame  = _btnGetStarted.frame;
    pulse.position = _btnGetStarted.center;
    [self.contentView.layer addSublayer:pulse];
    
    [self performSelector:@selector(removePulseLayer:) withObject:pulse afterDelay:0.5];
}

- (void)removePulseLayer:(PulseAnimation*)pulse {
    [pulse removeFromSuperlayer];
    
    [self nextStep];
}

#pragma mark - Action
- (void)nextStep {
//    FXSignUpUsernameViewController *verifyCodeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FXSignUpUsernameViewController"];
//    [self presentViewController:verifyCodeVC animated:YES completion:nil];
}

- (void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:^{
        self.transitioningDelegate = nil;
    }];
}


@end















