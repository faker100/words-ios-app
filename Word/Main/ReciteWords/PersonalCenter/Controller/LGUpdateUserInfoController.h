//
//  LGUpdateUserInfoController.h
//  Word
//
//  Created by caoguochi on 2018/3/22.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LGUpdateUserInfoType) {
    LGUpdatePhone,
    LGUpdateEmail,
    LGUpdatePassword,
};

@interface LGUpdateUserInfoController : UIViewController

@property (nonatomic, assign) LGUpdateUserInfoType type;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

//原信息
@property (weak, nonatomic) IBOutlet UITextField *originalInfoTextField;

//新信息
@property (weak, nonatomic) IBOutlet UITextField *updateInfoTextField;
//获取验证码
@property (weak, nonatomic) IBOutlet UIButton *verificationCodeButton;

//验证码宽度约束，值为 0 隐藏，125 显示
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verificationCodeWidthConstraint;

@end
