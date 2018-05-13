//
//  LGTabBarViewController.m
//  Word
//
//  Created by Charles Cao on 2018/1/25.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGTabBarViewController.h"
#import "LGTool.h"
#import "LGGuideController.h"
#import "LGUserManager.h"
#import "LGStudyTypeController.h"

@interface LGTabBarViewController ()<LGGuideControllerDelegate>
{
	/*
	 * 登录界面,为了避免多次跳转,当loginNavigationController为 nil 时候才跳转
	 * 在 viewDidAppear 置为 nil
	 */
	UIViewController *loginNavigationController;
	
	//引导页
	LGGuideController *guideController;
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
	self.viewControllers = @[reciteWords,wordReport,pk,periphery];
	
	
	
	//跳转登录,( 服务器返回未登录的时候 )
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLogin:) name:SHOW_LOGIN_NOTIFICATION object:nil];
	
	[self showGuideController];
}

- (void)viewDidLayoutSubviews{
    [self configTabbarItem];
}
//配置 tabbaritem
- (void)configTabbarItem{
	//tabbaritem 选中时背景高亮绿色
    if (self.tabBar.selectionIndicatorImage) {
        return;
    }
	CGSize size = CGSizeMake(self.tabBar.frame.size.width / self.viewControllers.count, self.tabBar.frame.size.height);
	self.tabBar.selectionIndicatorImage = [LGTool createImageWithColor:[UIColor lg_colorWithType:LGColor_theme_Color] size:size];
}

- (void)showLogin:(NSNotification *)notification {
	
	NSString *str = notification.userInfo[NO_LOGIN_ALERT_MESSAGE];
	if (str) {
		[LGProgressHUD showError:str toView:[UIApplication sharedApplication].keyWindow];
	}
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

//显示引导页
- (void)showGuideController{
	if ([LGUserManager shareManager].isFirstLaunch) {
		guideController = STORYBOARD_VIEWCONTROLLER(@"Main", @"LGGuideController");
		guideController.delegate = self;
	//	[self addChildViewController:guideController];
		[self.view addSubview:guideController.view];
	}
}

#pragma mark - LGGuideControllerDelegate
//引导页消失后弹出学习模式
- (void)finishGuide{
	guideController = nil;
	LGStudyTypeController *controller = STORYBOARD_VIEWCONTROLLER(@"ReciteWords", @"LGStudyTypeController");
	controller.isPresentFromGuide = YES;
	[self presentViewController:controller animated:YES completion:nil];
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
