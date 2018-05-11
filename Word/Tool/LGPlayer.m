//
//  LGPlayer.m
//  Word
//
//  Created by Charles Cao on 2018/2/1.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPlayer.h"
#import "NSObject+LGRequest.h"
#import "LGTool.h"
#import <AVFoundation/AVFoundation.h>
#import "LGUserManager.h"

@interface LGPlayer ()

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) AVAudioPlayer *pkPlayer;
@property (nonatomic, strong) AVAudioPlayer *buttonPlayer;

@end

@implementation LGPlayer


+ (instancetype)sharedPlayer {
	static LGPlayer *sharedPlayer = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedPlayer = [[LGPlayer alloc] init];
	});
	return sharedPlayer;
}

- (void)playWithUrl:(NSString *)url completion:(void(^)(LGError *error))finish{
	if (StringNotEmpty(url)) {
		__weak typeof(self) weakSelf = self;
		[self.request downloadAudioFile:url completion:^(NSURL *filePath, LGError *error) {
			if (error) {
				if (finish) finish(error);
			}else{
				NSError *playError;
				weakSelf.player = [[AVAudioPlayer alloc]initWithContentsOfURL:filePath error:&playError];
				[weakSelf.player play];
				if (finish) {
					finish( playError ? [[LGError alloc]initWithMessage:@"播放失败" type:LGAPPError] : nil );
				}
			}
		}];
	}
}

- (void)playWithAudioType:(LGAudioType) type{
	
	NSString *name = @"";
	switch (type) {
		case LGAudio_beginReciteWords:
			name = @"beginReciteWords";
			break;
		case LGAudio_dim:
			name = @"dim";
			break;
		case LGAudio_estimate_notKnow:
			name = @"estimate_notKnow";
			break;
		case LGAudio_familiar:
			name = @"familiar";
			break;
		case LGAudio_forget:
			name = @"forget";
			break;
		case LGAudio_now_pk:
			name = @"now_pk";
			break;
		case LGAudio_pk_win:
			name = @"pk_win";
			break;
		case LGAudio_pk_lose:
			name = @"pk_lose";
			break;
		case LGAudio_know:
			name = @"know";
			break;
		default:
			name = @"";
			break;
	}
	
	if (name.length == 0) {
		return;
	}
	
	NSString *soundPath = [[NSBundle mainBundle]pathForResource:name ofType:@"mp3"];
	NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
	//初始化播放器对象
	self.buttonPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
	[self.buttonPlayer play];
}

- (void)playPkMusic{
	__weak typeof(self) weakSelf = self;
	NSString *url = [LGUserManager shareManager].user.audio;
	if (url.length > 0) {
		[self.request downloadAudioFile:WORD_DOMAIN(url) completion:^(NSURL *filePath, LGError *error) {
			if (!error) {
				weakSelf.pkPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:filePath error:nil];
				weakSelf.pkPlayer.numberOfLoops = -1;
				[weakSelf.pkPlayer play];
			}
		}];
	}
}

- (void)stopPkMusic{
	if (self.pkPlayer) {
		[self.pkPlayer stop];
		self.pkPlayer = nil;
	}
}

@end
