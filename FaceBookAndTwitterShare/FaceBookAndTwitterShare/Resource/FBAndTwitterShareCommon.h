//
//  FBAndTwitterShareCommon.h
//  FaceBookAndTwitterShare
//
//  Created by 习武 on 2018/2/24.
//  Copyright © 2018年 习武. All rights reserved.
//

#ifndef FBAndTwitterShareCommon_h
#define FBAndTwitterShareCommon_h

//ShareSdk
#define TW_ShareSdkAppKey       @"1f26c2dcea97e"  // @"5427749ae50"
#define TW_ShareSdkAppSecretKey    @"6f1ff0410957e6fdec74bdcda27af3c1"

//Facebook
#define TW_FacebookAppKey      @"635891556501601"
#define TW_FacebookAppSecret   @"2e47f09642f250ec63ee2922d014cc9c"

//Twitter
#define TW_TwitterAppKey      @"mnTGqtXk0TYMXYTN7qUxg"
#define TW_TwitterAppSecret   @"ROkFqr8c3m1HXqS3rm3TJ0WkAJuwBOSaWhPbZ9Ojuc"

//防止block循環引用
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;

//屏幕Rect
#define SCREEN_RECT ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//顔色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
//顔色透明
#define RGBCOLOR_TRANSPARENT(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:0.5]

#define RGBCOLOR_TRANSPARENT_NUM(r,g,b,d) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:d]

#define BoldFontSize(y)  [UIFont boldSystemFontOfSize:y]

#define SYSFontSize(y)   [UIFont systemFontOfSize:y]

//检查是否为空对象
#define CHECK_NULL(object) ([object isKindOfClass:[NSNull class]]?nil:object)
//空对象 赋予空字符串
#define NullClass(object) (CHECK_NULL(object)?object:@"")
//字符串化
#define NSNumToNSString(object) (CHECK_NULL(object)?[NSString stringWithFormat:@"%@",object]:@"")

#define IsStrClass(reason)   ([reason isKindOfClass:[NSString class]])
#define IsNumberClass(reason)   ([reason isKindOfClass:[NSNumber class]])
#define IsArrayClass(reason)  ([reason isKindOfClass:[NSArray class]])
#define IsDictionaryClass(reason)  ([reason isKindOfClass:[NSDictionary class]])
#define IntToNSString(value)  ([NSString stringWithFormat:@"%ld",value])
#define FloatToNSString(value)  ([NSString stringWithFormat:@"%f",value])

//app delegate
#define DelegateApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#endif /* FBAndTwitterShareCommon_h */
