//
//  LGEstimateResultHeaderView.h
//  Word
//
//  Created by Charles Cao on 2018/4/3.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LGEstimateResultHeaderType) {
	LGEstimateResultKnow,
	LGEstimateResultNotKnow,
};

@protocol LGEstimateResultHeaderDelegate <NSObject>

- (void)tapAction;

@end

@interface LGEstimateResultHeaderView : UITableViewHeaderFooterView

@property (nonatomic, assign) LGEstimateResultHeaderType type;

@property (nonatomic, weak) id<LGEstimateResultHeaderDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *moreImageView;

@property (weak, nonatomic) IBOutlet UILabel *sectionTitleLabel;

//左边颜色竖条
@property (weak, nonatomic) IBOutlet UIView *leftView;


/**
 设置 header

 @param num 数量
 @param type 认识/不认识
 */
- (void)setNum:(NSString *)num type:(LGEstimateResultHeaderType)type;

@end
