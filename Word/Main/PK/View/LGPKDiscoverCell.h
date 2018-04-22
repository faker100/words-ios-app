//
//  LGPKDiscoverCell.h
//  Word
//
//  Created by Charles Cao on 2018/4/4.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGPKDiscoverModel.h"


@interface LGPKDiscoverCell : UITableViewCell

@property (nonatomic, strong) LGPKDiscoverModel *discoverModel;


//背景图
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

//标题
@property (weak, nonatomic) IBOutlet UILabel *discoverTitleLabel;

//名字
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

