//
//  ShareManagerImprovePlateForm.h
//  house591
//
//  Created by xiwu on 17/1/16.
//
//

#import "BaseModel.h"
#import "ShareHousePlateFormType.h"

@interface ShareManagerImprovePlateForm : BaseModel

//判断本地是否安装对应平台
+ (BOOL)isInstall:(ShareHousePlateFormType)type;

@end
