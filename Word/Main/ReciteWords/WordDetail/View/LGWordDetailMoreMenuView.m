//
//  LGWordDetailMoreMenuView.m
//  Word
//
//  Created by Charles Cao on 2018/5/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordDetailMoreMenuView.h"
#import "LGUserManager.h"

@implementation LGWordDetailMoreMenuView

- (void)awakeFromNib{
	[super awakeFromNib];
	[self setMute:[LGUserManager shareManager].muteWithWordDetail];
	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//报错 action
- (IBAction)submitErrorAction:(id)sender {
	[self.delegate submiteError];
	[self removeFromSuperview];
}

//静音 action
- (IBAction)muteAction:(UISwitch *)sender {
	[self setMute:sender.on];
}

//设置静音
- (void)setMute:(BOOL) flag {
	NSDictionary *muteAttribute = @{
									NSFontAttributeName : [UIFont systemFontOfSize:15],
									NSForegroundColorAttributeName  : [UIColor lg_colorWithType:LGColor_Title_1_Color]
									};
	NSDictionary *muteFlag = @{
							   NSFontAttributeName : [UIFont systemFontOfSize:12],
							   NSForegroundColorAttributeName  : [UIColor lg_colorWithType:LGColor_Title_2_Color]
							   };
	if (flag) {
		
		self.muteSwitch.on = YES;
		NSMutableAttributedString *mute = [[NSMutableAttributedString alloc]initWithString:@"静音(开启)"];
		[mute addAttributes:muteAttribute range:NSMakeRange(0, 2)];
		[mute addAttributes:muteFlag range:NSMakeRange(2, 4)];
		self.muteLabel.attributedText = mute;
	}else{
		NSMutableAttributedString *mute = [[NSMutableAttributedString alloc]initWithString:@"静音(关闭)"];
		[mute addAttributes:muteAttribute range:NSMakeRange(0, 2)];
		[mute addAttributes:muteFlag range:NSMakeRange(2, 4)];
		self.muteSwitch.on = NO;
		self.muteLabel.attributedText = mute;
	}
	
	[LGUserManager shareManager].muteWithWordDetail = flag;
}

- (IBAction)tapAction:(id)sender {
	[self removeFromSuperview];
}


@end
