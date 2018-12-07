//
//  XQSettingItem.m
//  Mine
//
//  Created by Ticsmatic on 2017/10/12.
//  Copyright © 2017年 Ticsmatic. All rights reserved.
//

#import "XQSettingItem.h"

@implementation XQSettingItem

@end



@implementation XQSettingSection
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items" : [XQSettingItem class]};
}
@end
