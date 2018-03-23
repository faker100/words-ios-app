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
 type = 1 为 LGMatchModel类型
 type = 2 为 LGReadyPKModel类型;
 type = 3 为 nil类型
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

#pragma mark - 准备 pk

@interface LGPKWordModel : NSObject

@property (nonatomic, copy) NSString *answer;
@property (nonatomic, copy) NSString *phonetic_uk; //音标
@property (nonatomic, copy) NSString *select;
@property (nonatomic, copy) NSString *uk_audio;
@property (nonatomic, copy) NSString *word;
@property (nonatomic, copy) NSString *wordsId;

//自定义属性, 以\n 分割 服务器 json 中的 select,在随机打乱答案
@property (nonatomic, copy) NSArray<NSString *> *selectArray;
//在selectArray中正确答案的 index ,0开始
@property (nonatomic, assign) NSInteger trueAnswerIndex;

@end

@interface LGReadyPKModel : NSObject

@property (nonatomic, copy) NSString *totalId;
@property (nonatomic, copy) NSArray<LGPKWordModel *> *words;

@end





