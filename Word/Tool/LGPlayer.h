//
//  LGPlayer.h
//  Word
//
//  Created by Charles Cao on 2018/2/1.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, LGAudioType) {
	LGAudio_beginReciteWords, //开始背单词
	LGAudio_dim,    		  //模糊
	LGAudio_estimate_notKnow, //评估错误_不认识
	LGAudio_know, //评估正确_认识
	LGAudio_familiar,//熟识
	LGAudio_forget,//忘记
	LGAudio_now_pk,//立即 pk
	LGAudio_pk_win,// pk胜利
	LGAudio_pk_lose,// pk 失败
	
};


@interface LGPlayer : NSObject

+ (instancetype)sharedPlayer;

- (void)playWithUrl:(NSString *)url completion:(void(^)(LGError *error))finish;

- (void)playPkMusic;

- (void)stopPkMusic;

- (void)playWithAudioType:(LGAudioType) type;

@end
