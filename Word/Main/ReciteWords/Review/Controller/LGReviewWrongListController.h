//
//  LGReviewWrongListController.h
//  Word
//
//  Created by Charles Cao on 2018/3/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGReviewWrongListController : UIViewController


@property (nonatomic, copy) NSString *totalNum;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
