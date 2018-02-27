//
//  SharePopView.h
//  house591
//
//  Created by xiwu on 17/1/16.
//
//

#import "BaseView.h"
#import "ShareHousePlateFormType.h"

@protocol VTingPopItemSelectDelegate <NSObject>

//点击item代理
- (void)itemDidSelected:(NSInteger)index;

@end

@interface SharePopView : BaseView

@property (nonatomic, assign) id<VTingPopItemSelectDelegate> delegate;

//模糊效果视图，已放弃但未删除
@property (nonatomic, strong) UIView *backGroundView;

//弹出的左边视图
@property (nonatomic, strong) UIView *contentViewLeft;

/**
 ***图片地址***
 **/
@property (nonatomic, copy) NSString *imageUrl;

/**
 初始化方法
 @param models 对象数组，不可为空
 @return 对象
 */
-(instancetype)initWithButtonModels:(NSArray *)models;
/**
 显示
 */
-(void)show;

@end
