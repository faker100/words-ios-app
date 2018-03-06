//
//  LGReviewSelectTimeCell.m
//  Word
//
//  Created by Charles Cao on 2018/3/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGReviewSelectTimeCell.h"

@implementation LGReviewSelectTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	
}

- (void)setDate:(NSDate *)date{
	_date = date;
	self.timeLabel.text = [[self getDateFormatter] stringFromDate:date];
}

- (NSDateFormatter *)getDateFormatter{
	
	static NSDateFormatter *dateFormatter;
	
	if (!dateFormatter) {
		dateFormatter = [[NSDateFormatter alloc]init];
		[dateFormatter setDateFormat:@"yyyy-M-d"];
	}
	return dateFormatter;
}

@end
