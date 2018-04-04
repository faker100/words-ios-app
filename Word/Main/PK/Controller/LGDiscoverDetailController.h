//
//  LGDiscoverDetailController.h
//  Word
//
//  Created by Charles Cao on 2018/4/4.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGPKDiscoverModel.h"

@interface LGDiscoverDetailController : UIViewController

@property (nonatomic, strong) LGPKDiscoverModel *discoverModel;

@property (weak, nonatomic) IBOutlet UIImageView *discoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *discoverTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *discoverNameLabel;

@end
