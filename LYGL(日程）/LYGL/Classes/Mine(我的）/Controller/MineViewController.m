//
//  MineViewController.m
//  test_interface
//
//  Created by sjl on 2018/10/12.
//  Copyright © 2018年 betterMan. All rights reserved.
//

#import "MineViewController.h"
#import "UserInfoModel.h"
#import "UIView+SDAutoLayout.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "NetworkTool.h"
#import "SVProgressHUD+LAN.h"
#import "SDImageCache.h"
#import "PersonView.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation MineViewController{
    UITableView *_tableView;
    PersonView*  _personHeader;     //headerView
    NSString*    _cacheStr;         //缓存
}
-(instancetype)init{
    if (self==[super init]) {
        // 设置标题&TabBar图标
        self.title = @"我";
        self.tabBarItem.image = [UIImage imageNamed:@"mine"];
        self.hidesBottomBarWhenPushed = false;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    // 取出UserInfo模型
//    self.model = [UserInfoModel shareInstance];
    //设置tableView__headerView
    UIView* headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 150)];//背景图层View
   _personHeader=[[PersonView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 110)];
//    if (self.model != nil) {
//        _personHeader.iconStr = self.model.picture;
//        _personHeader.nameStr = self.model.name;
        [_personHeader setupView];
//    }
    [headerView addSubview:_personHeader];
    
    _tableView.tableHeaderView=headerView;
    [self.view addSubview:_tableView];
}

#pragma mark - 网络请求数据



#pragma mark--tableViewCell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id"];
    }
    //为cell设置内容
    if(indexPath.section==0){
        //显示箭头
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if(indexPath.row==0){
            cell.textLabel.text=@"修改收货信息";
            //[cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",self.model?self.model.unit:0]];
        }else if (indexPath.row==1){
            cell.textLabel.text=@"修改密码";
            
        }else if (indexPath.row==2){
            cell.textLabel.text=@"账户余额";
            //[cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",self.model?self.model.job:0]];
        }
        
    }else if (indexPath.section==1){
        //显示箭头
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if(indexPath.row == 0) {
            cell.textLabel.text=@"全部订单";
        }
    }else if (indexPath.section==2){
        //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if(indexPath.row==0){
            cell.textLabel.text=@"切换用户";
            //[cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",self.model?self.model.tutor:0]];
           
        }
    }else if (indexPath.section==3){
        //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if(indexPath.row==0){
            cell.textLabel.text=@"意见反馈";
            //[cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",self.model?self.model.tutor:0]];
        }
    }else if(indexPath.section==4){
        if (indexPath.row==0){
            UILabel* label=[[UILabel alloc] init];
            [label setText:@"退出登录"];
            label.frame=CGRectMake(self.view.width/2-40, 0, 80, 40);
            [cell.contentView addSubview:label];
        }
    }
    return cell;
}

//划分4个单元
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
//划分每个单元的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 3;
    }else if (section==1){
        return 1;
    }
    else if (section==2){
        return 1;
    }
    else {
        return 1;// 退出登录
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"账户中心";
    }else if(section == 1){
        return @"我的订单";
    }else if(section == 2){
        return @"切换账户";
    }
    else {
        return @"";
    }
}

//选中动作
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置tableViewCell选中风格
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
    if (indexPath.section==0) {
        if(indexPath.row==0){//修改收货信息
            //DiaryViewController *diary = [[DiaryViewController alloc] init];
            //[self.navigationController pushViewController:diary animated:true];
        }else if (indexPath.row==1){//修改密码
        }else if (indexPath.row==2){//账户余额
        }else if (indexPath.row==3){
        }
    }else if (indexPath.section==1){
        if(indexPath.row==0){// 全部订单
        }
    }else if (indexPath.section==2){
        if(indexPath.row==0){//切换用户
        }
    }else if (indexPath.section==3){
        if(indexPath.row==0){//意见反馈
        }
    }
    else{//退出登陆
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"设备管理" message:@"确定退出登入?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *done = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            // 删除登录信息
            [[UserInfoModel shareInstance] logout];
            // 跳转登录界面
            ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = [[LoginViewController alloc] init];
        }];
        [alert addAction:cancel];
        [alert addAction:done];
        [self presentViewController:alert animated:true completion:nil];
    }
}


/*
 - (void)didReceiveMemoryWarning {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 }
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
