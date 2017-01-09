//
//  ParameterAnimator.h
//  Football-X
//
//  Created by Hoang Dang Trung on 12/28/16.
//  Copyright © 2016 Hoang Dang Trung. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FXEdge) {
    FXEdgeTop,
    FXEdgeLeft,
    FXEdgeBottom,
    FXEdgeRight,
    FXEdgeTopRight,
    FXEdgeTopLeft,
    FXEdgeBottomRight,
    FXEdgeBottomLeft
};

@interface ParameterAnimator : NSObject

// General
@property (nonatomic, assign) BOOL pushTransitions;
@property (nonatomic, assign) NSTimeInterval duration;

// Slide
@property (nonatomic, assign) FXEdge edge;

// Spring
@property (nonatomic, assign) CGFloat dampingRatio;
@property (nonatomic, assign) CGFloat velocity;
@property (nonatomic, assign) NSTimeInterval springDuration;

+ (instancetype)sharedParameter;


@end
