//
//  LGNavigationController.h
//  Word
//
//  Created by Charles Cao on 2018/1/26.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGNavigationController : UINavigationController


/**
 push 到下一个 controller 后,移除上一个 controller

 @param viewController 下一个 controller
 @param animated 动画
 */
- (void)lg_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
