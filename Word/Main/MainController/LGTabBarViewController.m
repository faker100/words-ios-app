//
//  LGTabBarViewController.m
//  Word
//
//  Created by Charles Cao on 2018/1/25.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGTabBarViewController.h"

@interface LGTabBarViewController ()

@end

@implementation LGTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	UINavigationController *reciteWords = STORYBOARD_VIEWCONTROLLER(@"ReciteWords", @"NavigationController");
	UINavigationController *wordReport  = STORYBOARD_VIEWCONTROLLER(@"WordReport", @"NavigationController");
	UINavigationController *pk		    = STORYBOARD_VIEWCONTROLLER(@"PK", @"NavigationController");
	UINavigationController *periphery   = STORYBOARD_VIEWCONTROLLER(@"Periphery", @"NavigationController");
//	tabBarController.tabBar.selectedImageTintColor = [UIColor orangeColor];
	self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"login_bg_img"];
	self.viewControllers = @[reciteWords,wordReport,pk,periphery];
	
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
