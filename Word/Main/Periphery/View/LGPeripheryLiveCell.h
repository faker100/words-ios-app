//
//  LGPeripheryLiveCell.h
//  Word
//
//  Created by Charles Cao on 2018/4/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGLivePreviewCell.h"

@interface LGPeripheryLiveCell : UITableViewCell <UITableViewDataSource, UITableViewDataSource>

@property (nonatomic, strong) NSArray<LGLivePreviewModel *> *livePreview;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
