//
//  LGWordDetailModel.h
//  Word
//
//  Created by Charles Cao on 2018/2/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGFreeWordModel.h"

//cell 类型
typedef NS_ENUM(NSUInteger, LGWordDetailTableDataSourceType) {
	LGDataSourceText,	     //普通文字类型
	LGDataSourceExamplesSentence, //例句
	LGDataSourceQuestion,    //列题
	LGDataSourceThirdParty,  //第三方
	LGDataSourceSimilarWords //形近词
};

@class LGSentenceModel , LGWordDetailTableDataSource, LGQuestionSelectItemModel, LGQuestionModel, LGSimilarWordsModel;
@interface LGWordDetailModel : NSObject

@property (nonatomic, assign) NSInteger needReviewWords; //新艾宾浩斯复习
@property (nonatomic, assign) NSInteger userNeedReviewWords;//老艾宾浩斯需复习 / 正常背单词
@property (nonatomic, copy) NSString *percent;//认知率
@property (nonatomic, strong) LGFreeWordModel *words;
@property (nonatomic, copy) NSArray<LGSentenceModel *> *sentence;      //例句;
@property (nonatomic, copy) NSArray<LGSentenceModel *> *lowSentence;
@property (nonatomic, copy) NSArray<LGSimilarWordsModel *> *similarWords;
@property (nonatomic, strong) LGQuestionModel *question;
@property (nonatomic, assign) NSInteger did; //已背单词

/**
 自定义字段,用于背单词详情页tableview 的数据源
 */
@property (nonatomic, strong) NSMutableArray<LGWordDetailTableDataSource *> *dataSource;

@end

@interface LGSentenceModel : NSObject

@property (nonatomic, copy) NSString *english;
@property (nonatomic, copy) NSString *chinese;

/**
 自定义字段,拼接中文英文,替换掉 <vocab>标签
 */
@property (nonatomic, copy) NSString *englishAndChinese;

@end

@interface LGWordDetailTableDataSource  : NSObject

@property (nonatomic, copy)  NSString *sectionTitle;
@property (nonatomic, strong) NSMutableArray *cellContent;
@property (nonatomic, assign) LGWordDetailTableDataSourceType type;

@end


@interface LGQuestionModel : NSObject

@property (nonatomic, copy) NSString *question;
@property (nonatomic, copy) NSString *questionanswer;
@property (nonatomic, copy) NSArray<LGQuestionSelectItemModel *> *selectItemArr;
@property (nonatomic, copy) NSString *article;//文章
@end

@interface LGQuestionSelectItemModel : NSObject

//A. B. C. 
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *select;
//自定义字段，是否显示当前选项的对错
@property (nonatomic, assign) BOOL isShowRightOrWrong;

//自定义字段，是否是正确答案
@property (nonatomic, assign) BOOL isRightAnswer;

@end

@interface LGSimilarWordsModel : NSObject

@property (nonatomic, copy) NSString *word;
@property (nonatomic, copy) NSString *ID;

@end
