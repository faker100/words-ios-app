//
//  LGIdeaController.m
//  Word
//
//  Created by Charles Cao on 2018/4/23.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGIdeaController.h"

@interface LGIdeaController ()

@end

@implementation LGIdeaController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitAction:(id)sender {
	NSString *str = self.textView.text;
	if (str.length > 0) {
		[LGProgressHUD showHUDAddedTo:self.view];
		[self.request submitIdea:str completion:^(id response, LGError *error) {
			if ([self isNormal:error]) {
				[LGProgressHUD showSuccess:@"提交成功" toView: self.view completionBlock:^{
					[self.navigationController popViewControllerAnimated:YES];
				}];
			}
		}];
	}else{
		[LGProgressHUD showMessage:@"请填写意见" toView: self.view];
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
