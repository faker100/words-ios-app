//
//  LGSelectReviewTypeView.h
//  Word
//
//  Created by caoguochi on 2018/3/3.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LGSelectReviewTypeViewDelegate <NSObject>

- (void)selectedReviewType:(LGSelectReviewType)type;

@end

@interface LGSelectReviewTypeView : UIView 

@property (nonatomic, weak) id<LGSelectReviewTypeViewDelegate>delegate;

@end
