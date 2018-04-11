//
//  LGDottedLineView.h
//  Word
//
//  Created by Charles Cao on 2018/2/22.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 虚线 view
 */
@interface LGDottedLineView : UIView

/**
 虚线颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *strokeColor;

/**
 以","分割的字符串,(例如:"3,2", 先绘制3个点,空2个点,再绘制3个点)
 */
@property (nonatomic, strong) IBInspectable NSString *lengths;

@end
