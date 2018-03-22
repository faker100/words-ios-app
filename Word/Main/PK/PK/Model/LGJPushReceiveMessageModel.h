//
//  LGJpushReceiveMessageModel.h
//  Word
//
//  Created by Charles Cao on 2018/3/22.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LGExtrasModel;

#pragma mark - 应用内消息 model

@interface LGJPushReceiveMessageModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) LGExtrasModel *extras;

@end

@interface LGExtrasModel : NSObject


/**
 消息不同  message  类型不同,
 type = 1 为 LGMatchUserModel类型
 */
@property (nonatomic, strong) id message;
@property (nonatomic, assign) NSInteger type;

@end

#pragma mark - 匹配用户

@interface LGMatchUserModel : NSObject

@property(nonatomic, copy) NSString *image;
@property(nonatomic, copy) NSString *nickname;
@property(nonatomic, copy) NSString *uid;
@property(nonatomic, copy) NSString *lose;
@property(nonatomic, copy) NSString *win;
@property(nonatomic, copy) NSString *words;

@end

@interface LGMatchModel : NSObject

@property (nonatomic, strong) LGMatchUserModel *user1;
@property (nonatomic, strong) LGMatchUserModel *user2;

@end

#pragma mark - 取消匹配

