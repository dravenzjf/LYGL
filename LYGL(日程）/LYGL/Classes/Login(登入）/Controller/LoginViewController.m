//
//  LoginViewController.m
//  test_interface
//
//  Created by sjl on 2018/10/19.
//  Copyright © 2018年 betterMan. All rights reserved.
//

#import "LoginViewController.h"
#import "UserInfoModel.h"
#import "MainViewController.h"

#import "AppDelegate.h"
#import "JPUSHService.h"
#import "UserInfoModel.h"
#import "MMZCHMViewController.h"
#import "forgetPassWardViewController.h"
#import "UIView+AdaptScreen.h"

@interface LoginViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *idTextField;       // 手机号
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;   // 密码
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;             // 登录按钮
@property (weak, nonatomic) IBOutlet UIView *labelBackView;          // label背景


@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    //[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:216/255.0f green:209/255.0f blue:192/255.0f alpha:1]];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 检查是否已经登录,如果已经登录,则进入主界面
    if ([[UserInfoModel shareInstance] checkLogin]  ) {
        // 已登录
        [self showMainViewController];
        
        return;
    }
    
    // 调整登录按钮
    self.loginBtn.layer.masksToBounds = true;
    self.loginBtn.layer.cornerRadius = 10;
    
    // 调整背景View
    self.labelBackView.layer.masksToBounds = true;
    self.labelBackView.layer.cornerRadius = 10;
    self.labelBackView.layer.borderWidth = 0.5;
    self.labelBackView.layer.borderColor = [UIColor grayColor].CGColor;
    
    // textField
    self.idTextField.delegate = self;
    self.passwdTextField.delegate = self;
    //等比例约束
    [self.view adaptScreenWidthWithType:AdaptScreenWidthTypeAll exceptViews:nil];
    
#pragma mark 测试账号自动填充
        self.idTextField.text = @"tom";
        self.passwdTextField.text = @"654321";
}
- (IBAction)loginBtnTapped:(id)sender {
    [self login];
}


#pragma mark - 事件监听
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 网络请求



// 登录
- (void)login {
    [SVProgressHUD show];
    // 初始化参数
    NSDictionary *parameters = @{@"username": self.idTextField.text, @"password": self.passwdTextField.text };
    [[NetworkTool shareInstance] requireMethodType:POSTType URLString:@"DeviceManage/loginValidate" parameters:parameters success:^(NSDictionary *respondDictionary) {
        // 如果为空的模型,直接返回
         if ([respondDictionary[@"result"][0] allKeys].count == 0) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"web接口服务连接失败，请确保主机ip地址是否正确，然后打开tomcat服务器"];
            return;
        }
        // 设置用户模型
        [[UserInfoModel shareInstance] setValuesForKeysWithDictionary:respondDictionary[@"result"][0]];
        [SVProgressHUD dismiss];
        
        [self showMainViewController];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"web接口服务连接失败，请确保主机ip地址是否正确，然后打开tomcat服务器"];
    }];
}
//注册
- (IBAction)regist:(id)sender {
     [self.navigationController pushViewController:[[MMZCHMViewController alloc]init] animated:YES];
}
//找回密码
- (IBAction)fogetPwd:(id)sender {
    [self.navigationController pushViewController:[[forgetPassWardViewController alloc]init] animated:YES];
}
#pragma mark - 自定义方法
- (void)showMainViewController{
    ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = [[MainViewController alloc] init];
}

#pragma mark - UITextFieldDelegate协议
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 1) {
        // 学号textField,点击next,密码textField聚焦
        [self.passwdTextField becomeFirstResponder];
    }else {
        // 密码textField,点击return,直接登录
        [self login];
        [self.idTextField resignFirstResponder];
        [self.passwdTextField resignFirstResponder];
    }
    return true;
}

#pragma mark - 系统回调
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.idTextField resignFirstResponder];
    [self.passwdTextField resignFirstResponder];
}



@end
