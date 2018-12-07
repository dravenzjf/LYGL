//
//  UserInfoModel.m
//  test_interface
//
//  Created by sjl on 2018/10/19.
//  Copyright © 2018年 betterMan. All rights reserved.
//

#import "UserInfoModel.h"
#import "JPUSHService.h"

typedef enum {
    AutoLogin = 1,              // 自动登录
    GeneralLogin = 2,           // 普通账号密码登录
    NoToken = 3,                // 不存在token
    PastToken = 4,              // token过期
    
}LoginType;
    
@implementation UserInfoModel

static UserInfoModel *userInfo;
+(instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [UserInfoModel readFromFile];
        // 如果取不到文件,就从新创建
        if (userInfo == nil) {
            userInfo = [[UserInfoModel alloc] init];
        }
        
    });
    return userInfo;
}

#pragma mark 准守NSCoding协议
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.UserID = [coder decodeIntegerForKey:@"UserID"];
        self.UserName = [coder decodeObjectForKey:@"UserName"];
        self.UserPassword = [coder decodeObjectForKey:@"UserPassword"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInteger:self.UserID forKey:@"UserID"];
    [coder encodeObject:self.UserName forKey:@"UserName"];
    [coder encodeObject:self.UserPassword forKey:@"UserPassword"];
}

-(void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    // 1.设置值
    [super setValuesForKeysWithDictionary:keyedValues];
    // 2.保存数据
    [self saveToFile];
    // 3.手动登陆
    [self loginLog:GeneralLogin];
}

#pragma mark - 自定义方法
// 保存数据
-(void)saveToFile {
    [NSKeyedArchiver archiveRootObject:self toFile:[UserInfoModel savePath]];
}

-(BOOL)checkLogin {
    
    // 1. 是否存在token
    if (self.UserPassword==nil || [self.UserPassword length]==0) {
        [self loginLog:NoToken];
        return false;
    }
    // 2.token是否过期
    //    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    NSDate *expirationDate = [formatter dateFromString:self.expiration];
    //    if([expirationDate compare:[NSDate date]] == NSOrderedAscending) {
    //        // 升序,表示需要刷新token,重新登录
    //        [self loginLog:PastToken];
    //        return false;
    //    }
    // 自动登录成功
    [self loginLog:AutoLogin];
    return true;
}

- (void)loginLog:(LoginType)type{
    NSString *loginType = @"";
    
    if (type == AutoLogin) {
        // 自动登录
        loginType = @"自动登录";
    }else if(type == GeneralLogin) {
        // 普通
        loginType = @"账号密码登录";
    }else if (type == NoToken) {
        // 不存在token
        loginType = @"不存在token,自动登录失败";
    }else if (type == PastToken) {
        // 不存在token
        loginType = @"不存在token,自动登录失败";
    }
    
    NSLog(@"-------------------------------------------------");
    NSLog(@"-------------------登录服务器信息-------------------");
    NSLog(@"-------------------------------------------------");
    NSLog(@"登录类型: %@",loginType);
    NSLog(@"expiration: %ld",self.UserID);
    NSLog(@"stu_id: %@",self.UserName);
    NSLog(@"token: %@",self.UserPassword);
    NSLog(@"保存路径: %@",[UserInfoModel savePath]);
    NSLog(@"-------------------------------------------------");
    NSLog(@"-------------------------------------------------");
}

- (void)logout {
    NSFileManager *manager = [NSFileManager defaultManager];
    
    // 1. 是否文件
    if (![manager fileExistsAtPath:[UserInfoModel savePath]]) {
        NSLog(@"没有找到token文件");
        return ;
    }
    
    // 2.删除token信息
    if([manager removeItemAtPath:[UserInfoModel savePath] error:nil]) {
        NSLog(@"成功登出");
    }
    
    // 3.释放模型
    userInfo = [[UserInfoModel alloc] init];
}

// 载入数据
+ (instancetype)readFromFile {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[UserInfoModel savePath]];
}

+ (NSString *)savePath {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject;
    return [path stringByAppendingPathComponent:@"UserInfo.plist"];
}

#pragma mark - 重写方法
- (NSString *)deviceCode {
    return [JPUSHService registrationID];
}


@end
