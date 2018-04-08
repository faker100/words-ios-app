//
//  LGPeripheryController.h
//  Word
//
//  Created by Charles Cao on 2018/4/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGPublicCourseCollectionCell.h"

@interface LGPeripheryController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//公开课滚动区域
@property (weak, nonatomic) IBOutlet UICollectionView *publicCollectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;


@end
