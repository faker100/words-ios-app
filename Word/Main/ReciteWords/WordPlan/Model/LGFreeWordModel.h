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
@property (nonatomic, copy) NSString *uk_audio;
@property (nonatomic, copy) NSString *us_audio;
@property (nonatomic, copy) NSString *mnemonic; //单词详情 助记
@property (nonatomic, assign) LGWordStatus firstStatus;

@end
