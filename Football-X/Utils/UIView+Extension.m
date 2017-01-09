//
//  UIView+Extension.m
//  Football-X
//
//  Created by Hoang Dang Trung on 12/19/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

@dynamic borderColor,borderWidth,cornerRadius;

- (void)setBorderColor:(UIColor *)borderColor{
    [self.layer setBorderColor:borderColor.CGColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    [self.layer setBorderWidth:borderWidth];
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    [self.layer setCornerRadius:cornerRadius];
}

@end
