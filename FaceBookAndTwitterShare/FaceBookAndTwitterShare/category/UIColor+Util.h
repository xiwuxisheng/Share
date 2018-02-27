//
//  UIColor+Util.h
//  FaceBookAndTwitterShare
//
//  Created by 习武 on 2018/2/27.
//  Copyright © 2018年 习武. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Util)

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
