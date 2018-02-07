//
//  LGWordTypeCell.m
//  Word
//
//  Created by Charles Cao on 2018/1/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordTypeCell.h"

@implementation LGWordTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
	self.contentView.backgroundColor = selected ? [UIColor lg_colorWithHexString:@"f1efe4"] : [UIColor whiteColor];
    // Configure the view for the selected state
}

- (void)setWordTypeModel:(LGChildWordLibraryModel *)wordTypeModel{
	
	_wordTypeModel = wordTypeModel;
	self.typeNameLabel.text = wordTypeModel.name;
	self.progressLabel.text = [NSString stringWithFormat:@"(%@/%@)",wordTypeModel.userWords,wordTypeModel.total];
	
	CGFloat completionRate = wordTypeModel.userWords.floatValue / wordTypeModel.total.floatValue;
	
	self.progressView.progress = completionRate;
	if (completionRate <= 0.3) {
		self.progressView.trackTintColor = [UIColor lg_colorWithType:LGColor_Dark_Yellow];
	}else if (completionRate <= 0.6){
		self.progressView.trackTintColor = [UIColor lg_colorWithHexString:@"53ABFB"];
	}else if (completionRate <= 0.9){
		self.progressView.trackTintColor = [UIColor lg_colorWithHexString:@"5B50F2"];
	}else if (completionRate == 1){
		self.progressView.trackTintColor = [UIColor lg_colorWithType:LGColor_theme_Color];
	}
}

@end
