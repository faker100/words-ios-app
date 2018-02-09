//
//  LGFreeWordModel.h
//  Word
//
//  Created by Charles Cao on 2018/2/1.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LGFreeWordModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *word;
@property (nonatomic, strong) NSString *translate;		//翻译
@property (nonatomic, strong) NSString *phonetic_uk;
@property (nonatomic, strong) NSString *phonetic_us;
@property (nonatomic, strong) NSString *uk_audio;
@property (nonatomic, strong) NSString *us_audio;
@property (nonatomic, strong) NSString *mnemonic; //单词详情 助记
@property (nonatomic, assign) LGWordStatus firstStatus;

@end
