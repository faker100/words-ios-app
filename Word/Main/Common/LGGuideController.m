//
//  LGGuideController.m
//  Word
//
//  Created by Charles Cao on 2018/4/23.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGGuideController.h"
#import "LGUserManager.h"

@interface LGGuideController ()<UIScrollViewDelegate>

@end

@implementation LGGuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//结束引导页
- (void)finishGuide{
	[LGUserManager shareManager].isFirstLaunch = YES;
	[self.delegate finishGuide];
	[self.view removeFromSuperview];
	[self removeFromParentViewController];
}

//消失引导页
- (IBAction)tapAction:(id)sender {
	[self finishGuide];
}

//下一页
- (IBAction)nextAction:(UITapGestureRecognizer *)sender {
	UIView *view = sender.view;
	[self.scrollView setContentOffset:CGPointMake(CGRectGetMaxX(view.frame), 0) animated:YES];
	CGFloat offset_x = self.scrollView.contentOffset.x;
	NSInteger index = offset_x / SCREEN_WIDTH;
	[self.pageControl setCurrentPage:index];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	CGFloat offset_x = scrollView.contentOffset.x;
	NSInteger index = offset_x / SCREEN_WIDTH;
	//最后一次
	if (index == 4) {
		[self finishGuide];
	}else{
		[self.pageControl setCurrentPage:index];
	}
	
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
