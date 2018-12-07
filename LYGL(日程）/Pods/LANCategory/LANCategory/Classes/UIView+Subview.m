//
//  UIView+Subview.m
//  LANCategory
//
//  Created by 蓝布鲁 on 2017/12/6.
//  Copyright © 2017年 蓝布鲁. All rights reserved.
//

#import "UIView+Subview.h"

@implementation UIView (Subview)

- (void)removeAllSubviews {
    NSArray *subviews = self.subviews;
    for(UIView *view in subviews){
        [view removeFromSuperview];
    }
}

- (void)removeSubViewWithTag:(NSInteger)tag {
    UIView *subView = [self viewWithTag:tag];
    if(subView){
        [subView removeFromSuperview];
    }
}


@end
