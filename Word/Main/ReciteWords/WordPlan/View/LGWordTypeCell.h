//
//  LGWordTypeCell.h
//  Word
//
//  Created by Charles Cao on 2018/1/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGWordLibraryModel.h"
#import "LGProgressView.h"

@interface LGWordTypeCell : UITableViewCell

@property (nonatomic, strong) LGChildWordLibraryModel *wordTypeModel;

//分类名字
@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;

//进度label
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

//进度条
@property (weak, nonatomic) IBOutlet LGProgressView *progressView;
//已经添加
@property (weak, nonatomic) IBOutlet UIImageView *didAddImageView;

@end
