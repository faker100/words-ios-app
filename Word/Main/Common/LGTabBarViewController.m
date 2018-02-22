//
//  LGTabBarViewController.m
//  Word
//
//  Created by Charles Cao on 2018/1/25.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGTabBarViewController.h"
#import "LGTool.h"

@interface LGTabBarViewController ()
{
	/*
	 * 登录界面,为了避免多次跳转,当loginNavigationController为 nil 时候才跳转
	 * 在 viewDidAppear 置为 nil
	 */
	UIViewController *loginNavigationController;
}
@end

@implementation LGTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	UINavigationController *reciteWords = STORYBOARD_VIEWCONTROLLER(@"ReciteWords", @"NavigationController");
	UINavigationController *wordReport  = STORYBOARD_VIEWCONTROLLER(@"WordReport", @"NavigationController");
	UINavigationController *pk		    = STORYBOARD_VIEWCONTROLLER(@"PK", @"NavigationController");
	UINavigationController *periphery   = STORYBOARD_VIEWCONTROLLER(@"Periphery", @"NavigationController");
	self.viewControllers = @[reciteWords,wordReport,pk,periphery ];
    CGSize size = CGSizeMake(self.tabBar.frame.size.width / self.viewControllers.count, self.tabBar.frame.size.height);
	self.tabBar.selectionIndicatorImage = [LGTool createImageWithColor:[UIColor lg_colorWithType:LGColor_theme_Color] size:size];
	
	//服务器返回未登录的时候
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLogin:) name:NO_LOGIN_NOTIFICATION object:nil];
}

- (void)showLogin:(NSNotification *)notification {
	
	NSString *str = notification.userInfo[NO_LOGIN_ALERT_MESSAGE];
	[LGProgressHUD showError:str toView:[UIApplication sharedApplication].keyWindow];
	if (!loginNavigationController) {
		loginNavigationController = STORYBOARD_VIEWCONTROLLER(@"Login", @"LGLoginNavigationController");
		[self presentViewController:loginNavigationController animated:YES completion:nil];
	}
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	loginNavigationController = nil;
}

//设置状态栏颜色
-(UIStatusBarStyle) preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
