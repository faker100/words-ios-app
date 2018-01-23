//
//  LGRegisterController.m
//  Word
//
//  Created by Charles Cao on 2018/1/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGRegisterController.h"

@interface LGRegisterController ()

@end

@implementation LGRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
	[self.request requestCheckCodeSure];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCheckCodeAction:(UIButton *)sender {
	[LGProgressHUD showHUDAddedTo:self.view animated:YES];
	[self.request requestCheckCode:self.usernameTextField.text usernameType:LGUsernamePhoneType useType:LGCheckCodeUseTypeRegister completion:^(id response, NSString *errorMessage) {
		if (StringNotEmpty(errorMessage)) {
//			LGProgressHUD 
		}
	}];
}

- (IBAction)registerAction:(id)sender {
	
}

//同意用户协议
- (IBAction)agreeAction:(UIButton *)sender {
	sender.selected = !sender.selected;
}

- (IBAction)loginAction:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
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
