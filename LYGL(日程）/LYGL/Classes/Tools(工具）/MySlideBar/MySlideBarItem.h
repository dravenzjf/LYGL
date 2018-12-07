//
//  MySlideBarItem.h
//  FDSlideBarDemo
//
//  Created by fergusding on 15/6/4.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FDSlideBarItemDelegate;

@interface MySlideBarItem : UIView

@property (assign, nonatomic) BOOL selected;
@property (weak, nonatomic) id<FDSlideBarItemDelegate> delegate;


- (void)setItemTitle:(NSString *)title;
- (void)setItemTitleFont:(CGFloat)fontSize;
- (void)setItemTitleColor:(UIColor *)color;
- (void)setItemSelectedTileFont:(CGFloat)fontSize;
- (void)setItemSelectedTitleColor:(UIColor *)color;

+ (CGFloat)widthForTitle:(NSString *)title margin:(CGFloat) margin;

@end

@protocol FDSlideBarItemDelegate <NSObject>

- (void)slideBarItemSelected:(MySlideBarItem *)item;

@end
