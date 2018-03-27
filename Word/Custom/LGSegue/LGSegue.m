//
//  LGSegue.m
//  Word
//
//  Created by Charles Cao on 2018/3/27.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGSegue.h"

@implementation LGSegue

/**
 自定义跳转,先正常 push保证当前页面controller的各种生命周期函数调用
 再在 navigation.controllers 中去移除当前页面
 */
- (void)perform{
	
	UIViewController *sourceVC = self.sourceViewController;
	UIViewController *destinationVC = self.destinationViewController;
	[sourceVC.navigationController pushViewController:destinationVC animated:YES];
	
	NSMutableArray  *controllers = [NSMutableArray arrayWithArray:sourceVC.navigationController.viewControllers];
	[controllers removeObject:sourceVC];
	[sourceVC.navigationController setViewControllers:controllers animated:YES];
}

@end
