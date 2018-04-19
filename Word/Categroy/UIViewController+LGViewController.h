//
//  UIViewController+LGViewController.h
//  Word
//
//  Created by Charles Cao on 2018/1/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+LGRequest.h"

@interface UIViewController (LGViewController)


/**
 根据 error,显示错误信息,并隐藏之前的LGProgressHUD ,信息显示在 self.view 中

 @param error LGError 对象
 @return 没有错误信息返回 YES, 如果有错误信息返回 NO
 */
- (BOOL)isNormal:(LGError *)error;



/**
 根据 error,显示错误信息在指定的 view 上,并隐藏之前的 LGProgressHUD

 @param error LGError 对象
 @param view 指定信息显示的 view,如果 view 为 nil 则为 self.view
 @return 没有错误信息返回 YES, 如果有错误信息返回 NO
 */
- (BOOL)isNormal:(LGError *)error showInView:(UIView *)view;

@end
