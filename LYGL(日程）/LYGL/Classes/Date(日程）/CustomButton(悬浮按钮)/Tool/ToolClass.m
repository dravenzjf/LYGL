//
//  ToolClass.m
//  CustomButtonVC
//
//  Created by 栗子 on 2018/6/13.
//  Copyright © 2018年 http://www.cnblogs.com/Lrx-lizi/.     https://github.com/lrxlizi/     https://blog.csdn.net/qq_33608748. All rights reserved.
//

#import "ToolClass.h"

@implementation ToolClass

//设置毛玻璃效果
+(void)blurEffect:(UIView *)view{
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectVIew = [[UIVisualEffectView alloc]initWithEffect:effect];
    effectVIew.frame = view.bounds;
    [view addSubview:effectVIew];
    
}

@end
