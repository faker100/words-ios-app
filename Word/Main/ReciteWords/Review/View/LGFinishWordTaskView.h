//
//  LGFinishWordTaskView.h
//  Word
//
//  Created by Charles Cao on 2018/3/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LGFinishWordTaskView : UIView

@property (nonatomic, copy) void(^sureActionBlock)(void);

+ (void)showFinishToView:(UIView *)view sureBlock:(void(^)(void))sureBlock;

@end
