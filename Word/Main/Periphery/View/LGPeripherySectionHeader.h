//
//  LGPeripherySectionHeader.h
//  Word
//
//  Created by Charles Cao on 2018/4/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, LGPeripherySectionHeaderType) {
	LGPeripherySectionLive,    //直播预告
	LGPeripherySectionClassic, //经典课程
	LGPeripherySectionCase,   //案例
};

@protocol LGPeripherySectionHeaderDelegate

- (void)moreWithType:(LGPeripherySectionHeaderType) type;

@end

@interface LGPeripherySectionHeader : UITableViewHeaderFooterView

@property (nonatomic, weak) id<LGPeripherySectionHeaderDelegate> delegate;

@property (nonatomic, assign) LGPeripherySectionHeaderType type;

@property (weak, nonatomic) IBOutlet UILabel *sectionTitleLabel;

@property (weak, nonatomic) IBOutlet UIButton *moreButton;


@end
