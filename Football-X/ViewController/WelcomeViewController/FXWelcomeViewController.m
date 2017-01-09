//
//  FXWelcomeViewController.m
//  Football-X
//
//  Created by Hoang Dang Trung on 12/19/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#define DURATION 2
#define DISTANCE_ANIMATION_X 200
#define DISTANCE_ANIMATION_Y 200

#import "FXWelcomeViewController.h"
#import "FXLoginViewController.h"
#import "FXSignUpPhoneViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FXWelcomeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UIButton *btnTwitter;
@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUpWithPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbOr;
@property (weak, nonatomic) IBOutlet UIView *viewAsBtnGoToSignIn;
@property (weak, nonatomic) IBOutlet UILabel *lbAlreadyHaveAccount;
@property (weak, nonatomic) IBOutlet UILabel *lbSignIn;

@property (nonatomic) UIButton *btnLoginFacebook;



@property (nonatomic) AVPlayerLayer *playerLayer;
@property (nonatomic) AVPlayer *avPlayer;

@property (nonatomic) CAEmitterLayer *fireEmitter;
@property (nonatomic) CAEmitterLayer *smokeEmitter;

@end

@implementation FXWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageViewAsBackground:kImage_Background];
    
    [self addGestureRecognizerForSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setAlphaForSubviews:0];
    [self.view.layer addSublayer:self.playerLayer];
    
    [self createAnimationXBeating];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self moveSubviewToOutside];
    
    if (self.playerLayer) {
        [self.playerLayer.player seekToTime:kCMTimeZero];
        [self.playerLayer.player play];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup AVPlayer - play video as background
- (AVPlayerLayer*)playerLayer {
    if(!_playerLayer){
        NSURL *movieURL = [NSURL URLWithString:[self stringURLVideoStream]];
        
        _avPlayer = [[AVPlayer alloc] initWithURL:movieURL];
        _avPlayer.muted = YES;
        [_avPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];

        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
        _playerLayer.frame = self.view.frame;
        _playerLayer.videoGravity = @"AVLayerVideoGravityResizeAspectFill";
        [_playerLayer setZPosition:-0.5];
        
        // loop video
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(replayVideo:)
                                                     name: AVPlayerItemDidPlayToEndTimeNotification
                                                   object:nil];
    }
    return _playerLayer;
}

- (void)replayVideo:(NSNotification *)notification {
    [self.playerLayer.player seekToTime:kCMTimeZero];
    [self.playerLayer.player play];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if (object == _playerLayer.player && [keyPath isEqualToString:@"status"]) {
        if (_playerLayer.player.status == AVPlayerStatusReadyToPlay) {
            [self.playerLayer.player seekToTime:kCMTimeZero];
            [_playerLayer.player play];
            [self animationSubviewToBeginPosition];
        } else if (_playerLayer.player.status == AVPlayerStatusFailed) {
            // something went wrong. player.error should contain some information
        }
    }
}

#pragma mark - Animation Subviews
- (void)setAlphaForSubviews:(int)alpha {
    _imgLogo.alpha = alpha;
    _btnTwitter.alpha = alpha;
    _btnFacebook.alpha = alpha;
    _btnSignUpWithPhone.alpha = alpha;
    _lbOr.alpha = alpha;
    _viewAsBtnGoToSignIn.alpha = alpha;
    _lbAlreadyHaveAccount.alpha = alpha;
    _lbSignIn.alpha = alpha;
}

- (void)moveSubviewToOutside {
//    [self moveSubviewToTop:_imgLogo];
//    [self moveSubviewToLeft:_btnTwitter];
//    [self moveSubviewToRight:_btnFacebook];
//    [self moveSubviewToBottom:_btnSignUpWithPhone];
//    [self moveSubviewToBottom:_viewAsBtnGoToSignIn];
}

- (void)animationSubviewToBeginPosition {
    [UIView animateWithDuration:DURATION animations:^{
        [self setAlphaForSubviews:1];
        [self setupFireAnimation];//Fire
       
//        [self moveSubviewToBottom:_imgLogo];
//        [self moveSubviewToRight:_btnTwitter];
//        [self moveSubviewToLeft:_btnFacebook];
//        [self moveSubviewToTop:_btnSignUpWithPhone];
//        [self moveSubviewToTop:_viewAsBtnGoToSignIn];
    }];
}

#pragma mark - Move Animation
- (void)moveSubviewToTop:(UIView*)subView {
    CGPoint centerPoint = subView.center;
    centerPoint.y -= DISTANCE_ANIMATION_Y;
    [subView setCenter:centerPoint];
}

- (void)moveSubviewToBottom:(UIView*)subView {
    CGPoint centerPoint = subView.center;
    centerPoint.y += DISTANCE_ANIMATION_Y;
    [subView setCenter:centerPoint];
}

- (void)moveSubviewToLeft:(UIView*)subView {
    CGPoint centerPoint = subView.center;
    centerPoint.x -= DISTANCE_ANIMATION_X;
    [subView setCenter:centerPoint];
}

- (void)moveSubviewToRight:(UIView*)subView {
    CGPoint centerPoint = subView.center;
    centerPoint.x += DISTANCE_ANIMATION_X;
    [subView setCenter:centerPoint];
}

#pragma mark - Add Gesture Recognizer for Subviews
- (void)addGestureRecognizerForSubviews {
    [self addGestureRecognizerWithSelector:@selector(gotoLoginScreen) withTapsRequired:1 forView:self.viewAsBtnGoToSignIn];
    [self.btnSignUpWithPhone addTarget:self action:@selector(gotoSignUpWithPhoneNumber) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Action
/* Facebook Login */
- (IBAction)loginWithFacebook:(id)sender {
    [SocialNetworkHelper loginWithFacebookForTarget:self completionHandler:^(LOGIN_FACEBOOK_RESULT result, NSError *error) {
        if (result == LOGIN_FACEBOOK_RESULT_SUCCESS) {
            NSLog(@"Login FB Success");
            [self getFacebookProfileInfo];
            return;
        }
        if (result == LOGIN_FACEBOOK_RESULT_CANCEL) {
            NSLog(@"Login FB Cancelled");
            return;
        }
        if (result == LOGIN_FACEBOOK_RESULT_NOT_INTERNET) {
            NSLog(@"Login FB Not connect to internet");
            return;
        }
        NSLog(@"Login FB Failed");
    }];
}

- (void)getFacebookProfileInfo {
    [SocialNetworkHelper getFacebookProfileInfoCompletionHandler:^(id result, NSError *error) {
        if(result) {
            if ([result objectForKey:@"name"]) {
                NSLog(@"Name: %@", [result objectForKey:@"name"]);
            }
        }
    }];
}

/* Goto Login with Phone or Username */
- (void)gotoLoginScreen {
    [UIView animateWithDuration:0 animations:^{

    } completion:^(BOOL finished) {
        FXLoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FXLoginViewController"];
        loginVC.transitioningDelegate = self;
        loginVC.modalPresentationStyle = UIModalPresentationCustom;

        [self presentViewController:loginVC animated:YES completion:nil];
    }];
}

/* Goto Sign Up */
- (void)gotoSignUpWithPhoneNumber {
    FXSignUpPhoneViewController *signupPhoneVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FXSignUpPhoneViewController"];
    signupPhoneVC.transitioningDelegate = self;
    signupPhoneVC.modalPresentationStyle = UIModalPresentationCustom;

    [self presentViewController:signupPhoneVC animated:YES completion:nil];
}

#pragma mark - Setup Beating X
- (void)createAnimationXBeating {
    CABasicAnimation *beatLong = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    beatLong.fromValue = [NSNumber numberWithFloat:1.0];
    beatLong.toValue = [NSNumber numberWithFloat:0.7];
    beatLong.autoreverses = true;
    beatLong.duration = 0.5;
    beatLong.beginTime = 0.0;
    
    CABasicAnimation *beatShort = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    beatShort.fromValue = [NSNumber numberWithFloat:1.0];
    beatShort.toValue = [NSNumber numberWithFloat:0.5];
    beatShort.autoreverses = true;
    beatShort.duration = 0.7;
    beatShort.beginTime = beatLong.duration;
    beatLong.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CAAnimationGroup *heartBeatAnim = [[CAAnimationGroup alloc] init];
    heartBeatAnim.animations = @[beatLong, beatShort];
    heartBeatAnim.duration = beatShort.beginTime + beatShort.duration;
    heartBeatAnim.fillMode = kCAFillModeForwards;
    heartBeatAnim.removedOnCompletion = false;
    heartBeatAnim.repeatCount = FLT_MAX;
    [_imgLogo.layer addAnimation:heartBeatAnim forKey:@"animateBeating"];
}

#pragma mark - Setup Fire Animation for X-Logo
- (void)setupFireAnimation {
    CGRect viewBounds = _imgLogo.layer.bounds;
    
    // Create the emitter layers
    self.fireEmitter	= [CAEmitterLayer layer];
    self.smokeEmitter	= [CAEmitterLayer layer];
    
    // Place layers just above the tab bar
    self.fireEmitter.emitterPosition = CGPointMake(_imgLogo.center.x, _imgLogo.center.y + _imgLogo.bounds.size.height/3); //Điểm bắt đầu Fire
    self.fireEmitter.emitterSize	= CGSizeMake(viewBounds.size.width, 0);
    self.fireEmitter.emitterMode	= kCAEmitterLayerOutline;
    self.fireEmitter.emitterShape	= kCAEmitterLayerCuboid;
    // with additive rendering the dense cell distribution will create "hot" areas
    self.fireEmitter.renderMode		= kCAEmitterLayerAdditive;
    self.fireEmitter.zPosition = -0.1;

    self.smokeEmitter.emitterPosition = self.imgLogo.center; //Điểm bắt đầu Smoke
    self.smokeEmitter.emitterMode	= kCAEmitterLayerOutline;
    self.smokeEmitter.emitterShape	= kCAEmitterLayerSphere;
    
    // Create the fire emitter cell
    CAEmitterCell* fire = [CAEmitterCell emitterCell];
    [fire setName:@"fire"];
    //    fire.birthRate			= 100;
    fire.emissionLongitude  = 0;
    fire.velocity			= -80;
    fire.velocityRange		= 30;
    //    fire.emissionRange		= 0.7;
    fire.yAcceleration		= -500;
    fire.scaleSpeed			= 0.05;
    //    fire.lifetime			= 50;
    //    fire.lifetimeRange		= (50.0 * 0.35);
    fire.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1] CGColor];
    fire.contents = (id) [[UIImage imageNamed:@"Image_Fire"] CGImage];
    
    // Create the smoke emitter cell
    CAEmitterCell* smoke = [CAEmitterCell emitterCell];
    [smoke setName:@"smoke"];
    
    smoke.birthRate			= 30; //3
    smoke.emissionLongitude = -M_PI / 2;
    smoke.lifetime			= 10;
    smoke.velocity			= -40;
    smoke.velocityRange		= 20;
    smoke.emissionRange		= M_PI / 4;
    smoke.spin				= 1;
    smoke.spinRange			= 6;
    smoke.yAcceleration		= -140;
    smoke.contents			= (id) [[UIImage imageNamed:@"Image_Smoke"] CGImage];
    smoke.scale				= 0.1;
    smoke.alphaSpeed		= -0.12;
    smoke.scaleSpeed		= 0.004; //Độ phóng to cell //0.4
    
    
    // Add the smoke emitter cell to the smoke emitter layer
    self.smokeEmitter.emitterCells	= [NSArray arrayWithObject:smoke];
    self.fireEmitter.emitterCells	= [NSArray arrayWithObject:fire];
    
    self.fireEmitter.beginTime = CACurrentMediaTime()+1;
    self.smokeEmitter.beginTime = CACurrentMediaTime()+2;
    
    [self.view.layer addSublayer:self.smokeEmitter];
    [self.view.layer addSublayer:self.fireEmitter];
    
    [self setFireAmount:1];
}

- (void) setFireAmount:(float)zeroToOne {
    // Update the fire properties
    float size = _imgLogo.bounds.size.width - 18;
    
    [self.fireEmitter setValue:[NSNumber numberWithInt:(zeroToOne * 12 *size)]
                    forKeyPath:@"emitterCells.fire.birthRate"]; //Độ dầy
    [self.fireEmitter setValue:[NSNumber numberWithFloat:zeroToOne/2]
                    forKeyPath:@"emitterCells.fire.lifetime"]; //Thời gian tắt
    [self.fireEmitter setValue:[NSNumber numberWithFloat:(zeroToOne/2 * 0.35)]
                    forKeyPath:@"emitterCells.fire.lifetimeRange"];
    self.fireEmitter.emitterSize = CGSizeMake(size * zeroToOne, 0); //Độ rộng
    
    [self.smokeEmitter setValue:[NSNumber numberWithInt:zeroToOne*2]
                     forKeyPath:@"emitterCells.smoke.lifetime"];
    [self.smokeEmitter setValue:(id)[[UIColor colorWithRed:1 green:1 blue:1 alpha:zeroToOne * 0.3] CGColor]
                     forKeyPath:@"emitterCells.smoke.color"];
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

#pragma mark - View Will Disappear
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.fireEmitter removeFromSuperlayer];
    self.fireEmitter = nil;
    [self.smokeEmitter removeFromSuperlayer];
    self.smokeEmitter = nil;
    
    /* not sure if the pause/remove order would matter */
    
    [self.playerLayer.player seekToTime:kCMTimeZero];
    [self.playerLayer.player pause];
    // uncomment if the player not needed anymore
    
    
    [_avPlayer removeObserver:self forKeyPath:@"status"];
    _playerLayer.player = nil;
    [self.playerLayer removeFromSuperlayer];
    self.playerLayer = nil;

    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}



#pragma mark - Utils extension
- (NSString*)stringURLVideoStream {
    NSString *strURL = @"https://r2---sn-42u-i5oee.googlevideo.com/videoplayback?signature=CCB27413EE2A5585CEEB4AF449CBB1D40E4289B6.0DA22B443BFEB6984AD49A8D9DF232544EC128DB&requiressl=yes&ratebypass=yes&itag=22&initcwndbps=2748750&mime=video%2Fmp4&ipbits=0&mt=1482828741&key=yt6&upn=-cb-gugde2Y&sparams=dur%2Cei%2Cid%2Cinitcwndbps%2Cip%2Cipbits%2Citag%2Clmt%2Cmime%2Cmm%2Cmn%2Cms%2Cmv%2Cpl%2Cratebypass%2Crequiressl%2Csource%2Cupn%2Cexpire&expire=1482850551&source=youtube&mv=m&ei=lyxiWJ2XLIba4gLE26X4Cw&ms=au&ip=118.70.200.15&lmt=1477076045771962&dur=39.125&pl=24&mm=31&mn=sn-42u-i5oee&id=o-AKkxQWjuhQEGtgDOti69yhnxpZ-EQ-r70dZ0reRm6Nke";
    
    return strURL;
}

@end














