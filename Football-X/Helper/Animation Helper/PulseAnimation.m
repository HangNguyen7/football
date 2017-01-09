//
//  PulseAnimation.m
//  Football-X
//
//  Created by Hoang Dang Trung on 12/30/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//
#define kAnimationRemoveLayer @"animationRemoveLayer"

#import "PulseAnimation.h"

@implementation PulseAnimation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:50 startAngle:0.0*(M_PI/180.0) endAngle:360.0*(M_PI/180.0) clockwise:YES].CGPath;
        self.fillColor = [UIColor whiteColor].CGColor;
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
        scaleAnimation.fromValue = @(0.0);
        scaleAnimation.toValue = @1.0;
        
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = @1;
        opacityAnimation.toValue = @0;
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        NSArray *animations = @[scaleAnimation, opacityAnimation];
        animationGroup.duration = 0.5;
        animationGroup.delegate = self;
        animationGroup.repeatCount = 1; //HUGE_VAL: repeat forever
        
        [animationGroup setValue:self forKey:kAnimationRemoveLayer];
        
        animationGroup.animations = animations;
        [self addAnimation:animationGroup forKey:@"pulseAnimation"];
    }
    
    return self;
}

- (void)setColorPulse:(UIColor *)colorPulse {
    _colorPulse = colorPulse;
    self.fillColor = _colorPulse.CGColor;
}

- (void)setRadius:(CGFloat)radius {
    self.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:radius startAngle:0.0*(M_PI/180.0) endAngle:360.0*(M_PI/180.0) clockwise:YES].CGPath;
}

- (void)setPathRef:(CGPathRef)pathRef {
    self.path = pathRef;
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
    [self performSelector:@selector(removeLayerWhenAnimationFinish:) withObject:anim afterDelay:0.45];
}

//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    CALayer *lay = [anim valueForKey:kAnimationRemoveLayer];
//    if(lay){
//        [lay removeAllAnimations];
//        [lay removeFromSuperlayer];
//    }
//}

- (void)removeLayerWhenAnimationFinish:(CAAnimation *)anim {
    CALayer *lay = [anim valueForKey:kAnimationRemoveLayer];
    if(lay){
        [lay removeAllAnimations];
        [lay removeFromSuperlayer];
    }
}


@end


/* How to implement */

/*
 #import "Pulse.h"
 
 @property (weak, nonatomic) IBOutlet UIButton *btnCustom;
 
 - (IBAction)doPressButton:(id)sender {
 PulseAnimation *pulse = [PulseAnimation new];
 pulse.radius = 50; //Set radius for Circle. Default: 50
 pulse.colorPulse = [UIColor whiteColor]; //Set fillColor. Default: whiteColor
 pulse.pathRef = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, _btnCustom.frame.size.width, _btnCustom.frame.size.width) cornerRadius:20].CGPath; //Set Path. Default: Circle 50 redius
 
 pulse.frame = _btnCustom.frame;
 pulse.position = self.btnCustom.center;
 [self.view.layer addSublayer:pulse];
 
 [self performSelector:@selector(removePulseLayer:) withObject:pulse afterDelay:.48];
 }
 
 - (void)removePulseLayer:(PulseAnimation*)pulse {
 [pulse removeFromSuperlayer];
 
 // Do anything here //
 }
 
 */







