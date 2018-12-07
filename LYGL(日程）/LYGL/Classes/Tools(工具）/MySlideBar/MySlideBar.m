//
//  MySlideBar.m
//  FDSlideBarDemo
//
//  Created by fergusding on 15/6/4.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "MySlideBar.h"
#import "MySlideBarItem.h"

#define DEVICE_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define DEFAULT_SLIDER_COLOR [UIColor orangeColor]
#define SLIDER_VIEW_HEIGHT 2


@implementation NSString (size)

- (CGSize)stringSizeWithFontSize:(NSInteger)fontSize {
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    CGSize size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    size.width = ceil(size.width);
    size.height = ceil(size.height);

    return size;
}
@end

@interface MySlideBar () <FDSlideBarItemDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) UIView *sliderView;

@property (strong, nonatomic) MySlideBarItem *selectedItem;
@property (strong, nonatomic) LANSlideBarPageViewScrolledCallback callback;
@property (nonatomic, retain) UIScrollView *pageScrollView;

@property (nonatomic, retain) NSArray *pageViewArray;

@end

@implementation MySlideBar

#pragma mark - Lifecircle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        _items = [NSMutableArray array];
        [self initItemScrollView];
        [self initSliderView];
        [self initPageScrollView];
    }
    return self;
}

#pragma - mark Custom Accessors

- (void)setItemsTitle:(NSArray *)itemsTitle {
    _itemsTitle = itemsTitle;
    [self setupItems];
}

- (void)setItemColor:(UIColor *)itemColor {
    for (MySlideBarItem *item in _items) {
        [item setItemTitleColor:itemColor];
    }
}

- (void)setItemSelectedColor:(UIColor *)itemSelectedColor {
    for (MySlideBarItem *item in _items) {
        [item setItemSelectedTitleColor:itemSelectedColor];
    }
}

- (void)setSliderColor:(UIColor *)sliderColor {
    _sliderColor = sliderColor;
    self.sliderView.backgroundColor = _sliderColor;
}

- (void)setSelectedItem:(MySlideBarItem *)selectedItem {
    _selectedItem.selected = NO;
    _selectedItem = selectedItem;
}




#pragma - mark Private

- (void)initItemScrollView {
    _itemScrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    _itemScrollView.backgroundColor = [UIColor clearColor];
    _itemScrollView.showsHorizontalScrollIndicator = NO;
    _itemScrollView.showsVerticalScrollIndicator = NO;
    _itemScrollView.bounces = NO;
    [self addSubview:_itemScrollView];
}

- (void)initSliderView {
    _sliderView = [[UIView alloc] init];
    _sliderColor = DEFAULT_SLIDER_COLOR;
    _sliderView.backgroundColor = _sliderColor;
    [_itemScrollView addSubview:_sliderView];
}

-(void)initPageScrollView {
    self.pageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.itemScrollView.bottomY, self.width, self.height - self.itemScrollView.bottomY)];
    self.pageScrollView.contentSize = CGSizeMake(self.width * [self itemsTitle].count,0);
    self.pageScrollView.backgroundColor = [UIColor whiteColor];
    self.pageScrollView.pagingEnabled = YES;
    self.pageScrollView.delegate = self;
    self.pageScrollView.bounces = false;
    self.pageScrollView.showsHorizontalScrollIndicator = false;
    self.pageScrollView.showsVerticalScrollIndicator = false;
    [self addSubview:self.pageScrollView];
}

- (void)setupItems {
    CGFloat itemX = 0;
    for (NSString *title in _itemsTitle) {
        MySlideBarItem *item = [[MySlideBarItem alloc] init];
        item.delegate = self;
        // Init the current item's frame
        CGFloat itemW = [MySlideBarItem widthForTitle:title margin:_margin];
        item.frame = CGRectMake(itemX, 0, itemW, CGRectGetHeight(_itemScrollView.frame));
        [item setItemTitle:title];
        [_items addObject:item];
        
        [_itemScrollView addSubview:item];
        
        // Caculate the origin.x of the next item
        itemX = CGRectGetMaxX(item.frame);
    }
    
    // Cculate the scrollView 's contentSize by all the items
    _itemScrollView.contentSize = CGSizeMake(itemX, CGRectGetHeight(_itemScrollView.frame));


    // Set the default selected item, the first item
    MySlideBarItem *firstItem = [self.items firstObject];
    firstItem.selected = YES;
    _selectedItem = firstItem;
    
    
    if (self.sliderWidth==0) {
        self.sliderWidth = firstItem.frame.size.width;
    }

    // Set the frame of sliderView by the selected item
    _sliderView.frame = CGRectMake(0, self.itemScrollView.frame.size.height - SLIDER_VIEW_HEIGHT, self.sliderWidth , SLIDER_VIEW_HEIGHT);
}

- (void)scrollToVisibleItem:(MySlideBarItem *)item {
    NSInteger selectedItemIndex = [self.items indexOfObject:_selectedItem];
    NSInteger visibleItemIndex = [self.items indexOfObject:item];
    
    // If the selected item is same to the item to be visible, nothing to do
    if (selectedItemIndex == visibleItemIndex) {
        return;
    }
    
    CGPoint offset = _itemScrollView.contentOffset;
    
    // If the item to be visible is in the screen, nothing to do
    if (CGRectGetMinX(item.frame) >= offset.x && CGRectGetMaxX(item.frame) <= (offset.x + CGRectGetWidth(_itemScrollView.frame))) {
        return;
    }
    
    // Update the scrollView's contentOffset according to different situation
    if (selectedItemIndex < visibleItemIndex) {
        // The item to be visible is on the right of the selected item and the selected item is out of screeen by the left, also the opposite case, set the offset respectively
        if (CGRectGetMaxX(_selectedItem.frame) < offset.x) {
            offset.x = CGRectGetMinX(item.frame);
        } else {
            offset.x = CGRectGetMaxX(item.frame) - CGRectGetWidth(_itemScrollView.frame);
        }
    } else {
        // The item to be visible is on the left of the selected item and the selected item is out of screeen by the right, also the opposite case, set the offset respectively
        if (CGRectGetMinX(_selectedItem.frame) > (offset.x + CGRectGetWidth(_itemScrollView.frame))) {
            offset.x = CGRectGetMaxX(item.frame) - CGRectGetWidth(_itemScrollView.frame);
        } else {
            offset.x = CGRectGetMinX(item.frame);
        }
    }
    _itemScrollView.contentOffset = offset;
}

- (void)addAnimationWithSelectedItem:(MySlideBarItem *)item {
    // Caculate the distance of translation
    CGFloat dx = CGRectGetMidX(item.frame) - CGRectGetMidX(_selectedItem.frame);
    
    // Add the animation about translation
    CABasicAnimation *positionAnimation = [CABasicAnimation animation];
    positionAnimation.keyPath = @"position.x";
    positionAnimation.fromValue = @(_sliderView.layer.position.x);
    positionAnimation.toValue = @(_sliderView.layer.position.x + dx);
    
    // Add the animation about size
    CABasicAnimation *boundsAnimation = [CABasicAnimation animation];
    boundsAnimation.keyPath = @"bounds.size.width";
    boundsAnimation.fromValue = @(CGRectGetWidth(_sliderView.layer.bounds));
    boundsAnimation.toValue = @(CGRectGetWidth(item.frame));
    
    // Combine all the animations to a group
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[positionAnimation, boundsAnimation];
    animationGroup.duration = 0.2;
    [_sliderView.layer addAnimation:animationGroup forKey:@"basic"];
    
    // Keep the state after animating
    _sliderView.layer.position = CGPointMake(_sliderView.layer.position.x + dx, _sliderView.layer.position.y);
    CGRect rect = _sliderView.layer.bounds;
    rect.size.width = CGRectGetWidth(item.frame);
    _sliderView.layer.bounds = rect;
}


#pragma mark - Public

- (void)slideBarPageScrollCallback:(LANSlideBarPageViewScrolledCallback)callback {
    _callback = callback;
}

// item被点击,滚动到对应的View
- (void)scrollToPage:(NSUInteger)index {
    MySlideBarItem *item = [self.items objectAtIndex:index];
    if (item == _selectedItem) {
        return;
    }

    item.selected = YES;
    [self scrollToVisibleItem:item];
    [self addAnimationWithSelectedItem:item];
    self.selectedItem = item;

    [self.pageScrollView setContentOffset:CGPointMake(self.pageScrollView.bounds.size.width * index, 0) animated:true];
}


- (void)setItemsTitle:(NSArray *)itemsTitle pageViews:(NSArray *)pageViews autoMargin:(BOOL)autoMargin {
    if(autoMargin) {
        // 如果需要自动计算间隙
        //计算item之间的宽度
        CGFloat fullWith = 0;
        for (NSString *title in itemsTitle) {
            fullWith += [title stringSizeWithFontSize:15].width;
        }
        if([UIScreen mainScreen].bounds.size.width - fullWith >= 15){
            self.margin = ([UIScreen mainScreen].bounds.size.width - fullWith) / (itemsTitle.count * 2);
        } else{
            self.margin = 15;
        }

        self.itemsTitle = itemsTitle;

        // 添加View到滚动层
        for (int i = 0; i < pageViews.count; ++i) {
            UIView *view = pageViews[i];

            // 调整frame,放到对应的page上
            view.frame = CGRectMake(self.pageScrollView.width * i, 0, self.pageScrollView.width, self.pageScrollView.height);

            [self.pageScrollView addSubview:view];
        }
        // 重新设置contentSize
        self.pageScrollView.contentSize = CGSizeMake(self.width * [self itemsTitle].count,0);

        self.pageViewArray = pageViews;
    } else {
        // 手动计算margin
        self.itemsTitle = itemsTitle;

        // 添加View到滚动层
        for (int i = 0; i < pageViews.count; ++i) {
            UIView *view = pageViews[i];

            // 调整frame
            CGRect frame = view.frame;
            frame.size.height = self.pageScrollView.height;
            frame.origin.x = self.pageScrollView.width * i;
            frame.origin.y = 0;
            view.frame = frame;

            [self.pageScrollView addSubview:view];
        }
        // 重新设置contentSize
        self.pageScrollView.contentSize = CGSizeMake(self.width * [self itemsTitle].count,0);
        self.pageViewArray = pageViews;
    }
}




#pragma mark - FDSlideBarItemDelegate

- (void)slideBarItemSelected:(MySlideBarItem *)item {
    if (item == _selectedItem) {
        return;
    }
    
    [self scrollToVisibleItem:item];
    [self addAnimationWithSelectedItem:item];
    self.selectedItem = item;

    [self.pageScrollView setContentOffset:CGPointMake(self.pageScrollView.bounds.size.width * [self.items indexOfObject:item], 0) animated:true];

    if(self.callback){
        NSInteger page = [self.items indexOfObject:item];
        _callback(self.pageViewArray[page],page);
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int pageCount = self.pageScrollView.contentOffset.x/self.pageScrollView.bounds.size.width;
    // Select the relating item when scroll the tableView by paging.
    [self scrollToPage:pageCount];
}

@end
