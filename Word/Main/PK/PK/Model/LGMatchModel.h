//
//  LGMatchModel.h
//  Word
//
//  Created by Charles Cao on 2018/3/21.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  LGMatchUserModel;

@interface LGMatchModel : NSObject

@property (nonatomic, strong) LGMatchUserModel *user1;
@property (nonatomic, strong) LGMatchUserModel *user2;

@end

@interface LGMatchUserModel : NSObject

@property(nonatomic, copy) NSString *image;
@property(nonatomic, copy) NSString *nickname;
@property(nonatomic, copy) NSString *uid;
@property(nonatomic, copy) NSString *lose;
@property(nonatomic, copy) NSString *win;
@property(nonatomic, copy) NSString *words;

@end
