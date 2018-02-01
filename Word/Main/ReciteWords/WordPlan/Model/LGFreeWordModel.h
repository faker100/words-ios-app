//
//  LGFreeWordModel.h
//  Word
//
//  Created by Charles Cao on 2018/2/1.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LGFreewordStatus) {
	LGFreewordStatusNone,           //没背
	LGFreewordStatusKnow1,          //认识1
	LGFreewordStatusKnow2,     	    //认识2
	LGFreewordStatusIncognizance,   //不认识
	LGFreewordStatusVague,			//模糊
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
@property (nonatomic, assign) LGFreewordStatus firstStatus;

@end
