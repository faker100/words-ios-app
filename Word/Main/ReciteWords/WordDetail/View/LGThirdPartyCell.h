//
//  LGThirdPartyCell.h
//  Word
//
//  Created by Charles Cao on 2018/4/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LGThirdPartyType) {
	LGThirdPartyYouDao,
	LGThirdPartyJinShan,
	LGThirdPartyBiYing,
	LGThirdPartyXinHua
};

@protocol LGThirdPartyCellDelegate

- (void)selectedThirdParty:(LGThirdPartyType) type;

@end

@interface LGThirdPartyCell : UITableViewCell

@property (nonatomic, weak) id<LGThirdPartyCellDelegate> delegate;

@end
