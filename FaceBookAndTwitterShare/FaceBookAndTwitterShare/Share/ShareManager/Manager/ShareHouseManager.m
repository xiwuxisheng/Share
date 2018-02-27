//
//  ShareHouseManager.m
//  house591
//
//  Created by xiwu on 17/1/16.
//
//

#import "ShareHouseManager.h"
#import "ShareHousePlateFormType.h"
#import "ShareDefaultPlatForms.h"
#import "SharePicModel.h"
#import "SharePopView.h"

@interface ShareHouseManager() <VTingPopItemSelectDelegate>

@property(nonatomic,copy)NSArray *usedPlateForms;

@end

static ShareHouseManager *instance = nil;
@implementation ShareHouseManager

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

- (void)registerPlateForms:(NSArray *)plateTypes{
    if (plateTypes&&plateTypes.count>0) {
        self.usedPlateForms = [ShareDefaultPlatForms getUsedPlatForms:plateTypes];
    }else{
        self.usedPlateForms = [ShareDefaultPlatForms getDefaultPlatForms];
    }
}

- (void)shareItem:(UIView *)view{
    if (!view) {
        return;
    }
    SharePopView *popView = [[SharePopView alloc] initWithButtonModels:self.usedPlateForms];
    [view addSubview:popView];
    popView.delegate = self;
    [popView show];
}

#pragma mark delegate
-(void)itemDidSelected:(NSInteger)index {
    NSLog(@"点击了%ld:item",index);
    _ClickShareItem(index);
}

@end
