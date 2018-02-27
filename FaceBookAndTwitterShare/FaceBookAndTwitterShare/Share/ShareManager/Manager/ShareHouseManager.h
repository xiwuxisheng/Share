//
//  ShareHouseManager.h
//  house591
//
//  Created by xiwu on 17/1/16.
//
//

#import "BaseModel.h"
#import "ShareHousePlateFormType.h"

@interface ShareHouseManager : BaseModel

//構建單例模式對象
+ (instancetype)shareInstance;

@property(nonatomic,assign)ShareHousePlateFormType currentType;

@property(nonatomic,copy)void(^ClickShareItem)(ShareHousePlateFormType type);

//注册相应的平台
- (void)registerPlateForms:(NSArray *)plateTypes;

- (void)shareItem:(UIView *)view;

@end
