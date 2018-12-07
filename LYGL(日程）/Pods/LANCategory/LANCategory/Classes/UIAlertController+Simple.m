//
//  UIAlertController+Simple.m
//  LANCategory
//
//  Created by 蓝布鲁 on 2017/12/20.
//  Copyright © 2017年 蓝布鲁. All rights reserved.
//

#import "UIAlertController+Simple.h"

@implementation UIAlertController (Simple)

+ (instancetype)alertControllerWithTitle:(NSString *)title
                                 message:(NSString *)message
                            cancelTapped:(void (^)())cancelTapped
                              doneTapped:(void (^)())doneTapped {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    if (doneTapped) {
        UIAlertAction *done = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            doneTapped();
        }];
        [alert addAction:done];
    }
    if (cancelTapped) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            cancelTapped();
        }];
        [alert addAction:cancel];
    }
    return alert;
}

- (void)showWithCompletion:(void (^)())completion {
    [[self _getCurrentVC] presentViewController:self animated:YES completion:completion];
}

- (UIViewController *)_getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;

    return rootViewController;
}


@end
