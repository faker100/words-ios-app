//
//  LGFreeWordModel.h
//  Word
//
//  Created by Charles Cao on 2018/2/1.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LGFreeWordStatus) {
	LGFreeWordStatusNone,           //没背
	LGFreeWordStatusKnow1,          //认识1
	LGFreeWordStatusKnow2,     	    //认识2
	LGFreeWordStatusIncognizance,   //不认识
	LGFreeWordStatusVague,			//模糊
};

//2.认识，3，不认识，4模糊

@interface LGFreeWordModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *word;
@property (nonatomic, strong) NSString *translate;		//翻译
@property (nonatomic, strong) NSString *phonetic_uk;
@property (nonatomic, strong) NSString *phonetic_us;
@property (nonatomic, strong) NSString *uk_audio;
@property (nonatomic, strong) NSString *us_audio;
@property (nonatomic, assign) LGFreeWordStatus firstStatus;

@end
