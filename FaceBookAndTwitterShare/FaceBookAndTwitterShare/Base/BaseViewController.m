//
//  BaseViewController.m
//  FaceBookAndTwitterShare
//
//  Created by 习武 on 2018/2/24.
//  Copyright © 2018年 习武. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setAutomaticallyAdjustsScrollView:(UIScrollView *)scrollView{
    if (@available(iOS 11.0, *)) {
        if(scrollView)scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)common_closeEstimatedHeightTableView:(UITableView *)tableView{
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
