//
//  LGPlanTableView.m
//  Word
//
//  Created by Charles Cao on 2018/4/27.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPlanTableView.h"

@implementation LGPlanTableView

//布局完，设置中间高亮区域
- (void)layoutSubviews {
	[super layoutSubviews];
	if (self.backgroundView && self.selectedCellBackgroundView) {
		return;
	}
	self.tableFooterView = [UIView new];
	CGFloat edge = (self.frame.size.height - self.rowHeight) / 2.0f;
	self.contentInset = UIEdgeInsetsMake(edge, 0, edge, 0);
	self.backgroundView = [[UIView alloc]init];
	self.selectedCellBackgroundView = [[UIView alloc]init];
	//设置居中
	self.selectedCellBackgroundView.frame = CGRectMake(0, self.frame.size.height/2.0 - self.rowHeight / 2.0 , self.frame.size.width, self.rowHeight);
	self.selectedCellBackgroundView.backgroundColor = [UIColor lg_colorWithHexString:@"e7e5e5"];
	[self.backgroundView addSubview:self.selectedCellBackgroundView];
}

@end
