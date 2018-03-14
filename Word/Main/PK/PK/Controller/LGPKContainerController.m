//
//  LGPKContainerController.m
//  Word
//
//  Created by Charles Cao on 2018/3/13.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPKContainerController.h"

@interface LGPKContainerController () <UIScrollViewDelegate>

@end

@implementation LGPKContainerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pkAction:(id)sender {
	
}

- (IBAction)discoverAction:(id)sender {
	
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	NSLog(@"%f",scrollView.contentOffset.x);
	self.selectBarLeftConstraint.constant = scrollView.contentOffset.x;
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
