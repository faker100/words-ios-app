//
//  LGPKMatchingController.m
//  Word
//
//  Created by Charles Cao on 2018/3/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPKMatchingController.h"

@interface LGPKMatchingController ()

@end

@implementation LGPKMatchingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestPkMatchingCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			NSLog(@"%@",response);
			self.testLabel.text = [NSString stringWithFormat:@"%@",response];
		}
	}];
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
