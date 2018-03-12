//
//  LGSettingHeaderView.m
//  Word
//
//  Created by Charles Cao on 2018/3/12.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGSettingHeaderView.h"

@implementation LGSettingHeaderView

- (void)awakeFromNib{
	[super awakeFromNib];
	self.backgroundView.backgroundColor = [UIColor lg_colorWithHexString:@"f3f3f3"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
