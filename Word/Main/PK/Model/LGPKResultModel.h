//
//  LGPKResultModel.h
//  Word
//
//  Created by Charles Cao on 2018/3/27.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LGPKRighOrWrongModel, LGQuestionInfoModel;

@interface LGPKResultModel : NSObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSArray <LGPKRighOrWrongModel *> *data;
@property (nonatomic, copy) NSArray <LGQuestionInfoModel *> *questionInfo;

@end

@interface LGPKRighOrWrongModel : NSObject

@property (nonatomic, copy) NSString *aFalse;
@property (nonatomic, copy) NSString *aTrue;

@end

@interface LGQuestionInfoModel : NSObject

@property (nonatomic, copy) NSString *words;
@property (nonatomic, copy) NSString *answer;
@property (nonatomic, assign) BOOL min;   //我回答正确/错误
@property (nonatomic, assign) BOOL peer; //对手回答正确/错误

@end
