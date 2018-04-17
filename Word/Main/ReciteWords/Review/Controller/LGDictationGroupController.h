//
//  LGDicationGroupController.h
//  Word
//
//  Created by Charles Cao on 2018/4/17.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGDictationGroupController : UIViewController

@property (nonatomic, copy) NSString *totalNum;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, assign) LGWordStatus status;

@end
