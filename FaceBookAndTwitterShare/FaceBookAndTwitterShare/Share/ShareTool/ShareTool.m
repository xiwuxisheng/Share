//
//  ShareTool.m
//  house591
//
//  Created by 郑泽钦 on 16/9/10.
//
//

#import "ShareTool.h"
 #import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "ShareHouseManager.h"
#import "ShareManagerImprovePlateForm.h"
#import <Social/Social.h>
#import "AppDelegate.h"
#import "TWTwitterShareViewController.h"

@interface ShareTool()
//标题
@property (nonatomic,copy) NSString *title;
//内容
@property (nonatomic,copy) NSString *context;
//图片网址
@property (nonatomic,copy) NSString *imagePath;
//网址
@property (nonatomic,copy) NSString *url;
//分享的图片
@property (nonatomic,strong) UIImage *shareImg;

@property(nonatomic,copy)void(^block)(BOOL isSuccess,NSString *result);

@end

@implementation ShareTool

+ (instancetype)instanceShareTool{
    
    static dispatch_once_t once;
    static ShareTool*singleton;
    dispatch_once(&once, ^ {
        singleton = [[ShareTool alloc] init];
    });
    return singleton;
}

- (instancetype)initWithContext:(NSString *)context
                          title:(NSString *)title
                       shareUrl:(NSString *)url
                         imgUrl:(NSString *)imgUrl{
    if (self = [super init]) {
        self.title = title;
        self.context = context;
        self.imagePath = imgUrl;
        self.url = url;
    }
    return self;
}


- (void)shareContext:(NSString *)context
               title:(NSString *)title
            shareUrl:(NSString *)url
              imgUrl:(NSString *)imgUrl{
    self.title = title;
    self.context = context;
    self.imagePath = imgUrl;
    self.url = url;
}

- (void)shareActionInVC:(UIViewController *)vc
                success:(void(^)(BOOL isSuccess,NSString *result))block{
    if (!self.context.length || !self.url.length) {
        NSLog(@"没有配置分享内容!!!");
        return;
    }
    if (!vc) {
         vc = DelegateApp.window.rootViewController;
    }
    _block = block;
    [[ShareHouseManager shareInstance] registerPlateForms:@[@(ShareHousePlateFormTypeLine),@(ShareHousePlateFormTypeFB),@(ShareHousePlateFormTypeTwitter),@(ShareHousePlateFormTypeCopy)]];
    [[ShareHouseManager shareInstance] shareItem:vc.view];
    [ShareHouseManager shareInstance].ClickShareItem = ^(ShareHousePlateFormType type){
        if (type==ShareHousePlateFormTypeLine) {
            [self shareWithLine];
        }else  if (type==ShareHousePlateFormTypeFB) {
            [self shareFaceBook:vc success:block];
        }else  if (type==ShareHousePlateFormTypeTwitter) {
            [self shareSystemTwitter:vc success:^(BOOL isSuccess, NSString *result) {
                block(isSuccess,result);
            }];
        }else  if (type==ShareHousePlateFormTypeCopy) {
            [self pasteStoryBoard:vc];
        }
    };
}

//FB原生分享
- (void)shareFaceBook:(UIViewController *)vc success:(void(^)(BOOL isSuccess,NSString *result))block{
    FBSDKShareLinkContent *FBSDKContent = [[FBSDKShareLinkContent alloc] init];
    FBSDKContent.contentURL = [NSURL URLWithString:self.url];
//    FBSDKContent.contentTitle = self.title;
//    FBSDKContent.contentDescription = self.context;
//    if (![HouseValidateTool isEmpty:self.imagePath]&&[HouseValidateTool isPureUrl:self.imagePath]&&[HouseValidateTool isImagePureUrl:self.imagePath]) {
//        FBSDKContent.imageURL = [NSURL URLWithString:self.imagePath];
//    }
    FBSDKShareDialog *dialog = [FBSDKShareDialog new];
    if([ShareManagerImprovePlateForm isInstall:ShareHousePlateFormTypeFB]){
        [dialog setMode:FBSDKShareDialogModeNative];
    }else{
        [dialog setMode:FBSDKShareDialogModeAutomatic];
    }
    [dialog setFromViewController:vc];
    [dialog setShareContent:FBSDKContent];
    [dialog show];
}

//Line只能分享文字(原生)
- (void)shareWithLine{
    NSString *urlTextString = [NSString stringWithFormat:@"line://msg/text/%@",[self.context stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlTextString]];
}

//twitter分享
- (void)shareSystemTwitter:(UIViewController *)vc success:(void(^)(BOOL isSuccess,NSString *result))block{
    if (!vc) {
        vc = DelegateApp.window.rootViewController;
    }
    if (@available(iOS 11.0, *)) {
        TWTwitterShareViewController *webVc = [[TWTwitterShareViewController alloc] initWithURL:[NSString stringWithFormat:@"https:/twitter.com/share?url=%@&text=%@",[NullClass(self.url) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[NullClass(self.context) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] webTitle:@"twitter分享" isChangeTitleByHtml:YES];
        webVc.TWTwitterShareViewControllerShareBlock = ^(BOOL result) {
            if (result ) {
                block(YES,@"分享成功");
                NSLog(@"分享成功");
            }else{
                block(NO,@"分享失敗");
                NSLog(@"分享失敗");
            }
        };
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVc];
        [vc presentViewController:nav animated:YES completion:nil];
        
    }else{
        if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            block(NO,@"twitter未綁定帳號");
            NSLog(@"twitter不可用");
            return;
        }
        // 创建控制器，並设置ServiceType（指定分享平台）
        SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        // 添加要分享的图片,这里添加的图片必须是UIImage类型
//        id image = [UIImage imageNamed:@""];
//        if (image) {
//            [composeVC addImage:image];
//        }
        [composeVC addImage:[UIImage imageNamed:@"ShareImage"]];
        
        // 添加要分享的文字
        [composeVC setInitialText:self.context];
        // 添加要分享的url
        [composeVC addURL:[NSURL URLWithString:self.url]];
        // 弹出分享控制器
        [vc presentViewController:composeVC animated:YES completion:nil];
        NSLog(@"%@------",SLServiceTypeTwitter);
        // 监听用户点击事件
        composeVC.completionHandler = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultDone) {
                block(YES,@"分享成功");
                NSLog(@"分享成功");
            }else if (result == SLComposeViewControllerResultCancelled)
            {
                block(NO,@"取消分享");
                NSLog(@"分享取消");
            }
        };
    }
}

//URL复制
- (void)pasteStoryBoard:(UIViewController *)vc{
    if (!vc) {
        vc = DelegateApp.window.rootViewController;
    }
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.url];
    NSLog(@"內容已複製到剪切板");
}

@end
