//
//  LGReportContainerController.m
//  Word
//
//  Created by Charles Cao on 2018/3/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGReportContainerController.h"

//(163,选择条距离左边最大距离,titleview.width - selectbar.width)
float selectBarLeftSpace = 163;

@interface LGReportContainerController () <UIScrollViewDelegate>

@end

@implementation LGReportContainerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)trackAction:(id)sender {
	[self.scrollView setContentOffset:CGPointZero animated:YES];
}

- (IBAction)reportAction:(id)sender {
	[self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	//scrollview 偏移量换算成顶部选择条距离左边的距离.
	self.selectBarLeftConstraint.constant = scrollView.contentOffset.x / SCREEN_WIDTH * selectBarLeftSpace;;
	[UIView animateWithDuration:0 animations:^{
		[self.selectBar layoutIfNeeded];
	}];
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
