//
//  MySlideBar.h
//  FDSlideBarDemo
//
//  Created by fergusding on 15/6/4.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LANSlideBarPageViewScrolledCallback)(UIView *view, NSInteger page);

@interface MySlideBar : UIView

// All the titles of FDSilderBar
@property (copy, nonatomic) NSArray *itemsTitle;

// All the item's text color of the normal state
@property (strong, nonatomic) UIColor *itemColor;

// The selected item's text color
@property (strong, nonatomic) UIColor *itemSelectedColor;

// The slider color
@property (strong, nonatomic) UIColor *sliderColor;

// 标签之间的宽度
@property (nonatomic, assign) CGFloat margin;

// item滚动层
@property (strong, nonatomic) UIScrollView *itemScrollView;

//滑条长度
@property(nonatomic,assign)NSInteger sliderWidth;

// Add the callback deal when a slide bar item be selected
- (void)slideBarPageScrollCallback:(LANSlideBarPageViewScrolledCallback)callback;

// Set the slide bar item at index to be selected
- (void)scrollToPage:(NSUInteger)index;




/**
 * @brief 推荐使用的方法,自动设置sliderBar
 *
 * @param  itemsTitle item的标题数组
 *
 * @param  pageViews 标题对应的View,要与item个数一致
 * 注意!!! sliderBar会自动设置View的frame,所以请重写-setFrame:方法,以布局需要用到view的frame的view
 *
 * @param  autoMargin 是否自动设置item之间的间隔
 *
 */
-(void)setItemsTitle:(NSArray *)itemsTitle pageViews:(NSArray *)pageViews autoMargin:(BOOL)autoMargin;


@end
