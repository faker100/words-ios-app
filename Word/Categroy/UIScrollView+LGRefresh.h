//
//  UIScrollView+LGRefresh.h
//  Word
//
//  Created by Charles Cao on 2018/1/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

typedef NS_ENUM(NSUInteger, LGRefreshType) {
	LGRefreshOnlyHeader,		//只有下拉刷新
	LGRefreshHeaderAndFooter,   //上拉,下拉
};

@interface UIScrollView (LGRefresh)

- (void)setRefreshType:(LGRefreshType)type refreshBlock:(MJRefreshComponentRefreshingBlock) refreshBlock;

@end
