//
//  LGFreeLibraryWordListController.h
//  Word
//
//  Created by caoguochi on 2018/1/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGWordLibraryModel.h"

@interface LGFreeLibraryWordListController : UIViewController

//单词量
@property (weak, nonatomic) IBOutlet UILabel *wordNumberLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong) LGChildWordLibraryModel *wordLibraryModel;

@end
