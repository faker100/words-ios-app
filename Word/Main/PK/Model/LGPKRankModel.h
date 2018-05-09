//
//  LGPKRankModel.h
//  Word
//
//  Created by Charles Cao on 2018/3/13.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGUserManager.h"


@interface LGRank : NSObject

@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *win;
@property (nonatomic, copy) NSString *lose;
@property (nonatomic, copy) NSString *userWords;
@property (nonatomic, copy) NSString *image;

@end

@interface LGPKRankModel : NSObject

@property (nonatomic, strong) LGUserModel *user;
@property (nonatomic, copy) NSArray<LGRank *> *rankingList;

@end



