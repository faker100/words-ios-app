//
//  LGWordDetailModel.h
//  Word
//
//  Created by Charles Cao on 2018/2/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGFreeWordModel.h"

@class LGSentenceModel , LGWordDetailTableDataSource;
@interface LGWordDetailModel : NSObject

@property (nonatomic, strong) LGFreeWordModel *words;
@property (nonatomic, strong) NSArray<LGSentenceModel *> *sentence;
@property (nonatomic, strong) NSArray<LGSentenceModel *> *lowSentence;


/**
 自定义字段,用于背单词详情页tableview 的数据源
 */
@property (nonatomic, strong) NSMutableArray<LGWordDetailTableDataSource *> *dataSource;

@end

@interface LGSentenceModel : NSObject

@property (nonatomic, strong) NSString *english;
@property (nonatomic, strong) NSString *chinese;

@end

@interface LGWordDetailTableDataSource  : NSObject

@property (nonatomic, strong) NSString *sectionTitle;
@property (nonatomic, strong) NSMutableArray<NSString *> *cellContent;

@end
