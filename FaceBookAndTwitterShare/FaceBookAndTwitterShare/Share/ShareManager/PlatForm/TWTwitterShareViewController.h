//
//  TWTwitterShareViewController.h
//  house591
//
//  Created by 习武 on 2017/10/30.
//

#import "BaseViewController.h"

@interface TWTwitterShareViewController : BaseViewController

//请求的url
@property (nonatomic, copy) NSString *orginUrl;
//web的标题
@property (nonatomic, copy) NSString *orginTitle;
//title是否根据Html的title变化
@property (nonatomic, assign) BOOL isChangeTitleByHtml;
//网页webView
@property (nonatomic, strong) UIWebView *webView;

@property(nonatomic,copy)void(^TWTwitterShareViewControllerShareBlock)(BOOL result);

/**
 *  初始化一个web控制器
 *
 *  @param url          url
 *  @param webTitle     需要显示的webview控制器的title
 *  @param isNeedChange 控制器上面的标题是否需要根据Html的title改变
 */
- (instancetype)initWithURL:(NSString *)url
                   webTitle:(NSString *)webTitle
        isChangeTitleByHtml:(BOOL)isNeedChange;

@end
