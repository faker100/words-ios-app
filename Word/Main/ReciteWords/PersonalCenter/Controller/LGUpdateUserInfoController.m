//
//  LGUpdateUserInfoController.m
//  Word
//
//  Created by caoguochi on 2018/3/22.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGUpdateUserInfoController.h"
#import "NSString+LGString.h"
#import "LGTool.h"
#import "LGUserManager.h"

@interface LGUpdateUserInfoController ()
{
    NSString *titleStr;
    NSString *infoPlaceholder1;
    NSString *infoPlaceholder2;
    CGFloat constant;
    dispatch_source_t time;
}
@end

@implementation LGUpdateUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = titleStr;
    self.textField1.placeholder = infoPlaceholder1;
    self.textField2.placeholder = infoPlaceholder2;
    self.verificationCodeWidthConstraint.constant = constant;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.request requestCheckCodeSure];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sureAction:(id)sender {
    
    NSString *text1 = self.textField1.text;
    NSString *text2 = self.textField2.text;
    
    if (self.type == LGUpdatePhone) {
        if (![text1 isPhoneNum]) {
            [LGProgressHUD showMessage:@"请输入正确的手机号码" toView:self.view];
            return;
        }
        if (text2.length == 0) {
            [LGProgressHUD showMessage:@"请输入验证码" toView:self.view];
            return;
        }
        [LGProgressHUD showHUDAddedTo:self.view];
        [self.request updatePhone:text1 code:text2 completion:^(id response, LGError *error) {
            if ([self isNormal:error]) {
				[self updateInfoSuccess:text1];
            }
        }];
    }else if (self.type == LGUpdateEmail){
        if (![text1 isEmail]) {
            [LGProgressHUD showMessage:@"请输入正确的邮箱" toView:self.view];
            return;
        }
        if (text2.length == 0){
            [LGProgressHUD showMessage:@"请输入验证码" toView:self.view];
            return;
        }
        [LGProgressHUD showHUDAddedTo:self.view];
        [self.request updateEmail:text1 code:text2 completion:^(id response, LGError *error) {
            if ([self isNormal:error]) {
				[self updateInfoSuccess:text1];
            }
        }];
    }else{
        if (![text1 isEqualToString:[LGUserManager shareManager].user.password]) {
            [LGProgressHUD showMessage:@"请输入正确的原密码" toView:self.view];
            return;
        }
        if (text2.length == 0) {
            [LGProgressHUD showMessage:@"请输入新密码" toView:self.view];
            return;
        }
        [LGProgressHUD showHUDAddedTo:self.view];
        [self.request updatePassword:text1 newPassword:text2 completion:^(id response, LGError *error) {
			if ([self isNormal:error]) {
				[self updateInfoSuccess:text1];
			}
			
        }];
    }
}


/**
 修改成功,更新本地

 @param info 修改成功的信息
 */
- (void)updateInfoSuccess:(NSString *)info{
	
	LGUserModel *user = [LGUserManager shareManager].user;
	if (self.type == LGUpdateEmail) {
		user.email = info;
	}else if (self.type == LGUpdatePhone){
		user.phone = info;
	}else{
		user.password = info;
	}
	[self.request resetSessionRequest:[[LGUserManager shareManager].user mj_keyValues]  completion:nil];
	[LGProgressHUD showSuccess:@"修改成功" toView:self.view completionBlock:^{
		[self dismissViewControllerAnimated:YES completion:nil];
	}];
}

//获取验证码
- (IBAction)getCodeAction:(id)sender {
    
    NSString *str = self.textField1.text;
    LGUsernameType usernameType;
    if (self.type == LGUpdatePhone) {
        if ([str isPhoneNum]) {
            usernameType = LGUsernamePhoneType;
        }else{
            [LGProgressHUD showMessage:@"请输入正确的手机号码" toView:self.view];
            return;
        }
    }else {
        if ([str isEmail]) {
            usernameType = LGUsernameEmailType;
        }else{
            [LGProgressHUD showMessage:@"请输入正确的邮箱" toView:self.view];
            return;
        }
    }
    
    [LGProgressHUD showHUDAddedTo:self.view];
     [self.request requestCheckCode:str usernameType:usernameType useType:LGCheckCodeUseTypeChangeUser completion:^(id response, LGError *error) {
        if ([self isNormal:error]) {
            [self beginCountDown];
        }
    }];
}

//倒计时
- (void)beginCountDown{
    self.verificationCodeButton.enabled = NO;
    time = [LGTool beginCountDownWithSecond:4 completion:^(NSInteger currtentSecond) {
        if (currtentSecond == 0) {
            self.verificationCodeButton.enabled = YES;
        }
        [self.verificationCodeButton setTitle:[NSString stringWithFormat:@"%lds",currtentSecond] forState:UIControlStateDisabled];
    }];
}

- (void)setType:(LGUpdateUserInfoType)type{
    _type = type;
    if (type == LGUpdateEmail) {
        titleStr = @"修改邮箱";
        infoPlaceholder1 = @"请填写邮箱";
        infoPlaceholder2 = @"请输入验证码";
        constant = 125;
        
    }else if(type == LGUpdatePhone){
        titleStr = @"修改手机号";
        infoPlaceholder1 = @"请填写手机号";
        infoPlaceholder2 = @"请输入验证码";
        constant = 125;
    }else{
        titleStr = @"修改密码";
        infoPlaceholder1 = @"请填写原密码";
        infoPlaceholder2 = @"请填写新密码";
        constant = 0;
    }
}

- (void)dealloc{
    if (time) {
        dispatch_source_cancel(time);
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
