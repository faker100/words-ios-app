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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cutViewTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cutViewLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cutViewRightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cutViewBottomConstraint;

@end
