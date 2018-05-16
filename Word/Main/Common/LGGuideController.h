//
//  LGGuideController.h
//  Word
//
//  Created by Charles Cao on 2018/4/23.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LGGuideControllerDelegate <NSObject>

- (void)finishGuide;

@end

@interface LGGuideController : UIViewController

@property (nonatomic, weak) id<LGGuideControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIImageView *guideImageView_1;
@property (weak, nonatomic) IBOutlet UIImageView *guideImageView_2;
@property (weak, nonatomic) IBOutlet UIImageView *guideImageView_3;
@property (weak, nonatomic) IBOutlet UIImageView *guideImageView_4;

@end
