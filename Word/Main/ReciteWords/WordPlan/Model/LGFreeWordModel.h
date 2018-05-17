//
//  LGFreeWordModel.h
//  Word
//
//  Created by Charles Cao on 2018/2/1.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LGFreeWordModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *word;
@property (nonatomic, copy) NSString *translate;		//翻译
@property (nonatomic, copy) NSString *phonetic_uk;  //英式音标
@property (nonatomic, copy) NSString *phonetic_us;  //美式音标
@property (nonatomic, copy) NSString *uk_audio;    //英式音频
@property (nonatomic, copy) NSString *us_audio;    //美式音频
@property (nonatomic, copy) NSString *mnemonic; //单词详情 助记
@property (nonatomic, copy) NSString *level;
@property (nonatomic, assign) LGWordStatus firstStatus;

//自定义字段,默认返回美式音标,没有美式返回英式
@property (nonatomic, copy) NSString *phonetic;

//自定义字段,模式返回美式音频,没有美式返回英试;
@property (nonatomic, copy) NSString *audio;

@end
