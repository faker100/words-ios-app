//
//  LGWordLibraryController.h
//  Word
//
//  Created by Charles Cao on 2018/1/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGWordLibraryController : UIViewController

//左边词库分类
@property (weak, nonatomic) IBOutlet UITableView *libraryTableView;

//右边单词分类
@property (weak, nonatomic) IBOutlet UITableView *wordTypeTableView;

@end
