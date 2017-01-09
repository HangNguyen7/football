//
//  UIButton+Extension.m
//  Football-X
//
//  Created by Hoang Dang Trung on 12/22/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (void)gradientEffect {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.zPosition = -1;
    gradientLayer.frame = self.layer.bounds;
    
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[UIColor colorWithWhite:1.0f alpha:0.1f].CGColor,
                            (id)[UIColor colorWithWhite:0.4f alpha:0.5f].CGColor,
                            nil];
    
    //    gradientLayer.locations = [NSArray arrayWithObjects:
    //                               [NSNumber numberWithFloat:0.0f],
    //                               [NSNumber numberWithFloat:1.0f],
    //                               nil];
    gradientLayer.startPoint = CGPointMake(0.5,0.0);
    gradientLayer.endPoint = CGPointMake(0.5,1.0);
    gradientLayer.cornerRadius = self.layer.cornerRadius;
    
    // Shadow
//    gradientLayer.shadowOffset = CGSizeMake(5.0f, 5.0f);
//    gradientLayer.shadowColor = [UIColor blackColor].CGColor;
//    gradientLayer.shadowOpacity = 0.6;
//    gradientLayer.shadowRadius = 10;
    
    [self.layer addSublayer:gradientLayer];
}

@end
