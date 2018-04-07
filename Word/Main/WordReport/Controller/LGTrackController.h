//
//  LGTrackController.h
//  Word
//
//  Created by Charles Cao on 2018/3/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGTrackPieView.h"

@interface LGTrackController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//单词总数
@property (weak, nonatomic) IBOutlet UILabel *totalWordsLabel;

//总天数
@property (weak, nonatomic) IBOutlet UILabel *totalDayLabel;

//认识数
@property (weak, nonatomic) IBOutlet UILabel *knowLabel;

//不认识数
@property (weak, nonatomic) IBOutlet UILabel *incognizanceLabel;

//饼状图view
@property (weak, nonatomic) IBOutlet LGTrackPieView *pieView;


@end

