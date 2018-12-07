//
//  NSDate+Formatter.m
//  LANCategory
//
//  Created by 蓝布鲁 on 2017/12/20.
//  Copyright © 2017年 蓝布鲁. All rights reserved.
//

#import "NSDate+Formatter.h"

@implementation NSDate (Formatter)
- (NSString *)stringDateFromFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    return [dateFormatter stringFromDate:self];
}
@end
