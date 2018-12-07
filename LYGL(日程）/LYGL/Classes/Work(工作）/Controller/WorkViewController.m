//
//  WorkViewController.m
//  LYGL
//
//  Created by sjl on 2018/12/4.
//  Copyright © 2018年 sjl. All/Users/sjl/Desktop/LYGL/LYGL/Classes rights reserved.
//

#import "WorkViewController.h"

@interface WorkViewController ()

@end

@implementation WorkViewController

-(instancetype)init{
    if (self = [super init]) {
        self.title=@"工作";
        self.tabBarItem.image = [UIImage imageNamed:@"home_tabBar"];
        self.hidesBottomBarWhenPushed = false;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupQuitBtn];
}

- (void)setupQuitBtn {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"quit"] style:UIBarButtonItemStylePlain target:self action:@selector(quit)];
}
-(void)quit{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
