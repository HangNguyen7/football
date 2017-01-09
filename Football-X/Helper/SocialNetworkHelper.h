//
//  SocialNetworkHelper.h
//  Football-X
//
//  Created by Hoang Dang Trung on 1/5/17.
//  Copyright © 2017 Hoang Dang Trung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

typedef enum {
    LOGIN_FACEBOOK_RESULT_SUCCESS = 1,
    LOGIN_FACEBOOK_RESULT_FAILED = 0,
    LOGIN_FACEBOOK_RESULT_CANCEL = -1,
    LOGIN_FACEBOOK_RESULT_NOT_INTERNET = -1009
} LOGIN_FACEBOOK_RESULT;

typedef void (^LoginFacebookCompeletionHandler)(LOGIN_FACEBOOK_RESULT result, NSError *error);


@interface SocialNetworkHelper : NSObject


#pragma mark - Facebook
+ (void)loginWithFacebookForTarget:(UIViewController*)viewController completionHandler:(LoginFacebookCompeletionHandler)handler;
+ (void)getFacebookProfileInfoCompletionHandler:(void(^)(id result, NSError *error))completion;
+ (NSString*)getFacebookProfilePictureWithUserID:(NSString*)userID;

#pragma mark - Twitter


@end
