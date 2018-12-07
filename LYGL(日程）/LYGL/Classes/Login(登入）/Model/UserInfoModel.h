//
//  UserInfoModel.h
//  test_interface
//
//  Created by sjl on 2018/10/19.
//  Copyright © 2018年 betterMan. All rights reserved.
//

#import "BaseModel.h"


@interface UserInfoModel : BaseModel<NSCoding>
// 属性,用setValue

@property NSInteger UserID;
@property NSString *UserName;
@property NSString *UserPassword;


// 单例
+ (instancetype) shareInstance;

// 检查登录状态
- (BOOL) checkLogin;

// 退出登录
- (void) logout;

// 保存模型
-(void)saveToFile;

@end
