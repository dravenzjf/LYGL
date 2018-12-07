//
//  UIViewController+Navigation.m
//  LANCategory
//
//  Created by 蓝布鲁 on 2017/12/12.
//  Copyright © 2017年 蓝布鲁. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)
- (void)setTitle:(NSString *)title subTitle:(NSString *)subTitle{
    UIColor *textColor = self.navigationController.navigationBar.titleTextAttributes[NSForegroundColorAttributeName];

    CGRect headerTitleSubtitleFrame = CGRectMake(0, 0, 200, 44);
    UIView* _headerTitleSubtitleView = [[UILabel alloc] initWithFrame:headerTitleSubtitleFrame];
    _headerTitleSubtitleView.backgroundColor = [UIColor clearColor];
    _headerTitleSubtitleView.autoresizesSubviews = YES;

    CGRect titleFrame = CGRectMake(0, 2, 200, 24);
    UILabel *titleView = [[UILabel alloc] initWithFrame:titleFrame];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.textColor = textColor;
    titleView.text = title;
    titleView.adjustsFontSizeToFitWidth = YES;
    [_headerTitleSubtitleView addSubview:titleView];

    CGRect subtitleFrame = CGRectMake(0, 24, 200, 44-24);
    UILabel *subtitleView = [[UILabel alloc] initWithFrame:subtitleFrame];
    subtitleView.backgroundColor = [UIColor clearColor];
    subtitleView.font = [UIFont boldSystemFontOfSize:11];
    subtitleView.textAlignment = NSTextAlignmentCenter;
    subtitleView.textColor = textColor;
    subtitleView.text = subTitle;
    subtitleView.adjustsFontSizeToFitWidth = YES;
    [_headerTitleSubtitleView addSubview:subtitleView];

    _headerTitleSubtitleView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
            UIViewAutoresizingFlexibleRightMargin |
            UIViewAutoresizingFlexibleTopMargin |
            UIViewAutoresizingFlexibleBottomMargin);

    self.navigationItem.titleView = _headerTitleSubtitleView;

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @"返回";
    self.navigationItem.backBarButtonItem = backButton;
}@end
