//
//  LGTrackPieView.m
//  Word
//
//  Created by caoguochi on 2018/4/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGTrackPieView.h"

@interface LGTrackPieView()
{
    NSInteger dayStudyNum;   //每日新学
    NSInteger dayReviewNum;  //每日复习
}

@end

@implementation LGTrackPieView

- (void)setPieDayStudy:(NSInteger)dayStudy dayReview:(NSInteger)dayReview{
    dayStudyNum = dayStudy;
    dayReviewNum = dayReview;
    
    UILabel *dayStudyLabel =  [self viewWithTag:200];
    UILabel *dayReviewLabel = [self viewWithTag:201];
    dayStudyLabel.text = @(dayStudyNum).stringValue;
    dayReviewLabel.text = @(dayReviewNum).stringValue;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    
    
    if (dayReviewNum + dayStudyNum == 0) return;
    
    //view中心
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    //圆半径,20为饼状图上下间距父视图和
    CGFloat radius = (CGRectGetHeight(rect) - 20) / 2.0f;
    
    //如果其中一个为0，则画个圆
    if (dayStudyNum == 0 || dayReviewNum == 0) {
        UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(center.x - radius, center.y - radius, 2 * radius, 2 * radius)];
        UIColor *circileColor = dayStudyNum == 0 ? [UIColor lg_colorWithType:LGColor_Yellow] : [UIColor lg_colorWithType:LGColor_theme_Color];
        [circileColor setFill];
        [circle fill];
    }else{
        //复习占的比例
        CGFloat reviewRate=  dayReviewNum * 1.0 / (dayReviewNum + dayStudyNum);
        
        //复习扇形区域为圆形 0° （2π） 的上下各一半，保证扇形中心点和圆心在水平线上；
        CGFloat endAngle = 2 * M_PI * (reviewRate / 2.0);
        CGFloat startAngle = 2 * M_PI - endAngle;
        
        //复习区域扇形图
        UIBezierPath *reviewPie = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle  clockwise:YES];
        [[UIColor lg_colorWithType:LGColor_Yellow]setFill];
        //连接圆心，组成扇形
        [reviewPie addLineToPoint:center];
        [reviewPie closePath];
        [reviewPie fill];
        
        //学习区域扇形图
        UIBezierPath *studayPie = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:endAngle endAngle: startAngle clockwise:YES];
        [[UIColor lg_colorWithType:LGColor_theme_Color]setFill];
        [studayPie addLineToPoint:center];
        [studayPie closePath];
        [studayPie fill];
    }
    //复习直线，如果为0不画直线
    if (dayReviewNum > 0) {
        CGRect reviewDescriptionFrame = [self viewWithTag:101].frame;
        UIBezierPath *reviewLine = [UIBezierPath bezierPath];
        [reviewLine moveToPoint:CGPointMake(center.x + radius, center.y)];
        [reviewLine addLineToPoint:CGPointMake(CGRectGetMinX(reviewDescriptionFrame), CGRectGetMidY(reviewDescriptionFrame))];
        reviewLine.lineWidth = 0.5;
        [[UIColor lg_colorWithType:LGColor_Title_2_Color] setStroke];
        [reviewLine stroke];
    }
    
    //新学单词直线，如果为0不画直线
    if (dayStudyNum > 0) {
        CGRect studyDescriptionFrame = [self viewWithTag:100].frame;
        UIBezierPath *studywLine = [UIBezierPath bezierPath];
        [studywLine moveToPoint:CGPointMake(center.x - radius, center.y)];
        [studywLine addLineToPoint:CGPointMake(CGRectGetMaxX(studyDescriptionFrame), CGRectGetMidY(studyDescriptionFrame))];
        studywLine.lineWidth = 0.5;
        [[UIColor lg_colorWithType:LGColor_Title_2_Color] setStroke];
        [studywLine stroke];
    }
}


@end
