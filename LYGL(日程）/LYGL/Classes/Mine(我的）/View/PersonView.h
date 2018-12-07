//
//  PersonView.h
//  test_interface
//
//  Created by sjl on 2018/10/27.
//  Copyright © 2018年 betterMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonView : UIView

@property (retain,nonatomic) NSString* iconStr;
@property (retain,nonatomic) NSString* nameStr;


-(instancetype)initWithFrame:(CGRect)frame;
-(void) setupView;
-(void) setNoTapped;
@end
