//
//  TestShareViewController.m
//  FaceBookAndTwitterShare
//
//  Created by 习武 on 2018/2/24.
//  Copyright © 2018年 习武. All rights reserved.
//

#import "TestShareViewController.h"
#import "ShareListModel.h"
#import "ShareTool.h"

@interface TestShareViewController ()

@end

@implementation TestShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.mj_w-80)/2,100,80,32)];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    shareBtn.backgroundColor = TWColor_2478d2;
    shareBtn.titleLabel.font = SYSFontSize(15);
    shareBtn.layer.masksToBounds = YES;
    shareBtn.layer.cornerRadius = 5.0f;
    [self.view addSubview:shareBtn];
    
    [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)shareAction:(id)sender{
    [[[ShareTool instanceShareTool] initWithContext:@"分享好看的资讯内容，详情请看 http://m.news.baidu.com/news?fr=mohome&ssid=3c9678697368656e6731393931590e&from=&uid=&pu=sz%40320_1001%2Cta%40iphone_2_6.0_3_537&bd_page_type=1" title:@"分享资讯" shareUrl:@"https://m.baidu.com" imgUrl:@"http://pic.58pic.com/58pic/10/97/02/30a58PICH7N.jpg"] shareActionInVC:self  success:^(BOOL isSuccess, NSString *result) {
        if (isSuccess) {
            NSLog(@"分享成功!");
        }else{
            NSLog(@"分享失敗!");
        }
        NSLog(@"%@",result);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
