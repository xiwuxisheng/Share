//
//  AppDelegate.m
//  FaceBookAndTwitterShare
//
//  Created by 习武 on 2018/2/23.
//  Copyright © 2018年 习武. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+SharePlatform.h"
#import "TestShareViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = TWColor_ffffff;
    [self.window makeKeyAndVisible];
    [self initShare];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[TestShareViewController alloc] init]];
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
