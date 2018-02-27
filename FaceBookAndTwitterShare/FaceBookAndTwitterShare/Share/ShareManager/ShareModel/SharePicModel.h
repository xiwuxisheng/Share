//
//  SharePicModel.h
//  house591
//
//  Created by xiwu on 17/1/16.
//
//

#import "BaseModel.h"
#import "ShareHousePlateFormType.h"

@interface SharePicModel : BaseModel

@property (nonatomic, copy) NSString *plateTitle;

@property (nonatomic, copy) NSString *plateImageName;

@property (nonatomic, assign) ShareHousePlateFormType type;

- (instancetype)initWithTitle:(NSString *)title image:(NSString *)plateImage type:(ShareHousePlateFormType)type;

@end
