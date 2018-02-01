//
//  UIScrollView+LGRefresh.m
//  Word
//
//  Created by Charles Cao on 2018/1/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "UIScrollView+LGRefresh.h"

@implementation UIScrollView (LGRefresh)

- (void)setHeaderRefresh:(void (^)(void))refreshBlock{
	MJRefreshNormalHeader *headerHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshBlock];
	headerHeader.stateLabel.hidden = YES;
	[headerHeader setTitle:@"" forState:MJRefreshStateIdle];
	headerHeader.lastUpdatedTimeLabel.hidden = YES;
	self.mj_header = headerHeader;
}

- (void)lg_endRefreshing {
	[self.mj_header endRefreshing];
	[self.mj_footer endRefreshing];
}

@end





