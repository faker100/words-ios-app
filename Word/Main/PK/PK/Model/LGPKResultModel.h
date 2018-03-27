//
//  LGPKResultModel.h
//  Word
//
//  Created by Charles Cao on 2018/3/27.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LGPKRighOrWrongModel;

@interface LGPKResultModel : NSObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSArray <LGPKRighOrWrongModel*> *data;

@end

@interface LGPKRighOrWrongModel : NSObject

@property (nonatomic, copy) NSString *aFalse;
@property (nonatomic, copy) NSString *aTrue;

@end
