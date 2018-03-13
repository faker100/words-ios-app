//
//  UITableView+LGRefresh.h
//  Word
//
//  Created by Charles Cao on 2018/2/1.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+LGRefresh.h"

typedef NS_ENUM(NSUInteger, LGCurrentRefreshType) {
	LGRefreshHeader,		//下拉刷新
	LGRefreshFooter,	   //上拉
};

//简单加载更多数据方式
typedef NS_ENUM(NSUInteger, LGTableAddMoreDataType) {
	LGTableReloadOnlyAddRow,		// 用于section始终为1,加载 row 数量的布局
	LGTableReloadOnlyAddSection,    // 用于每个section 的 row 始终为1,加载 section数量 的 group table 样式
};

typedef void (^LGRefreshBlock)(LGCurrentRefreshType type);

@interface UITableView (LGRefresh)

@property (nonatomic, assign) NSInteger currentPage;

/**
 设置上拉,下拉刷新 (如果只需下拉刷新,用(UIScrollView+LGRefresh.h 的 setHeaderRefresh))

 @param refreshBlock 返回当前刷新类型
 */
- (void)setRefreshBlock:(LGRefreshBlock) refreshBlock;


/**
 用于简单 table 样式的加载更多数据,加载前先更新好数据源
 
 @param count 需要加载的数量
 
 @param type LGTableAddMoreDataType
 */
- (void)addMoreDataWithType:(LGTableAddMoreDataType)type count:(NSInteger)count;

@end
