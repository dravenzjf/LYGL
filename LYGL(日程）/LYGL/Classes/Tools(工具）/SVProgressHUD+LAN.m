//
//  SVProgressHUD+LAN.m
//  test_interface
//
//  Created by sjl on 2018/10/27.
//  Copyright © 2018年 betterMan. All rights reserved.
//

#import "SVProgressHUD+LAN.h"

@implementation SVProgressHUD (LAN)

+ (void)showfailed {
    [self showErrorWithStatus:@"加载失败"];
}
@end
