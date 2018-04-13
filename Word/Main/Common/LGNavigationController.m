//
//  LGNavigationController.m
//  Word
//
//  Created by Charles Cao on 2018/1/26.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGNavigationController.h"

@interface LGNavigationController () <UINavigationBarDelegate>

@end

@implementation LGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.navigationBar.delegate = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
	return  UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
}

- (void)transparenceBar:(BOOL) flag{
	UIImage *bgImage = flag ? [UIImage new] : nil;
	UIImage *shadowImage = flag ? [UIImage new] : nil;
	[self.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
	[self.navigationBar setShadowImage:shadowImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)lg_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
	
	//获取当前 controller
	UIViewController *currentController = self.viewControllers.lastObject;
	//push 到下一个 controller
	[self pushViewController:viewController animated:animated];
	
	//移除上一个 controller
	NSMutableArray *controllers = [NSMutableArray arrayWithArray:self.viewControllers];
	[controllers removeObject:currentController];
	[self setViewControllers:controllers animated:YES];
}

#pragma mark - UINavigationBarDelegate

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item{
    item.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    return YES;
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
