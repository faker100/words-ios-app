//
//  LGPKContainerController.h
//  Word
//
//  Created by Charles Cao on 2018/3/13.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGPKContainerController : UIViewController 

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//navigationBar中选择条左边约束,用来设置选择条左右滑动
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectBarLeftConstraint;

//navigationBar中滚动选择条
@property (weak, nonatomic) IBOutlet UIView *selectBar;

@end
