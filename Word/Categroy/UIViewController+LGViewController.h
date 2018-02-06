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
 根据 error,显示错误信息,并隐藏 LGProgressHUD

 @param error LGError 对象
 @return 没有错误信息返回 YES, 如果有错误信息返回 NO
 */
- (BOOL)isNormal:(LGError *)error;

@end
