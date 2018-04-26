//
//  LGGuideController.h
//  Word
//
//  Created by Charles Cao on 2018/4/23.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LGGuideControllerDelegate

- (void)finishGuide;

@end

@interface LGGuideController : UIViewController

@property (nonatomic, weak) id<LGGuideControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
