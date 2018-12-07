//
//  NSString+Size.h
//  ImHere
//
//  Created by 卢明渊 on 15-3-9.
//  Copyright (c) 2015年 我在这. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (Category)

//计算高度,限制width
- (CGFloat) heightWithFont:(UIFont*) font width:(CGFloat) width;

// 计算宽度
-(CGFloat)widthWithFont:(UIFont *)font;

//MD5加密
- (NSString *)MD5String;

//sha1加密
- (NSString *) sha1String;

// 转换日期
- (NSString *)formatDateWithInputFormat:(NSString *)inputformat outputFormat:(NSString *)outputFormat;
@end

