//
//  PersonView.m
//  test_interface
//
//  Created by sjl on 2018/10/27.
//  Copyright © 2018年 betterMan. All rights reserved.
//

#import "PersonView.h"

#import "MineViewController.h"
#import "UIView+Frame.h"

#import "UIView+ViewController.h"
#import "UIImageView+WebCache.h"
@interface PersonView()<UIGestureRecognizerDelegate>

@end
@implementation PersonView{
    UIImageView*        _iconImageView;     //头像
    UILabel*            _nameLB;            //姓名
    UILabel*            _majorLB;           //专业
    UIImageView*        _arrow;             //箭头
    UITapGestureRecognizer* _tapGester;      //点击手势
}


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //头像
        _iconImageView=[[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_iconImageView];
        
        //姓名
        _nameLB=[[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_nameLB];
        
        //箭头
        _arrow=[[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_arrow];
        
        //添加点击手势
        _tapGester=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personHeaderTapped)];
        _tapGester.delegate=self;
        [self addGestureRecognizer:_tapGester];
        
        
    }
    return self;
}

-(void) setupView{
    
    
    self.backgroundColor=[UIColor whiteColor];
    //设置头像
    _iconImageView.frame=CGRectMake(25,25, 60, 60);
    _iconImageView.layer.masksToBounds=YES;
    _iconImageView.layer.cornerRadius=30;
    //姓名
    _nameLB.frame=CGRectMake(_iconImageView.rightX+20, 30,90,20);
    
    //箭头
    _arrow.frame=CGRectMake(self.width-27, self.height/2-7, 8, 13);
    
    
    //判断登录状态
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:self.iconStr]placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    _nameLB.text=_nameStr;
    //箭头照片赋值
    _arrow.image=[UIImage imageNamed:@"Arrow_322px_1183511_easyicon.net"];
    
}

-(void) setNoTapped{
    [self removeGestureRecognizer:_tapGester];
    _arrow.hidden=YES;
}



//视图被点击
-(void)personHeaderTapped{
#pragma mark--personHeaderTapped
    
//    PersonViewController* personVC=[PersonViewController new];
//    [self.viewController.navigationController pushViewController:personVC animated:YES];
}

@end
