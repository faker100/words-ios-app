//
//  LGUpdateUserInfoController.m
//  Word
//
//  Created by caoguochi on 2018/3/22.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGUpdateUserInfoController.h"

@interface LGUpdateUserInfoController ()
{
    NSString *titleStr;
    CGFloat constant;
}
@end

@implementation LGUpdateUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = titleStr;
    self.verificationCodeWidthConstraint.constant = constant;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sureAction:(id)sender {
    
}



- (void)setType:(LGUpdateUserInfoType)type{
    _type = type;
    if (type == LGUpdateEmail) {
        titleStr = @"修改邮箱";
        constant = 125;
        
    }else if(type == LGUpdatePhone){
        titleStr = @"修改手机号";
        constant = 125;
    }else{
        titleStr = @"修改密码";
        constant = 0;
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
