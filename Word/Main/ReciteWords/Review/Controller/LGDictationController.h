//
//  LGDictationController.h
//  Word
//
//  Created by Charles Cao on 2018/3/6.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGDictationController : UIViewController

//模糊
@property (weak, nonatomic) IBOutlet UILabel *dimLabel;

//不认识
@property (weak, nonatomic) IBOutlet UILabel *incognizantLabel;

//全部词组
@property (weak, nonatomic) IBOutlet UILabel *allLabel;


@end
