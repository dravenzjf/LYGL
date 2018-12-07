//
//  XQSettingViewController.m
//  Mine
//
//  Created by Ticsmatic on 2017/10/12.
//  Copyright © 2017年 Ticsmatic. All rights reserved.
//

#import "XQSettingViewController.h"
#import <YYModel.h>
#import "XQSettingItem.h"
#import "XQSettingTableViewCell.h"
#import "XQSettingHeader.h"
#import <Masonry.h>

#import "AppDelegate.h"
#import "UserInfoModel.h"
#import "LoginViewController.h"
@interface XQSettingViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIImageView *headerBgImageView;
@property (nonatomic, strong) XQSettingHeader *header;
@property (strong, nonatomic) NSMutableArray *sectionArray;
@end

@implementation XQSettingViewController

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
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self setupUI];
    [self setupHeaderView];
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - 

- (void)setupUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"XQSettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"XQSettingTableViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"logoutID"];
}

- (void)setupData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Setting" ofType:@"plist"];
    NSArray *sectionArray = [NSArray yy_modelArrayWithClass:[XQSettingSection class] json:[NSArray arrayWithContentsOfFile:path]];
    self.sectionArray = [sectionArray mutableCopy];
    [self.tableView reloadData];
}

- (void)setupHeaderView {
    [self.tableView addSubview:self.headerBgImageView];
    UIView *headerContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 200)];
    [headerContainer addSubview:self.header];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerContainer);
    }];
    self.tableView.tableHeaderView = headerContainer;
    [self.tableView bringSubviewToFront:headerContainer];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    XQSettingSection *group = self.sectionArray[section];
    return group.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XQSettingSection *section = self.sectionArray[indexPath.section];
    XQSettingItem *item = section.items[indexPath.row];
    return item.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    XQSettingSection *group = self.sectionArray[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    XQSettingSection *group = self.sectionArray[section];
    return group.footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XQSettingSection *section = self.sectionArray[indexPath.section];
    XQSettingItem *item = section.items[indexPath.row];
    if (item.custom) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.customReuseID forIndexPath:indexPath];
        cell.textLabel.text = item.title;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    } else {
        XQSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XQSettingTableViewCell"];
        cell.data = item;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XQSettingSection *section = self.sectionArray[indexPath.section];
    XQSettingItem *item = section.items[indexPath.row];
    //判断是否以某个名字命名的方法
    if (item.selectActionName.length && [self respondsToSelector:NSSelectorFromString(item.selectActionName)]) {
        [self performSelector:NSSelectorFromString(item.selectActionName)];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%f",offsetY);
    if (offsetY < 0) {
        self.headerBgImageView.frame = CGRectMake(offsetY/2, offsetY, self.view.frame.size.width - offsetY, 200 - offsetY);
    }
}


#pragma mark - Action

- (void)goHomeAction { NSLog(@"%s", __func__); }

- (void)goBalanceAction { NSLog(@"%s", __func__); }

- (void)goMessageCenterAction { NSLog(@"%s", __func__); }

- (void)goCollectionAction { NSLog(@"%s", __func__); }

- (void)goFavorAction { NSLog(@"%s", __func__); }

- (void)goQuestionAction { NSLog(@"%s", __func__); }

- (void)goTeaTopicAction { NSLog(@"%s", __func__); }

- (void)goFocusAction { NSLog(@"%s", __func__); }

- (void)goFansAction { NSLog(@"%s", __func__); }

- (void)goBindingAction { NSLog(@"%s", __func__); }

- (void)goHelpAction { NSLog(@"%s", __func__); }

- (void)goShareAction { NSLog(@"%s", __func__); }
//退出登入
- (void)logoutAction {
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

#pragma mark - Getter

- (XQSettingHeader *)header {
    if (_header == nil) {
        _header = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XQSettingHeader class]) owner:nil options:nil] lastObject];
    }
    return _header;
}

- (UIImageView *)headerBgImageView {
    if (_headerBgImageView == nil) {
        _headerBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        _headerBgImageView.image = [UIImage imageNamed:@"mine_bg"];
        _headerBgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headerBgImageView.autoresizesSubviews = YES;
    }
    return _headerBgImageView;
}
@end
