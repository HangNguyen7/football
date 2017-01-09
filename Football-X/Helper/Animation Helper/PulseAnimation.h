//
//  PulseAnimation.h
//  Football-X
//
//  Created by Hoang Dang Trung on 12/30/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface PulseAnimation : CAShapeLayer <CAAnimationDelegate>

@property (nonatomic) UIColor *colorPulse;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGPathRef pathRef;

@end
