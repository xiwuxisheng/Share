//
//  TWTwitterShareViewController.m
//  house591
//
//  Created by 习武 on 2017/10/30.
//

#import "TWTwitterShareViewController.h"

#define TWTwitterShareViewController_ShareCompelete @"twitter.com/intent/tweet/complete"
#define TWTwitterShareViewController_ShareStatus @"twitter.com/intent/tweet"

@interface TWTwitterShareViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@end

@implementation TWTwitterShareViewController

#pragma mark - init
- (instancetype)initWithURL:(NSString *)url
                   webTitle:(NSString *)webTitle
        isChangeTitleByHtml:(BOOL)isNeedChange{
    if (self = [super init]){
        _orginTitle = NullClass(webTitle);
        _isChangeTitleByHtml = isNeedChange;
        self.title = NullClass(_orginTitle);
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - UI
- (void)initUI{
    [self initWebView];
}

//添加所有的子控件
- (void)initWebView{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    webView.scrollView.delegate = self;//监听偏移值.
    webView.delegate = self;
    self.webView = webView;
    [self setAutomaticallyAdjustsScrollView:self.webView.scrollView];
    [self loadWebViewResquest:_orginUrl];
    [self.view addSubview:self.webView];
}


- (void)loadWebViewResquest:(NSString *)urlStr{
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:self.webView.request];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0f];
    [self.webView loadRequest:request];
}


#pragma mark - 獲取請求
- (NSString *)getCurrentRequestUrl:(NSURLRequest *)request{
    NSString *urlString = @"";
    if (request) {
        if (request&&request.URL) {
            urlString =  [request.URL absoluteString];
        }
        if (!urlString) {
            urlString = @"";
        }
    }
    return urlString;
}

#pragma mark -- 填充数据
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *urlString = [self getCurrentRequestUrl:webView.request];
    if([urlString rangeOfString:TWTwitterShareViewController_ShareCompelete].location!=NSNotFound){
        if (_TWTwitterShareViewControllerShareBlock) {
            _TWTwitterShareViewControllerShareBlock(YES);
            [self closeBtnClick];
        }
    }
}

#pragma mark -- 关闭action
- (void)closeBtnClick{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 页面加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSString *urlString = [self getCurrentRequestUrl:webView.request];
    if([urlString rangeOfString:TWTwitterShareViewController_ShareStatus].location!=NSNotFound){
        if (_TWTwitterShareViewControllerShareBlock) {
            _TWTwitterShareViewControllerShareBlock(NO);
            [self closeBtnClick];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
