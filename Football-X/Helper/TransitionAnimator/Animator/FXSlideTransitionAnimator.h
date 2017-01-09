//
//  FXSlideTransitionAnimator.h
//  Football-X
//
//  Created by Hoang Dang Trung on 12/28/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import "BaseTransitionAnimator.h"

@interface FXSlideTransitionAnimator : BaseTransitionAnimator

@property (nonatomic, assign) FXEdge edge;

- (CGRect)rectOffsetFromRect:(CGRect)rect atEdge:(FXEdge)edge;

@end
