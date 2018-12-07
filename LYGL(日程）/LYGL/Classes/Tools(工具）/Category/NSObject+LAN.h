//
//  NSObject+LAN.h
//  test_interface
//
//  Created by sjl on 2018/10/19.
//  Copyright © 2018年 betterMan. All rights reserved.
//
//类型Category只能加方法不能加属性
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (LAN)
/**
 * @brief 获取对象的所有属性，不包括属性值
 */
- (NSArray *)getAllPropertiesName;

/**
 * @brief 获取对象的所有属性 以及属性值
 */
- (NSDictionary *)getAllPropertiesNameAndValue;

/**
 * @brief 打印对象的所有方法
 */
-(void)printMethodList;

@end
