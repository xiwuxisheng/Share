//
//  ShareTool.h
//  house591
//
//  Created by 郑泽钦 on 16/9/10.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ShareHousePlateFormType.h"

@interface ShareTool : NSObject

+ (instancetype)instanceShareTool;
/**
 *  初始化分享对象
 *
 *  @param context 内容
 *  @param title   标题
 *  @param url     连接地址
 *  @param imgUrl  图片地址
 *
 *  @return 返回对象
 */
- (instancetype)initWithContext:(NSString *)context
                          title:(NSString *)title
                       shareUrl:(NSString *)url
                         imgUrl:(NSString *)imgUrl;

/**
 *  配置分享内容
 *
 *  @param context 内容
 *  @param title   标题
 *  @param url     连接地址
 *  @param imgUrl  图片地址
 */
- (void)shareContext:(NSString *)context
               title:(NSString *)title
            shareUrl:(NSString *)url
              imgUrl:(NSString *)imgUrl;

//分享操作
- (void)shareActionInVC:(UIViewController *)vc
                success:(void(^)(BOOL isSuccess,NSString *result))block;
//facebook分享
- (void)shareFaceBook:(UIViewController *)vc success:(void(^)(BOOL isSuccess,NSString *result))block;
//line分享
- (void)shareWithLine;
//twitter分享
- (void)shareSystemTwitter:(UIViewController *)vc success:(void(^)(BOOL isSuccess,NSString *result))block;
@end
