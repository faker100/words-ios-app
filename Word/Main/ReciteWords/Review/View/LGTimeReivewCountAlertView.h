//
//  LGTimeReivewCountAlertView.h
//  Word
//
//  Created by Charles Cao on 2018/3/6.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LGTimeReivewCountAlertViewDelegate

- (void)beginReview;

@end

@interface LGTimeReivewCountAlertView : UIView

@property (nonatomic, weak) id<LGTimeReivewCountAlertViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@end
