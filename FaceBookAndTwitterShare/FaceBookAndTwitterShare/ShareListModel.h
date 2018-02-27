//
//  ShareListModel.h
//  FaceBookAndTwitterShare
//
//  Created by 习武 on 2018/2/24.
//  Copyright © 2018年 习武. All rights reserved.
//

#import "BaseModel.h"
#import "ShareHousePlateFormType.h"

@interface ShareListModel : BaseModel

@property (nonatomic, copy) NSString *plateTitle;

@property (nonatomic, assign) ShareHousePlateFormType type;

@property (nonatomic, copy) NSString *shareContent;

@end
