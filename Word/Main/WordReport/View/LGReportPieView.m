//
//  LGReportPieView.m
//  Word
//
//  Created by caoguochi on 2018/4/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGReportPieView.h"

@implementation LGReportPieView

- (void)setWeekReportModel:(LGWeekReportModel *)weekReportModel{
    _weekReportModel = weekReportModel;
    UILabel *totalLabel = [self viewWithTag:100];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总量\n%@",weekReportModel.all]];
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, attStr.length)];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_Title_1_Color] range:NSMakeRange(0, attStr.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:4];
    [attStr addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0, attStr.length)];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    totalLabel.attributedText = attStr;
    
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat all = self.weekReportModel.all.floatValue;
    
    if (all == 0) {
        [self createArcWithRate:1 startAngle:0 color:[UIColor lg_colorWithType:LGColor_Title_2_Color] rect:rect];
        return;
    }
    
    CGFloat dimRate = self.weekReportModel.dim.floatValue / all;
    CGFloat forgetRate = self.weekReportModel.forget.floatValue / all;
    CGFloat knowWellRate = self.weekReportModel.knowWell.floatValue / all;
    CGFloat notKnowRate = self.weekReportModel.notKnow.floatValue / all;
    CGFloat knowRate = self.weekReportModel.know.floatValue / all;
    
   
    
    //模糊
   CGFloat dimEndAngle = [self createArcWithRate:dimRate startAngle:0 color:[UIColor lg_colorWithType:LGColor_Dark_Yellow] rect:rect];
    //忘记
   CGFloat forgetEndAngle = [self createArcWithRate:forgetRate startAngle:dimEndAngle color:[UIColor lg_colorWithHexString:@"FF6F4B"] rect:rect];
    //熟识
    CGFloat knowWellEndAngle = [self createArcWithRate:knowWellRate startAngle:forgetEndAngle color:[UIColor lg_colorWithType:LGColor_theme_Color] rect:rect];
    //不认识
    CGFloat notKnowEndAngle = [self createArcWithRate:notKnowRate startAngle:knowWellEndAngle color:[UIColor lg_colorWithHexString:@"4D6FCC"] rect:rect];
    //认识
     [self createArcWithRate:knowRate startAngle:notKnowEndAngle color:[UIColor lg_colorWithHexString:@"34AFB9"] rect:rect];
}


/**
 画弧形

 @param rate 占比率
 @param startAngle 起始角度
 @param color 颜色
 @param rect 绘制区域
 @return 弧形结束角度
 */
-  (CGFloat)createArcWithRate:(CGFloat)rate startAngle:(CGFloat)startAngle color:(UIColor *)color rect:(CGRect)rect{
    //中心
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    //弧形宽度
    CGFloat lineWidth = 20;
    //半径
    CGFloat radius = CGRectGetWidth(rect) / 2.0  -  lineWidth / 2;
    //结束角度
    CGFloat endAngle = startAngle + 2 * M_PI * rate  ;
    UIBezierPath *arc = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    arc.lineWidth = lineWidth;
    [color setStroke];
    [arc stroke];
    return endAngle;
}

@end
