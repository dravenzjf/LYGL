//
//  DeviceManageGlobalDefine.h
//  DeviceManage
//
//  Created by sjl on 2018/11/17.
//  Copyright © 2018年 sjl. All rights reserved.
//

#ifndef DeviceManageGlobalDefine_h
#define DeviceManageGlobalDefine_h

//屏幕尺寸定义和iPhoneX机型判断代码
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define IS_IPHONEX (SCREEN_HEIGHT == 812.f)

#ifdef DEBUG
// 打印JSON
#define ENABLE_JSON_LOG YES
// 网络请求错误log
#define ENABLE_NETWORK_ERROR_LOG YES
#else
// 打印JSON
#define ENABLE_JSON_LOG NO
// 网络请求错误log
#define ENABLE_NETWORK_ERROR_LOG NO
#endif
/*对以上宏定义进行解释：
 1.BASE_URL：定义请求的基地址。
 2.ENABLE_JSON_LOG：打印网络请求获得的JSON串
 3.ENABLE_NETWORK_ERROR_LOG：打印网络请求发生的错误。
 以上宏定义代码对当前的编译环境进了判断，如果当前是DEBUG环境，则开启JSON打印和网络错误日志，否则关闭两者打印。*/
// 测试URL
//#define BASE_URL @"http://www.mcartoria.com/TXGLwai/"
#define BASE_URL @"http://192.168.0.101:8080/DeviceManage/"

/*
 * 数据定义
 *
 */

// 活动模块名称
#define CLASSIFY_NAME @[@"全部类型",@"办公设备",@"生活设备",@"学习设备",@"户外设备",@"电子设备",@"其他设备"]

// 模块icon
#define CLASSIFY_ICON @[@"office",@"live",@"study",@"outdoor",@"elecdevice",@"other"]

#endif /* DeviceManageGlobalDefine_h */
