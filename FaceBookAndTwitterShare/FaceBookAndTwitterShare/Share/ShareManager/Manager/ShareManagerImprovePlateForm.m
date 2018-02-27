//
//  ShareManagerImprovePlateForm.m
//  house591
//
//  Created by xiwu on 17/1/16.
//
//

#import "ShareManagerImprovePlateForm.h"

@implementation ShareManagerImprovePlateForm

+ (BOOL)isInstall:(ShareHousePlateFormType)type{
    if (type == ShareHousePlateFormTypeLine) {
        return [self openApp:@"line://"];
    }else  if (type == ShareHousePlateFormTypeFB) {
         return [self openApp:@"fbauth2://"];
    }else  if (type == ShareHousePlateFormTypeTwitter) {
         return [self openApp:@"twitter://"];
    }
    return NO;
}

+ (BOOL)openApp:(NSString *)urlScheme{
    BOOL flag = NO;
    if (urlScheme&&[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlScheme]]) {
        flag = YES;
    }
    return flag;
}

@end
