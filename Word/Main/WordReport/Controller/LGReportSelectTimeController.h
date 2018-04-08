//
//  LGReportSelectTimeController.h
//  Word
//
//  Created by Charles Cao on 2018/4/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LGReportSelectTimeControllerDelegate<NSObject>

- (void)selectedTime:(NSString *)timeStr;

@end

@interface LGReportSelectTimeController : UIViewController

@property (nonatomic, weak) id<LGReportSelectTimeControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;


@end
