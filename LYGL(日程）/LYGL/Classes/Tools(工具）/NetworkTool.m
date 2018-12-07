//
//  NetworkTool.m
//  SDSY
//
//  Created by 蓝布鲁 on 2017/3/23.
//  Copyright © 2017年 蓝布鲁. All rights reserved.
//

#import "NetworkTool.h"

@implementation NetworkTool

static NetworkTool *tool;
+(instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[NetworkTool alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        tool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json", @"text/plain", @"text/javascript", nil];
    });
    return tool;
}

-(void)requireMethodType:(MethodType)type
               URLString:(NSString *)urlString
              parameters:(NSDictionary *)parameters
                 success:(SuccessBlock)success
                 failure:(FailureBlock)failure {
    // 打印请求
    
    [self printNetworkLog:type URLString:urlString parameters:parameters];
    
    
    NSString *fullURL = [self getFullRequestURL:urlString];
    
    if (type==GETType) {
        [self GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (ENABLE_JSON_LOG) {
                NSLog(@"[url:%@] response:%@",fullURL,responseObject);
            }
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(ENABLE_NETWORK_ERROR_LOG){
                NSLog(@"[URL:%@] error:%@",fullURL,error);
            }
            failure(error);
        }];
    }else {
        [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (ENABLE_JSON_LOG) {
                NSLog(@"[URL:%@] response:%@",fullURL,responseObject);
            }
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(ENABLE_NETWORK_ERROR_LOG){
                NSLog(@"[URL:%@] error:%@",fullURL,error);
            }
            failure(error);
        }];
    }
}

// 打印请求地址+参数
-(void)printNetworkLog:(MethodType)type URLString:(NSString *)urlString parameters:(NSDictionary *)parameters {
    // 初始化字符串
    NSString *proURLString = [self getFullRequestURL:urlString];                      // 完整请求地址
    NSString *typeString = [[NSString alloc] init];                                   // 请求类型
    NSMutableString *parametersString = [[NSMutableString alloc] init];               // 请求参数


    // 生成请求方法string
    typeString = type == GETType ? @"GET" : @"POST";

    // 检查是否存在参数
    if (parameters){
        // 生成请求参数string
        for (NSString *allKey in [parameters allKeys]) {
            [parametersString appendFormat:@"%@=%@, ",allKey,parameters[allKey]];
        }

        // 删除最后到 ", " 两个字符
        [parametersString deleteCharactersInRange:NSMakeRange([parametersString length]-2, 2)];
    }

    NSString *request = [NSString stringWithFormat:@"[%@] %@ {%@}",typeString,proURLString,parametersString];
    NSLog(@"%@",request);
}

-(NSString *)getFullRequestURL:(NSString *)urlString {
    return self.baseURL ? [NSString stringWithFormat:@"%@%@",self.baseURL,urlString] : urlString;
}

@end
