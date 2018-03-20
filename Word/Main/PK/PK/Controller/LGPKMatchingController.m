//
//  LGPKMatchingController.m
//  Word
//
//  Created by Charles Cao on 2018/3/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPKMatchingController.h"
#import "JPUSHService.h"

@interface LGPKMatchingController ()

@end

@implementation LGPKMatchingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNotification];
	
	[self beginMatching];

//	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestPkMatchingCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
		
		}
	}];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];
	self.edgesForExtendedLayout=UIRectEdgeTop;
	//self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}


- (void)viewDidLayoutSubviews{
	NSLog(@"11111");
	CGFloat radius = CGRectGetWidth(self.opponentHeadImageView.frame) / 2.0f;
	self.opponentWordNumLabel.layer.cornerRadius = radius;
	self.opponentHeadImageView.layer.cornerRadius = radius;
}

//开始匹配
- (void)beginMatching{
	NSArray<UIImage *> *imageArray = @[
										[UIImage imageNamed:@"pk_matching0"],
										[UIImage imageNamed:@"pk_matching1"],
										[UIImage imageNamed:@"pk_matching2"],
										[UIImage imageNamed:@"pk_matching3"],
										];
	[self.matchingImageView setAnimationImages:imageArray];
	self.matchingImageView.animationDuration = 1;
	self.matchingImageView.animationRepeatCount = 0;
	[self.matchingImageView startAnimating];
}

/*********************** 接收自定义消息 **************************/
//添加监听者
- (void)addNotification{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    [LGProgressHUD showMessage:userInfo.description toView:self.view.window];
    NSLog(@"%@",userInfo);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kJPFNetworkDidReceiveMessageNotification object:nil];
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


