//
//  LGFindPasswordController.h
//  Word
//
//  Created by Charles Cao on 2018/1/25.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LGFindPasswordControllerDelegate

//找回密码成功
- (void)findPasswordSuccess:(NSString *)username password:(NSString *)password;

@end

@interface LGFindPasswordController : UIViewController

@property (nonatomic, weak) id<LGFindPasswordControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *checkCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *checkCodeButton;

@end
