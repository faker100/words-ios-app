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

@interface LGPlayer ()

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) AVAudioPlayer *pkPlayer;

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

- (void)playPkMusic{
	NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"music" withExtension:@"mp3"];
	self.pkPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:nil];
	[self.pkPlayer play];
	self.pkPlayer.numberOfLoops = -1;
	[self.pkPlayer play];
}

- (void)stopPkMusic{
	if (self.pkPlayer) {
		[self.pkPlayer stop];
		self.pkPlayer = nil;
	}
}

@end
