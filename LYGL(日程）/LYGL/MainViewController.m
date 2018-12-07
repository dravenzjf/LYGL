//
//  ViewController.m
//  test_interface
//
//  Created by sjl on 2018/10/12.
//  Copyright © 2018年 betterMan. All rights reserved.
//

#import "MainViewController.h"
#import "MineViewController.h"
#import "WorkViewController.h"
#import "DateViewController.h"
#import "HyPopMenuView.h"
#import "popMenvTopView.h"
#import "KBTabbar.h"
#import "XQSettingViewController.h"

@interface MainViewController ()<HyPopMenuViewDelegate>

@property (nonatomic, strong) HyPopMenuView* menu;

@end

@implementation MainViewController

#pragma mark - 初始化方法
-(instancetype)init{
    if (self==[super init]) {
        // 设置TabBar的字控制器
        [self setupViewControllers];
       
    }
    return self;
}
#pragma mark - 系统回调方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // 修复黑影
    self.view.backgroundColor = UIColor.whiteColor;
    //设置导航条点击颜色为红色
    [UINavigationBar appearance].tintColor=[UIColor orangeColor];
    
    //  设置tabbar
    // 设置自定义的tabbar
    [self setCustomtabbar];
    
    _menu = [HyPopMenuView sharedPopMenuManager];
    PopMenuModel* model = [PopMenuModel
                           allocPopMenuModelWithImageNameString:@"publish_0"
                           AtTitleString:@"预定"
                           AtTextColor:[UIColor grayColor]
                           AtTransitionType:PopMenuTransitionTypeCustomizeApi
                           AtTransitionRenderingColor:nil];
    
    PopMenuModel* model1 = [PopMenuModel
                            allocPopMenuModelWithImageNameString:@"publish_1"
                            AtTitleString:@"通知"
                            AtTextColor:[UIColor grayColor]
                            AtTransitionType:PopMenuTransitionTypeSystemApi
                            AtTransitionRenderingColor:nil];
    
    PopMenuModel* model2 = [PopMenuModel
                            allocPopMenuModelWithImageNameString:@"publish_2"
                            AtTitleString:@"会议列表"
                            AtTextColor:[UIColor grayColor]
                            AtTransitionType:PopMenuTransitionTypeCustomizeApi
                            AtTransitionRenderingColor:nil];
    
    
    _menu.dataSource = @[ model, model1, model2];
    _menu.delegate = self;
    //动画弹出速度
    _menu.popMenuSpeed = 10.0f;
    _menu.automaticIdentificationColor = false;
    _menu.animationType = HyPopMenuViewAnimationTypeLeftAndRight;
    _menu.backgroundType = HyPopMenuViewBackgroundTypeGradient;
    popMenvTopView* topView = [popMenvTopView popMenvTopView];
    //获取当前时间日期
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"MM/yyyy/dd"];
    NSString *dateStr;
    dateStr=[format1 stringFromDate:date];
    NSLog(@"%@",dateStr);
    //截取年月
    NSRange range = NSMakeRange(0,7);
    topView.label4.text =[dateStr substringWithRange:range];
    //截取日期
    range = NSMakeRange(8,2);
    topView.label1.text =[dateStr substringWithRange:range];
    //星期几
    topView.label3.text = [self weekdayStringFromDate:date];
   
    topView.frame = CGRectMake(0, 44, CGRectGetWidth(self.view.frame), 92);
    _menu.topView = topView;
}
#pragma mark - 自定义方法
//获得当前星期几
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekdays =
    [NSArray arrayWithObjects:
     [NSNull null], @"Sunday", @"周一", @"周二", @"周三",@"周四", @"周五", @"周六", nil];
     NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
     
     NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
     
     [calendar setTimeZone: timeZone];
     
     NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
     
     NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
     
     return [weekdays objectAtIndex:theComponents.weekday];
     
}

/**
 * @brief 设置TabBar的字控制器
 */
- (void)setupViewControllers {
    
    // 1.设置首页导航控制器
    DateViewController *dateViewController = [[DateViewController alloc] init];
    UINavigationController *dateNavi = [[UINavigationController alloc] initWithRootViewController:dateViewController];
    [self addChildViewController:dateNavi];
    
    // 3.设置购物车导航控制器
//    WorkViewController *workViewController = [[WorkViewController alloc] init];
//    UINavigationController *workNavi = [[UINavigationController alloc] initWithRootViewController:workViewController];
//    [self addChildViewController:workNavi];
    
    // 4.设置我的导航控制器
    XQSettingViewController *xQSettingViewController = [[XQSettingViewController alloc] init];
    UINavigationController *xqseNavi = [[UINavigationController alloc] initWithRootViewController:xQSettingViewController];
    [self addChildViewController:xqseNavi];

}



- (void)popMenuView:(HyPopMenuView*)popMenuView
didSelectItemAtIndex:(NSUInteger)index
{
    if(index==0){
        WorkViewController *Controller = [[WorkViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:Controller];
        [self presentViewController:nav animated:YES completion:nil];
    }else if(index==1){
        WorkViewController *Controller = [[WorkViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:Controller];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        WorkViewController *Controller = [[WorkViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:Controller];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (void)centerBtnClick:(UIButton *)btn{
    _menu.backgroundType = HyPopMenuViewBackgroundTypeLightBlur;
    [_menu openMenu];
}

- (UIImage *)imageWithColor:(UIColor *)color{
    // 一个像素
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)setCustomtabbar{
    
    KBTabbar *tabbar = [[KBTabbar alloc]init];
    
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    [tabbar.centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}


@end
