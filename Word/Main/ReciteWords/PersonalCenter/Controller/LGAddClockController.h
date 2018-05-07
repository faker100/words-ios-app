//
//  LGAddClockController.h
//  Word
//
//  Created by Charles Cao on 2018/3/29.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGClockModel.h"

@protocol LGAddClockControllerDelegate <NSObject>

- (void)saveClock:(LGClockModel *)clockModel;

@end

@interface LGAddClockController : UIViewController

@property (nonatomic, weak) id<LGAddClockControllerDelegate> delegate;

/**
 需要编辑的闹钟,如果不为nil, 则显示该闹钟
 如果添加新闹钟, editClockModel 为 新建对象;
 */
@property (nonatomic, strong) LGClockModel *clockModel;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *weakLabel;

@end
