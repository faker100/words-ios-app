//
//  LGRegisterController.h
//  Word
//
//  Created by Charles Cao on 2018/1/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LGRegisterControllerDelegate <NSObject>

//注册成功
- (void)registSuccess:(NSString *)username password:(NSString *)password;

@end

@interface LGRegisterController : UIViewController

@property (nonatomic, weak) id<LGRegisterControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *checkCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *checkCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;

@end
