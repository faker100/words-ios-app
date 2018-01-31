//
//  UIScrollView+LGRefresh.m
//  Word
//
//  Created by Charles Cao on 2018/1/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "UIScrollView+LGRefresh.h"

@implementation UIScrollView (LGRefresh)


- (void)setRefreshType:(LGRefreshType)type refreshBlock:(MJRefreshComponentRefreshingBlock) refreshBlock{
	
	MJRefreshNormalHeader *headerHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshBlock];
	headerHeader.stateLabel.hidden = YES;
	[headerHeader setTitle:@"" forState:MJRefreshStateIdle];
	headerHeader.lastUpdatedTimeLabel.hidden = YES;
	self.mj_header = headerHeader;
	
	if (type == LGRefreshHeaderAndFooter) {
		MJRefreshBackNormalFooter *footerHeader = [MJRefreshBackNormalFooter footerWithRefreshingBlock:refreshBlock];
		footerHeader.stateLabel.hidden = YES;
		self.mj_footer = footerHeader;
	}
}

@end





