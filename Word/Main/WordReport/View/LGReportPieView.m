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
    
//    dimRate = 0.6;
//    forgetRate = 0.1;
//    knowWellRate = 0.1;
//    notKnowRate = 0.1;
//    knowRate = 0.1;
    
    
    
    //模糊
   CGFloat dimEndAngle = [self createArcWithRate:dimRate startAngle:M_PI/4 color:[UIColor lg_colorWithHexString:@"4E8EDA"] rect:rect];

    
   // 忘记
   CGFloat forgetEndAngle = [self createArcWithRate:forgetRate startAngle:dimEndAngle color:[UIColor lg_colorWithHexString:@"F0975B"] rect:rect] ;
    //熟识
    CGFloat knowWellEndAngle = [self createArcWithRate:knowWellRate startAngle:forgetEndAngle color:[UIColor lg_colorWithType:LGColor_theme_Color] rect:rect] ;
    //不认识
    CGFloat notKnowEndAngle = [self createArcWithRate:notKnowRate startAngle:knowWellEndAngle color:[UIColor lg_colorWithHexString:@"E2585A"] rect:rect] ;
    //认识
    CGFloat knowEndAngle = [self createArcWithRate:knowRate startAngle:notKnowEndAngle color:[UIColor lg_colorWithHexString:@"51DFE7"] rect:rect];
    
//    [self addSpaceWithRect:rect angle:dimEndAngle];
//    [self addSpaceWithRect:rect angle:forgetEndAngle];
//    [self addSpaceWithRect:rect angle:knowWellEndAngle];
//    [self addSpaceWithRect:rect angle:notKnowEndAngle];
//    [self addSpaceWithRect:rect angle:knowEndAngle];
    
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
    
    //半径
    CGFloat radius = CGRectGetWidth(rect) / 2.0 ;
	
    //结束角度
    CGFloat endAngle = startAngle + 2 * M_PI  * rate;
    
    UIBezierPath *arc = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
	
	[arc addLineToPoint:center];
	[arc closePath];
    [color setFill];
    [arc fill];
    return endAngle;
}

- (void) addSpaceWithRect:(CGRect)rect angle:(CGFloat)angle {
    //中心
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    //半径
    CGFloat radius = CGRectGetWidth(rect) / 2.0 ;
    
    CGPoint pint = [self angleToPoint:center radius:radius angle:angle];
    UIBezierPath *line = [UIBezierPath new];
    [line moveToPoint:pint];
    [line addLineToPoint:center];
    line.lineWidth = 4;
    [[UIColor whiteColor] setStroke];
    [line stroke];
}

/**
 弧度转换坐标

 @param center 圆心
 @param radius 半径
 @param angle 弧度
 @return 坐标
 */
- (CGPoint)angleToPoint:(CGPoint)center radius:(CGFloat)radius angle:(CGFloat)angle{
    
    CGFloat x = cos(angle) * radius + center.x;
    CGFloat y = sin(angle) * radius + center.y;
    return CGPointMake(x, y);
}

@end


