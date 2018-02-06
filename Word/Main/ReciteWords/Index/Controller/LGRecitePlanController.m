//
//  LGRecitePlanController.m
//  Word
//
//  Created by Charles Cao on 2018/2/6.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGRecitePlanController.h"

@interface LGRecitePlanController ()

@end

@implementation LGRecitePlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self configData];
}

- (void)configData{
    __weak typeof(self) weakSelf = self;
    [self.request requestIndexRecitePlan:^(id response, LGError *error) {
        if ([weakSelf isEqual:error]) {
            NSLog(@"");
        }
    }];
}

/**
 打卡
 */
- (IBAction)clockAction:(UIButton *)sender {
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



@implementation LGDottedLineView

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //设置虚线颜色
    CGContextSetStrokeColorWithColor(currentContext, [UIColor whiteColor].CGColor);
    //设置虚线宽度
    CGContextSetLineWidth(currentContext, 2);
    CGContextSetShouldAntialias(currentContext, NO);
    //设置虚线绘制起点
    CGContextMoveToPoint(currentContext, 0, 0);
    //设置虚线绘制终点
    CGContextAddLineToPoint(currentContext, 0, self.frame.size.height);
    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
    CGFloat arr[] = {2,1};
    //下面最后一个参数“1”代表排列的个数。
    CGContextSetLineDash(currentContext, 0, arr, 1);
    CGContextDrawPath(currentContext, kCGPathStroke);
}


@end
