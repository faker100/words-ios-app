//
//  LGImageSearchController.h
//  Word
//
//  Created by caoguochi on 2018/4/15.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGImageSearchController : UIViewController

//中间裁剪区域
@property (weak, nonatomic) IBOutlet UIView *cutView;

//裁剪区域宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cutViewWidthConstraint;
//裁剪区域高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cutViewHeightConstraint;

@end
