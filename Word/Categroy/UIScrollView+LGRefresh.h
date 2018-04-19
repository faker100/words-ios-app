//
//  UIScrollView+LGRefresh.h
//  Word
//
//  Created by Charles Cao on 2018/1/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>



@interface UIScrollView (LGRefresh)

/**
 设置下拉刷新 (如果需要上拉和下拉,用(UITableView+LGRefresh.h 的setRefreshBlock))

 */
- (void)setHeaderRefresh:(void (^)(void))refreshBlock;


/**
 结束刷新
 */
- (void)lg_endRefreshing;

@end
