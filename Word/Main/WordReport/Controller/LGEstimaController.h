//
//  LGEstimaController.h
//  Word
//
//  Created by caoguochi on 2018/4/1.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGEstimaController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

//音标
@property (weak, nonatomic) IBOutlet UILabel *phoneticLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
