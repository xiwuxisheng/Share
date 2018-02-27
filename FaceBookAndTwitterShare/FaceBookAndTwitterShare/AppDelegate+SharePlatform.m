//
//  AppDelegate+SharePlatform.m
//  FaceBookAndTwitterShare
//
//  Created by 习武 on 2018/2/23.
//  Copyright © 2018年 习武. All rights reserved.
//

#import "AppDelegate+SharePlatform.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@implementation AppDelegate (SharePlatform)

#pragma mark - 分享的初始化设置
- (void)initShare{
    //    if (@available(iOS 11.0, *)) {
    //         [[Twitter sharedInstance] startWithConsumerKey:TW_TwitterAppKey consumerSecret:TW_TwitterAppSecret];
    //    }
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeCopy),@(SSDKPlatformTypeFacebook),@(SSDKPlatformTypeTwitter),@(SSDKPlatformTypeLine)]
                             onImport:^(SSDKPlatformType platformType) {
                                 
                             } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                 switch (platformType){
                                     case SSDKPlatformTypeFacebook:
                                         //设置Facebook应用信息，其中authType设置为只用SSO和web形式授权
                                         [appInfo SSDKSetupFacebookByApiKey:TW_FacebookAppKey
                                                                  appSecret:TW_FacebookAppSecret
                                                                   authType:SSDKAuthTypeBoth];
                                         break;
                                     case SSDKPlatformTypeTwitter:
                                         [appInfo SSDKSetupTwitterByConsumerKey:TW_TwitterAppKey
                                                                 consumerSecret:TW_TwitterAppSecret
                                                                    redirectUri:@"http://mob.com"];
                                         break;
                                     default:
                                         break;
                                 }
                             }];
    
}

//检查是否是短链接打开
- (BOOL)checkIsShortLinkOpen:(NSURL *)url{
    BOOL flag = NO;
    //shortLink为自定义的短链接，可替换
    if (url&&![url scheme]&&[[[url absoluteString] lowercaseString] rangeOfString:@"shortLink://"].location!=NSNotFound) {
        flag = YES;
    }
    return flag;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([self checkIsShortLinkOpen:url]) {
        return YES;
    }else{
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:sourceApplication
                                                           annotation:annotation];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    return [self checkIsShortLinkOpen:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [self checkIsShortLinkOpen:url];
}


@end
