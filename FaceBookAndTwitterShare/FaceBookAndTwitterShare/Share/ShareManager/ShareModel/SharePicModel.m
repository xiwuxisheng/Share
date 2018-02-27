//
//  SharePicModel.m
//  house591
//
//  Created by xiwu on 17/1/16.
//
//

#import "SharePicModel.h"

@implementation SharePicModel

- (instancetype)initWithTitle:(NSString *)title image:(NSString *)plateImage type:(ShareHousePlateFormType)type{
    self = [super init];
    if (self) {
        if (!title) {
            title = @"";
        }
        if (!plateImage) {
            plateImage = @"3";
        }
        self.plateTitle = title;
        self.plateImageName = plateImage;
        _type = type;
    }
    return self;
}

@end
