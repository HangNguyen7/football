//
//  SocialNetworkHelper.m
//  Football-X
//
//  Created by Hoang Dang Trung on 1/5/17.
//  Copyright © 2017 Hoang Dang Trung. All rights reserved.
//

#import "SocialNetworkHelper.h"
#import "Reachability.h"

@implementation SocialNetworkHelper

#pragma mark - Facebook
+ (void)loginWithFacebookForTarget:(UIViewController*)viewController completionHandler:(LoginFacebookCompeletionHandler)handler {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        handler(LOGIN_FACEBOOK_RESULT_NOT_INTERNET, nil);
        return;
    } else {
        NSLog(@"internet connection is Ok");
    }
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    [login logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends", @"user_birthday", @"user_hometown", @"user_location"]
                 fromViewController:viewController
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    handler(LOGIN_FACEBOOK_RESULT_FAILED, error);
                                } else if (result.isCancelled) {
                                    handler(LOGIN_FACEBOOK_RESULT_CANCEL, error);
                                } else {
                                    handler(LOGIN_FACEBOOK_RESULT_SUCCESS, error);
                                }
                            }];
}

+ (void)getFacebookProfileInfoCompletionHandler:(void(^)(id result, NSError *error))completion {

    FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, email, gender, birthday, hometown, location, picture.type(large)"}];
    
    FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
    
    [connection addRequest:requestMe completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        completion(result, error);
    }];

    [connection start];
}

+ (NSString*)getFacebookProfilePictureWithUserID:(NSString*)userID {
    NSString *pictureURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", userID];
    
    
//    NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", userID]];
//    NSData *imageData = [NSData dataWithContentsOfURL:pictureURL];
//    UIImage *fbImage = [UIImage imageWithData:imageData];
    
    return pictureURL;
}

#pragma mark - Twitter



@end

















