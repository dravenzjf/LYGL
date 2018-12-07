//
//  XQSettingItem.h
//  Mine
//
//  Created by Ticsmatic on 2017/10/12.
//  Copyright © 2017年 Ticsmatic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 基于plist的字段模型，通常情况下，继承此模型，填加自己的服务器数据字段
 */
@interface XQSettingItem : NSObject

@property(nonatomic, assign) CGFloat height;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detailText;

@property (nonatomic, assign) BOOL hasAttributeDetail;

@property (nonatomic, assign) BOOL hasSwitch;
@property (nonatomic, assign) BOOL switchStatus;
@property (nonatomic, copy) NSString *switchActionName;

@property (nonatomic, assign) BOOL hasRightArrow;

@property (nonatomic, copy) NSString *selectActionName;

/// 自己重新定义一个Cell
@property (nonatomic, assign) BOOL custom;
@property (nonatomic, copy) NSString *customReuseID;
@end



@interface XQSettingSection : NSObject

@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *footer;
@property (nonatomic, strong) NSMutableArray<XQSettingItem *> *items;

@end
