//
//  LGProgressView.h
//  Word
//
//  Created by Charles Cao on 2018/1/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface LGProgressView : UIView

//进度
@property (nonatomic, assign) IBInspectable float progress;

//进度颜色
@property (nonatomic, strong) IBInspectable UIColor *trackTintColor;

//剩余进度颜色
@property (nonatomic, strong) IBInspectable UIColor *progressTintColor;

//弧度
@property (nonatomic, assign) IBInspectable CGFloat radius;

@end
