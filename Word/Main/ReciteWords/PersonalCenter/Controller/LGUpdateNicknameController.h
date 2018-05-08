//
//  LGUpdateNicknameController.h
//  Word
//
//  Created by Charles Cao on 2018/3/28.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGUpdateNicknameController : UIViewController

//主要用于登录时,上传昵称的回调
@property (copy, nonatomic) void (^updateNicknameCompletion)(void);

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
