//
//  LGSignCollectionCell.m
//  Word
//
//  Created by Charles Cao on 2018/4/10.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGSignCollectionCell.h"

@implementation LGSignCollectionCell

- (void)setSignModel:(LGSignCellModel *)signModel{
	
	switch (signModel.signType) {
		case LGSignNone:
			[self.dayButton setBackgroundImage:nil forState:UIControlStateNormal];
			break;
		case LGSignDidSign:
			[self.dayButton setBackgroundImage:[UIImage imageNamed:@"sign"] forState:UIControlStateNormal];
			break;
		case LGsignToday:
			[self.dayButton setBackgroundImage:[UIImage imageNamed:@"sign_today"] forState:UIControlStateNormal];
			break;
			
		default:
			break;
	}
	[self.dayButton setTitle:signModel.day forState:UIControlStateNormal];
}

@end


@implementation LGSignCellModel

@end
