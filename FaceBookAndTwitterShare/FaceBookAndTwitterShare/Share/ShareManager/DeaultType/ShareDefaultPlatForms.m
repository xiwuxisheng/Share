//
//  ShareDefaultPlatForms.m
//  house591
//
//  Created by xiwu on 17/1/16.
//
//

#import "ShareDefaultPlatForms.h"
#import "ShareHousePlateFormType.h"
#import "SharePicModel.h"
#import "ShareManagerImprovePlateForm.h"

@implementation ShareDefaultPlatForms

+ (NSArray *)getDefaultPlatForms{
    NSMutableArray *plateForms = [NSMutableArray array];
    if ([ShareManagerImprovePlateForm isInstall:ShareHousePlateFormTypeLine]) {
        [plateForms addObject:[[SharePicModel alloc] initWithTitle:@"LINE" image:@"share_line" type:ShareHousePlateFormTypeLine]];
    }
    [plateForms addObject:[[SharePicModel alloc] initWithTitle:@"Facebook" image:@"share_fb" type:ShareHousePlateFormTypeFB]];
    [plateForms addObject:[[SharePicModel alloc] initWithTitle:@"Twitter" image:@"share_twitter" type:ShareHousePlateFormTypeTwitter]];
    [plateForms addObject:[[SharePicModel alloc] initWithTitle:@"複製鏈接" image:@"share_copy" type:ShareHousePlateFormTypeCopy]];
    return plateForms;
}

+ (NSArray *)getUsedPlatForms:(NSArray *)plateTypes{
    NSMutableArray *plateForms = [NSMutableArray array];
    if (plateTypes&&plateTypes.count>0) {
        for (NSNumber *type in plateTypes) {
            if ([type integerValue]==ShareHousePlateFormTypeLine&&[ShareManagerImprovePlateForm isInstall:ShareHousePlateFormTypeLine]) {
                [plateForms addObject:[[SharePicModel alloc] initWithTitle:@"LINE" image:@"share_line" type:ShareHousePlateFormTypeLine]];
            }
            if ([type integerValue]==ShareHousePlateFormTypeFB){
                [plateForms addObject:[[SharePicModel alloc] initWithTitle:@"Facebook" image:@"share_fb" type:ShareHousePlateFormTypeFB]];
            }
            if ([type integerValue]==ShareHousePlateFormTypeTwitter){
                [plateForms addObject:[[SharePicModel alloc] initWithTitle:@"Twitter" image:@"share_twitter" type:ShareHousePlateFormTypeTwitter]];
            }
            if ([type integerValue]==ShareHousePlateFormTypeCopy){
                [plateForms addObject:[[SharePicModel alloc] initWithTitle:@"複製鏈接" image:@"share_copy" type:ShareHousePlateFormTypeCopy]];
            }
        }
    }
    return plateForms;
}

@end
