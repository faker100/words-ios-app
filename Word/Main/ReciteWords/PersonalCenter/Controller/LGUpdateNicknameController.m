//
//  LGUpdateNicknameController.m
//  Word
//
//  Created by Charles Cao on 2018/3/28.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGUpdateNicknameController.h"
#import "NSString+LGString.h"
#import "LGUserManager.h"
#import "LGNavigationController.h"

@interface LGUpdateNicknameController ()

@end

@implementation LGUpdateNicknameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[((LGNavigationController *)self.navigationController) transparenceBar:NO];
}

- (IBAction)sureAction:(id)sender {
	[self.textField resignFirstResponder];
	NSString *nickname = self.textField.text;
	if ([nickname isNickname]) {
		__weak typeof(self) weakSelf = self;
		[LGProgressHUD showHUDAddedTo:self.view];
		[self.request updateNickname:nickname completion:^(id response, LGError *error) {
			if ([self isNormal:error]) {
				[LGUserManager shareManager].user.nickname = nickname;
				[weakSelf.request resetSessionRequest:[[LGUserManager shareManager].user mj_keyValues]  completion:^{
					[LGProgressHUD showSuccess:@"修改成功" toView:self.view completionBlock:^{
						if (self.updateNicknameCompletion) {
							self.updateNicknameCompletion();
						}
						[self.navigationController popViewControllerAnimated:YES];
					}];
				}];
			}
		}];
	}else{
		[LGProgressHUD showMessage:@"请输入2-8位的昵称" toView:self.view];
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
