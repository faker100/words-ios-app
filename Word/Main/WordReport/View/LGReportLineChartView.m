//
//  LGReportLineChartView.m
//  Word
//
//  Created by caoguochi on 2018/4/6.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGReportLineChartView.h"

//水平线条数为 7 ，y轴方向的数据个数为8 (horizontalNum + 1);
#define  horizontalNum 7

@interface LGReportLineChartView()

@property (nonatomic, assign) NSInteger numOfX;  // x轴数量，最少4周;

@property (nonatomic, assign) NSInteger riseOfY; // Y等差增量， getter方法;

@property (nonatomic, strong) NSMutableArray<NSString *> *allTotal;     //所有总量
@property (nonatomic, strong) NSMutableArray<NSString *> *allKnowWell;  //所有熟知量
@property (nonatomic, strong) NSMutableArray<NSString *> *allKnow;      //所有认识量
@property (nonatomic, strong) NSMutableArray<NSString *> *allDim;       //所有模糊量
@property (nonatomic, strong) NSMutableArray<NSString *> *allForget;    //所有忘记量
@property (nonatomic, strong) NSMutableArray<NSString *> *allNotKnow;   //所有不认识

@end

@implementation LGReportLineChartView

- (void)setData:(NSMutableArray<LGWeekReportModel *> *)before after:(NSMutableArray <NSString *> *)after{
    self.before = before;
    self.after = after;
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //Y轴数据区域宽度
    CGFloat width_Y = 30;
    //X轴周数区域高度
    CGFloat height_X = 50;
    
    //背景区域
    CGRect backgroundRect = CGRectMake(width_Y, 0, CGRectGetMaxX(rect) - width_Y, CGRectGetMaxY(rect) - height_X);
    
    //Y轴区域
    CGRect yRect = CGRectMake(0, 0, width_Y, CGRectGetMaxY(rect) - height_X);
    
    //x轴区域
    CGRect xRect = CGRectMake(width_Y, CGRectGetMaxY(rect) - height_X, CGRectGetMaxX(rect) - width_Y,height_X);
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:backgroundRect];
    [scrollView setContentSize:CGSizeMake(45 * (self.before.count + self.after.count), CGRectGetHeight(backgroundRect))];
   UIView *view = [[LGBeforeChartView alloc]initWithFrame:CGRectMake(0, 0, 45 *self.before.count, CGRectGetHeight(backgroundRect)) before:self.before maxValue:[self maxDataOfDay]];
    [scrollView addSubview:view];
    
    
    [self createBackground:backgroundRect];
    [self createY:yRect];
    [self createX:xRect];
    
    [self addSubview:scrollView];
    
    //绘制总量折线
//    [self createLineChart:self.allTotal    color:[UIColor lg_colorWithType:LGColor_theme_Color] rect:backgroundRect];
//    [self createLineChart:self.allKnowWell color:[UIColor lg_colorWithType:LGColor_Dark_Yellow] rect:backgroundRect];
//    [self createLineChart:self.allKnow     color:[UIColor lg_colorWithHexString:@"8957A1"] rect:backgroundRect];
//    [self createLineChart:self.allDim      color:[UIColor lg_colorWithHexString:@"FF6F4B"] rect:backgroundRect];
//    [self createLineChart:self.allForget   color:[UIColor lg_colorWithHexString:@"00FFFF"] rect:backgroundRect];
//    [self createLineChart:self.allNotKnow  color:[UIColor lg_colorWithHexString:@"4D6FCC"] rect:backgroundRect];
}

#pragma mark - 绘制

/**
 X轴

 @param rect X轴区域
 */
- (void)createX:(CGRect)rect{
    
    //周数，最少4个
    NSInteger num = self.numOfX;
    
    NSDictionary *weekStrDic = @{
                              @"1" : @"第\n一\n周",
                              @"2" : @"第\n二\n周",
                              @"3" : @"第\n三\n周",
                              @"4" : @"第\n四\n周",
                              @"5" : @"第\n五\n周",
                              @"6" : @"第\n六\n周",
                              };
    
    //文本样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *att = @{
                          NSFontAttributeName : [UIFont systemFontOfSize:10],
                          NSForegroundColorAttributeName : [UIColor lg_colorWithType:LGColor_Title_2_Color],
                          NSParagraphStyleAttributeName : paragraphStyle,
                          };
    
    for (int i = 1 ; i <= num; i++) {
        NSString *weekStr = weekStrDic[@(i).stringValue];
        //文本外围宽度,平分x轴宽度
        CGFloat width = CGRectGetWidth(rect) / num;
        
        /**
         文字区域
         +5，文字与X轴间距
         */
        CGRect strRect = CGRectMake((i - 1) * width + CGRectGetMinX(rect) , CGRectGetMinY(rect)+ 5 ,width, CGRectGetHeight(rect));
        [weekStr drawInRect:strRect withAttributes:att];
    }
}

/**
 Y轴

 @param rect Y轴区域
 */
- (void)createY:(CGRect)rect{
    
    //Y轴等差增量
    NSInteger rise = self.riseOfY;
    
    //字体样式
    UIFont *strFont = [UIFont systemFontOfSize:9];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.alignment = NSTextAlignmentRight;
    NSDictionary *att = @{
                          NSFontAttributeName : strFont,
                          NSForegroundColorAttributeName : [UIColor lg_colorWithType:LGColor_Title_2_Color],
                          NSParagraphStyleAttributeName : paragraphStyle,
                          };
    
    for (int i = 0 ; i <= horizontalNum; i++) {
        NSString *strY = @(i * rise).stringValue;
        //文字外围高度，平分y轴高度
        CGFloat height = CGRectGetHeight(rect) / (horizontalNum + 1);
        
        
        /**
         文字区域
          - strFont.lineHeight / 2，文字高度一半，调整使其对齐背景中的横线
          - 5，文字与Y轴间距
         */
        CGRect strRect = CGRectMake(0, height * (horizontalNum + 1 - i) - strFont.lineHeight / 2 , CGRectGetWidth(rect) - 5, height);
        [strY drawInRect:strRect withAttributes:att];
    }
}

/**
 背景区域

 @param bgRect 条纹区域
 */
- (void)createBackground:(CGRect)bgRect{
    
    //垂直线
    UIBezierPath *verticalLinePath = [UIBezierPath bezierPath];
    [verticalLinePath moveToPoint:CGPointMake(CGRectGetMinX(bgRect) - 0.5 , 0)];
    [verticalLinePath addLineToPoint:CGPointMake(CGRectGetMinX(bgRect) - 0.5, CGRectGetHeight(bgRect))];
    verticalLinePath.lineWidth = 0.5;
    [[UIColor lg_colorWithType:LGColor_Title_2_Color] set];
    [verticalLinePath stroke];
    
    //水平线
    
    for (int i = 1; i<= horizontalNum; i++) {
        UIBezierPath *horizontalLinePath = [UIBezierPath bezierPath];
        CGFloat lineY = CGRectGetHeight(bgRect) / (horizontalNum + 1) * i;
        [horizontalLinePath moveToPoint:CGPointMake(CGRectGetMinX(bgRect), lineY)];
        [horizontalLinePath addLineToPoint:CGPointMake(CGRectGetWidth(bgRect) + CGRectGetMinX(bgRect), lineY)];
        horizontalLinePath.lineWidth = 0.5;
        [[[UIColor lg_colorWithType:LGColor_Title_2_Color] colorWithAlphaComponent:0.15] setStroke];
        [horizontalLinePath stroke];
    }
}

/**
 绘制折线

 @param dataArray 折线数据
 @param color 折线颜色
 @param rect 绘制区域
 */
- (void)createLineChart:(NSArray<NSString *> *)dataArray color:(UIColor *)color rect:(CGRect)rect{
    //折线
    __block UIBezierPath *line = [UIBezierPath bezierPath];
    //Y轴最大值
    NSInteger maxDataY = self.riseOfY * (horizontalNum + 1);
    
    [dataArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        /**
         获取每个数据点的 x y，
         x坐标为每个x轴单元格中间
         y坐标，因为y轴值增加是从下到上，y轴坐标增加是从上到下，所以需要换算下;
         */
        
        CGFloat cellWidth = CGRectGetWidth(rect) / self.numOfX;
        CGFloat x = (cellWidth / 2 + CGRectGetMinX(rect)) + idx * cellWidth;
        CGFloat y = CGRectGetHeight(rect) - ((obj.floatValue / maxDataY) * CGRectGetHeight(rect));
        CGPoint point = CGPointMake(x, y);
        if (idx == 0) {
            [line moveToPoint:point];
        }else{
            [line addLineToPoint:point];
        }
        //拐角处的小圆点
        UIBezierPath *circle = [UIBezierPath bezierPathWithArcCenter:point radius:3 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        [color setFill];
        [circle fill];

    }];
    [color setStroke];
    [line stroke];
}

#pragma mark - getter setter
- (NSInteger)numOfX{
 //   return MAX(4, self.month.count);
    return 0;
}


/**
 Y轴等差增量

 * 小于 35，增量为 1 ~ 5;
 * 大于 35，增量为 5(10,15,20,25....)的倍数

 @return Y轴等差增量
 */
- (NSInteger)riseOfY{
    
    //一个月中最高数据,最小为7
    NSInteger maxYData = MAX(horizontalNum, [self maxDataOfDay]);
    NSInteger rise = 1;
    if (maxYData <= 35) {
        rise =  ceil(maxYData * 1.0 / horizontalNum);
    }else{
        rise = ceil(maxYData * 1.0 / horizontalNum / 5) * 5;
    }
    return rise;
}

#pragma mark -


/**
 配置所有折线数据
 */
- (void)configLineData{
    
    self.allTotal    = [NSMutableArray array];
    self.allKnowWell = [NSMutableArray array];
    self.allKnow     = [NSMutableArray array];
    self.allDim      = [NSMutableArray array];
    self.allForget   = [NSMutableArray array];
    self.allNotKnow  = [NSMutableArray array];
    
    
//    [self.month enumerateObjectsUsingBlock:^(LGWeekReportModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self.allTotal    addObject:obj.all];
//        [self.allKnowWell addObject:obj.knowWell];
//        [self.allKnow     addObject:obj.know];
//        [self.allDim      addObject:obj.dim];
//        [self.allForget   addObject:obj.forget];
//        [self.allNotKnow  addObject:obj.notKnow];
//    }];
}

/**
 一个月中最大数据

 @return 最大数
 */
- (NSInteger)maxDataOfDay{
    __block NSInteger max = 0;
    [self.before enumerateObjectsUsingBlock:^(LGWeekReportModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.all.integerValue > max) max = obj.all.integerValue;
    }];
    return max;
}

@end


@implementation LGBeforeChartView

- (instancetype)initWithFrame:(CGRect)frame before:(NSMutableArray<LGWeekReportModel *> *)before maxValue:(CGFloat)maxValue{
    self = [super initWithFrame:frame];
    if (self) {
        self.before = before;
        self.maxValue = maxValue;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    CGFloat space = 16;
    [self.before enumerateObjectsUsingBlock:^(LGWeekReportModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.all.integerValue != 0) {
            CGFloat height = obj.all.integerValue / self.maxValue;
            [self createDayDate:obj rect: CGRectMake(space * (idx + 1) + 30 *idx, CGRectGetMaxY(rect) - height, 30, height)];
        }
       
    }];
}

- (void)createDayDate:(LGWeekReportModel *)model rect:(CGRect)rect{
    //不认识
    CGFloat notKnowHeight = model.notKnow.floatValue / model.all.floatValue * CGRectGetHeight(rect);
    CGRect notKnowRect = CGRectMake(0, CGRectGetMaxY(rect) - notKnowHeight, 30, notKnowHeight);
    [self createItemDate:notKnowRect color:[UIColor lg_colorWithType: LGColor_pk_red]];
    
    //忘记
    CGFloat forgetHeight = model.forget.floatValue / model.all.floatValue * CGRectGetHeight(rect);
    CGRect  forgetRect = CGRectMake(0, CGRectGetMinY(notKnowRect) -  forgetHeight, 30, forgetHeight);
    [self createItemDate:forgetRect color:[UIColor lg_colorWithHexString:@"0975b"]];
    
    //熟知
    CGFloat knowWellHeigth = model.knowWell.floatValue / model.all.floatValue * CGRectGetHeight(rect);
    CGRect knowWellRect = CGRectMake(0, CGRectGetMinY(forgetRect) -  knowWellHeigth, 30, knowWellHeigth);
    [self createItemDate:knowWellRect color:[UIColor lg_colorWithType: LGColor_theme_Color]];
    
    //认识
    CGFloat knowHeight = model.know.floatValue / model.all.floatValue * CGRectGetHeight(rect);
    CGRect knowRect = CGRectMake(0, CGRectGetMinY(knowWellRect) -  knowHeight, 30, knowHeight);
    [self createItemDate:knowRect color:[UIColor lg_colorWithHexString:@"51dje7"]];
    
    //模糊
    CGFloat dimHeight = model.dim.floatValue / model.all.floatValue * CGRectGetHeight(rect);
    CGRect dimRect = CGRectMake(0, CGRectGetMinY(knowRect) -  dimHeight, 30, dimHeight);
    [self createItemDate:dimRect color:[UIColor lg_colorWithHexString:@"4e8eda"]];
    
}


- (void)createItemDate:(CGRect)rect color:(UIColor *)color{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0];
    [color setFill];
    [bezierPath fill];
}

@end

