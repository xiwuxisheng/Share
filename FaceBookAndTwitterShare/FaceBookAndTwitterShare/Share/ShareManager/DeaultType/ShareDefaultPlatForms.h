//
//  ShareDefaultPlatForms.h
//  house591
//
//  Created by xiwu on 17/1/16.
//
//

#import "BaseModel.h"

@interface ShareDefaultPlatForms : BaseModel

+ (NSArray *)getDefaultPlatForms;

+ (NSArray *)getUsedPlatForms:(NSArray *)plateTypes;

@end
