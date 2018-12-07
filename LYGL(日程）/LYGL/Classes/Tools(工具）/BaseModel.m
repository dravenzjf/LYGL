//
//  BaseModel.m
//  test_interface
//
//  Created by sjl on 2018/10/19.
//  Copyright © 2018年 betterMan. All rights reserved.
//

#import "BaseModel.h"

@implementation NSString(Format)
- (NSString *)formatDate {
    // 检查字符串是否为空
    if (self == nil || !self.length) {
        return nil;
    }
    
    // 设置输入格式
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    inputFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *formatDate = [inputFormatter dateFromString:self];
    
    // 设置输出格式
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    outputFormatter.dateFormat = @"MM月dd日";
    
    return [outputFormatter stringFromDate:formatDate];
}


@end

@implementation BaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self=[super init]) {
        // 检查是否是空的或不是字典
        if(dictionary == nil || ![dictionary isKindOfClass:[NSDictionary class]]) {
            [self setValuesForKeysWithDictionary:@{}];
            return self;
        }
        
        
        // 检查是否存在空的元素,如果存在NSNull 自动转换为 @""
        
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
#pragma mark 重写方法,防止报错
}

- (void)setNilValueForKey:(NSString *)key{
    
}

// 重写打印描述
-(NSString *)description {
    NSString *str = [NSString stringWithFormat:@"<%@>:%@",[self class],[self getAllPropertiesNameAndValue]];
    return str;
}

@end
