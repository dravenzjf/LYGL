//
//  BaseModel.h
//  test_interface
//
//  Created by sjl on 2018/10/19.
//  Copyright © 2018年 betterMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+LAN.h"

// 用于字符串格式化  "yyyy-MM-dd" --> "MM月dd日"
@interface NSString(Format)

-(NSString *)formatDate;

@end

@interface BaseModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
