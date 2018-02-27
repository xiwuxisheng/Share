//
//  BaseViewController.h
//  FaceBookAndTwitterShare
//
//  Created by 习武 on 2018/2/24.
//  Copyright © 2018年 习武. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 禁止scrollView自适应显示高度
 @param scrollView scrollView及其子类
 */
- (void)setAutomaticallyAdjustsScrollView:(UIScrollView *)scrollView;


/**
 默认关闭估算高度(防止在ios11上出现列表显示动画)
 @param tableView 列表
 */
- (void)common_closeEstimatedHeightTableView:(UITableView *)tableView;

@end
