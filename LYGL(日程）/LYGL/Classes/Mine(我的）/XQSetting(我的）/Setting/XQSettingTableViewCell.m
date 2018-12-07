//
//  XQSettingTableViewCell.m
//  Mine
//
//  Created by Ticsmatic on 2017/10/12.
//  Copyright © 2017年 Ticsmatic. All rights reserved.
//

#import "XQSettingTableViewCell.h"
#import <YYCategories.h>

@interface XQSettingTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIView *customAccessoryView;
@property (weak, nonatomic) IBOutlet UISwitch *accessorySwitch;
@property (weak, nonatomic) IBOutlet UILabel *accessoryLabel;

@end

@implementation XQSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(XQSettingItem *)data {
    _data = data;
    
    _iconImageView.image = [UIImage imageNamed:data.image];
    _titleLabel.text = data.title;
    
    // 继承XQSettingItem模型，增加一个自己需要的字段，用来存储富文本数据
    if (data.hasAttributeDetail) {
        if ([data.title isEqualToString:@"消息中心"] && data.detailText.length) {
            [self setupMsgCenterUIWithData:data];
        } 
    } else {
        _detailLabel.text = data.detailText;
    }
    
    if (data.hasRightArrow) {
        _detailLabel.hidden = NO;
        _arrowImageView.hidden = NO;
        _customAccessoryView.hidden = YES;
    } else {
        _detailLabel.hidden = YES;
        _arrowImageView.hidden = YES;
        _customAccessoryView.hidden = NO;
        if (data.hasSwitch) {
            _accessorySwitch.hidden = NO;
            _accessoryLabel.hidden = YES;
            _accessorySwitch.on = data.switchStatus;
        } else {
            _accessorySwitch.hidden = YES;
            _accessoryLabel.hidden = NO;
            // 需要的话，继承XQSettingItem模型，增加一个自己需要的字段，用来存储数据，这里仅是演示
             _accessoryLabel.text = data.detailText;
        }
    }
}

#pragma mark - Private

/// 对于cell右侧数据展示时，不需要交互的统一使用的是绘制，通过Label的富文本展示，基本就能满足大部分需求
- (void)setupMsgCenterUIWithData:(XQSettingItem *)data {
    // 依靠绘制实现
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] init];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    UIImage *image = [UIImage imageWithSize:CGSizeMake(32, 32) drawBlock:^(CGContextRef  _Nonnull context) {
        CGFloat ellipseWH = 28;
        CGRect aRect = CGRectMake(0, (_detailLabel.height-ellipseWH)*0.5, ellipseWH, ellipseWH);
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);//填充颜色
        CGContextFillEllipseInRect(context, aRect); //实心填充椭圆
        CGContextDrawPath(context, kCGPathStroke);
        CGContextSetLineWidth(context, 1.0);//线条宽度
        CGContextSetRGBFillColor (context, 0.5, 0.5, 0.5, 0.5);//颜色
        CGRect tRect = CGRectMake(8, 8, 18, 18);
        NSAttributedString *textAtts = [[NSAttributedString alloc] initWithString:data.detailText attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0], NSForegroundColorAttributeName : [UIColor whiteColor]}];
        CGSize textSize = [textAtts size];
        tRect.origin.x = (aRect.size.width - textSize.width) * 0.5;
        tRect.size = textSize;
        NSStringDrawingContext *drawCons = [[NSStringDrawingContext alloc] init];
        drawCons.minimumScaleFactor = 0.6;
        [textAtts drawWithRect:tRect options:NSStringDrawingUsesLineFragmentOrigin context:drawCons];
    }];
    attch.image = image;
    attch.bounds = CGRectMake(0, 0, 32, 32);
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri appendAttributedString:string];
    _detailLabel.attributedText = attri;
}
@end
