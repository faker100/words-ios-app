//
//  LGPublicDetailController.h
//  Word
//
//  Created by Charles Cao on 2018/4/9.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGPeripheryModel.h"

@interface LGPublicDetailController : UIViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;


@property (nonatomic, strong) LGRecentClassModel *classModel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *joinLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end
