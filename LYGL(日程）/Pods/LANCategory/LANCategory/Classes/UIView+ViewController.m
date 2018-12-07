//
//  UIView+ViewController.m
//  LANCategory
//
//  Created by 蓝布鲁 on 2017/12/11.
//  Copyright © 2017年 蓝布鲁. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)
- (UIViewController *)viewController
{
  id target=self;
  while (target) {
    target = ((UIResponder *)target).nextResponder;
    if ([target isKindOfClass:[UIViewController class]]) {
      break;
    }
  }
  return target;
}

- (UINavigationController *)navigationController {
  return [self viewController].navigationController;
}

@end
