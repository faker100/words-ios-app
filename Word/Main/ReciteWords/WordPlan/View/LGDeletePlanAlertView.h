//
//  LGDeletePlanAlertView.h
//  Word
//
//  Created by Charles Cao on 2018/2/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGDeletePlanAlertView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy) void(^deleteBlock)(void);

@end
