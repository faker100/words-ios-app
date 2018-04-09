//
//  LGCourseDetailController.h
//  Word
//
//  Created by Charles Cao on 2018/4/9.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGCourseModel.h"

@interface LGCourseDetailController : UIViewController

@property (nonatomic, strong) LGCourseModel *courseModel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *joinNumLabel;

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end
