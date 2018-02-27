//
//  LGWordErrorViewController.h
//  Word
//
//  Created by Charles Cao on 2018/2/23.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGWordErrorViewController : UIViewController

@property (nonatomic, copy) NSString *wordID;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
