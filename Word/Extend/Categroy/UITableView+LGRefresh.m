//
//  UITableView+LGRefresh.m
//  Word
//
//  Created by Charles Cao on 2018/2/1.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "UITableView+LGRefresh.h"

@implementation UITableView (LGRefresh)

- (void)setRefreshBlock:(LGRefreshBlock) refreshBlock{
	
	MJRefreshNormalHeader *headerHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		self.currentPage = 1;
		refreshBlock(LGRefreshHeader);
	}];
	headerHeader.stateLabel.hidden = YES;
	[headerHeader setTitle:@"" forState:MJRefreshStateIdle];
	headerHeader.lastUpdatedTimeLabel.hidden = YES;
	self.mj_header = headerHeader;
	
	MJRefreshBackNormalFooter *footerHeader = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
		self.currentPage +=1;
		refreshBlock(LGRefreshFooter);
	}];
	footerHeader.stateLabel.hidden = YES;
	self.mj_footer = footerHeader;
}

- (void)addMoreDataWithType:(LGTableAddMoreDataType)type count:(NSInteger)count{
	
	
	 if(count > 0){
		NSMutableArray *indexPathArray =  [NSMutableArray array];
		NSMutableIndexSet *sectionIndexSex = [NSMutableIndexSet indexSet];
		for (int i = 0; i < count; i++) {
			
			NSIndexPath *indexPath;
			if (type == LGTableReloadOnlyRow) {
				indexPath = [NSIndexPath indexPathForRow:[self numberOfRowsInSection:0] + i inSection:0];
			}else{
				indexPath = [NSIndexPath indexPathForRow:0 inSection:[self numberOfSections] + i];
				[sectionIndexSex addIndex:[self numberOfSections] + i];
			}
			[indexPathArray addObject:indexPath];
		}
		[self beginUpdates];
		if (type == LGTableReloadOnlySection)
		{
			[self insertSections:sectionIndexSex withRowAnimation:UITableViewRowAnimationFade];
		}
		[self insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
		[self endUpdates];
	}else{
		self.currentPage --;
	}
	
	
}

- (NSInteger)currentPage{
	NSNumber *page = objc_getAssociatedObject(self, _cmd);
	return MAX(1, page.integerValue);
}

- (void)setCurrentPage:(NSInteger)currentPage{
	objc_setAssociatedObject(self, @selector(currentPage), @(currentPage), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
